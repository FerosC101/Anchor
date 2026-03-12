import { useState } from "react";
import { Link } from "react-router-dom";
import { ROUTES } from "../../core/config/routes";
import { useAuth } from "../../core/context/AuthContext";
import { USER_ROLE } from "../../types/user";

// ── Icons ────────────────────────────────────────────────────────────────────

function BellIcon() {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.8}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 00-5-5.917V4a1 1 0 10-2 0v1.083A6 6 0 006 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
      />
    </svg>
  );
}

function MenuIcon() {
  return (
    <svg
      width="22"
      height="22"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.8}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M4 6h16M4 12h16M4 18h16"
      />
    </svg>
  );
}

function SearchIcon() {
  return (
    <svg
      width="18"
      height="18"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <circle cx="11" cy="11" r="8" />
      <path strokeLinecap="round" d="M21 21l-4.35-4.35" />
    </svg>
  );
}

function ChevronDownIcon() {
  return (
    <svg
      width="16"
      height="16"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path strokeLinecap="round" strokeLinejoin="round" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
    </svg>
  );
}

function SlidersIcon() {
  return (
    <svg
      width="18"
      height="18"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <line x1="4" y1="6" x2="4" y2="6" />
      <line x1="20" y1="18" x2="20" y2="18" />
      <path d="M4 6h16M4 12h8m4 6h4" />
    </svg>
  );
}

interface UserCardProps {
  initials: string;
  name: string;
  userId: string;
  country: string;
  registered: string;
  status: "Active" | "Inactive";
  verified?: boolean;
  onViewProfile: () => void;
  onVerify: () => void;
}

function UserCard({
  initials,
  name,
  userId,
  country,
  registered,
  status,
  verified = false,
  onViewProfile,
  onVerify,
}: UserCardProps) {
  return (
    <div className="bg-white border border-slate-200 rounded-lg p-6 flex flex-col gap-4">
      {/* Header with initials and badges */}
      <div className="flex items-start justify-between">
        <div className="flex items-start gap-3">
          <div className="w-12 h-12 rounded-lg bg-gradient-to-br from-[#5B4FCB] to-[#3D33A0] flex items-center justify-center text-white font-bold text-sm">
            {initials}
          </div>
          <div className="flex flex-col gap-1">
            <h3 className="font-semibold text-slate-900 text-sm">{name}</h3>
            <p className="text-slate-500 text-xs">{userId}</p>
          </div>
        </div>
      </div>

      {/* Badges */}
      <div className="flex gap-2">
        <span className="inline-flex items-center gap-1 px-2 py-1 bg-green-50 text-green-700 rounded text-xs font-medium">
          <span className="w-2 h-2 bg-green-500 rounded-full"></span>
          {status}
        </span>
        {verified && (
          <span className="inline-flex items-center gap-1 px-2 py-1 bg-purple-50 text-[#5B4FCB] rounded text-xs font-medium">
            <span className="w-2 h-2 bg-[#5B4FCB] rounded-full"></span>
            Verified
          </span>
        )}
      </div>

      {/* Info */}
      <div className="flex flex-col gap-2 text-sm">
        <div>
          <p className="text-slate-600">Country:</p>
          <p className="text-slate-900 font-medium">{country}</p>
        </div>
        <div>
          <p className="text-slate-600">Registered:</p>
          <p className="text-slate-900 font-medium">{registered}</p>
        </div>
      </div>

      {/* Buttons */}
      <div className="flex gap-3 pt-2">
        <button
          onClick={onViewProfile}
          className="flex-1 py-2 px-3 border border-slate-200 rounded-lg text-slate-700 font-medium text-sm hover:bg-slate-50 transition-colors"
        >
          View Profile
        </button>
        <button
          onClick={onVerify}
          className="flex-1 py-2 px-3 bg-[#5B4FCB] text-white rounded-lg font-medium text-sm hover:bg-[#4A3FC0] transition-colors"
        >
          Verify
        </button>
      </div>
    </div>
  );
}

interface TabButtonProps {
  label: string;
  isActive: boolean;
  onClick: () => void;
}

function TabButton({ label, isActive, onClick }: TabButtonProps) {
  return (
    <button
      onClick={onClick}
      className={`px-6 py-2 font-semibold text-sm ${
        isActive
          ? "bg-[#5B4FCB] text-white rounded-t-lg"
          : "text-slate-700 border border-slate-200"
      }`}
    >
      {label}
    </button>
  );
}

export default function UsersPage() {
  const { user } = useAuth();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [activeTab, setActiveTab] = useState<"workers" | "ngo">("workers");
  const [searchQuery, setSearchQuery] = useState("");

  // Determine the home URL based on user role
  const homeUrl = user?.role === USER_ROLE.ADMIN ? ROUTES.ADMIN : ROUTES.HOME;

  // Mock data for workers
  const workers = [
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-001",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-006",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-008",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-003",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-009",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-010",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
  ];

  // Mock data for NGOs
  const ngos = [
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-003",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-008",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-003",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-003",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-008",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
    {
      initials: "MS",
      name: "Migrant Support Network",
      userId: "USR-003",
      country: "Middle East",
      registered: "2026-03-01",
      status: "Active" as const,
      verified: true,
    },
  ];

  const displayUsers = activeTab === "workers" ? workers : ngos;

  return (
    <div className="min-h-screen bg-[#F5F6FA]">
      {/* ── Header ────────────────────────────────────────────────────────── */}
      <header className="bg-white border-b border-slate-200 sticky top-0 z-20">
        <div className="max-w-7xl mx-auto px-5 sm:px-8 h-16 flex items-center gap-6 justify-between">
          {/* Logo */}
          <div className="flex items-center gap-2.5 shrink-0">
            <div className="w-10 h-10 rounded-full bg-[#5B4FCB] flex items-center justify-center">
              <div className="w-3.5 h-3.5 rounded-full bg-white" />
            </div>
            <span className="text-[20px] font-bold text-slate-800 tracking-tight">
              Anchor
            </span>
          </div>

          {/* Desktop center nav */}
          <nav className="hidden md:flex items-stretch gap-1 h-full">
            {[
              { label: "Home", onClick: () => { setMobileMenuOpen(false); } },
              { label: "Users", onClick: () => { setMobileMenuOpen(false); } },
              { label: "Contents", onClick: () => { setMobileMenuOpen(false); } },
              { label: "Job Lists", onClick: () => { setMobileMenuOpen(false); } },
              { label: "System", onClick: () => { setMobileMenuOpen(false); } },
            ].map((item) => {
              const isActive = (item.label === "Home" && !location.pathname.includes("/users")) || 
                               (item.label === "Users" && location.pathname.includes("/users"));
              return (
                <Link
                  key={item.label}
                  to={item.label === "Users" ? ROUTES.ADMIN_USERS : item.label === "Home" ? homeUrl : "#"}
                  className={`relative px-4 text-sm font-medium transition-colors h-full flex items-center ${
                    isActive
                      ? "text-[#5B4FCB]"
                      : "text-slate-500 hover:text-slate-800"
                  }`}
                >
                  {item.label}
                  {isActive && (
                    <span className="absolute bottom-0 left-0 right-0 h-0.5 bg-[#5B4FCB] rounded-full" />
                  )}
                </Link>
              );
            })}
          </nav>

          {/* Right icons */}
          <div className="flex items-center gap-3 text-slate-400 shrink-0">
            <button className="hover:text-slate-600 transition-colors p-1">
              <BellIcon />
            </button>
            <button
              className="md:hidden hover:text-slate-600 transition-colors p-1"
              onClick={() => setMobileMenuOpen((v) => !v)}
            >
              <MenuIcon />
            </button>
          </div>
        </div>

        {/* Mobile nav drawer */}
        {mobileMenuOpen && (
          <div className="md:hidden border-t border-slate-100 bg-white px-5 py-3 flex flex-col gap-1">
            {[
              { label: "Home", onClick: () => { setMobileMenuOpen(false); } },
              { label: "Users", onClick: () => { setMobileMenuOpen(false); } },
              { label: "Contents", onClick: () => { setMobileMenuOpen(false); } },
              { label: "Job Lists", onClick: () => { setMobileMenuOpen(false); } },
              { label: "System", onClick: () => { setMobileMenuOpen(false); } },
            ].map((item) => {
              const isActive = (item.label === "Home" && !location.pathname.includes("/users")) || 
                               (item.label === "Users" && location.pathname.includes("/users"));
              return (
                <Link
                  key={item.label}
                  to={item.label === "Users" ? ROUTES.ADMIN_USERS : item.label === "Home" ? homeUrl : "#"}
                  onClick={item.onClick}
                  className={`text-left px-3 py-2.5 rounded-xl text-sm font-medium transition-colors ${isActive ? "bg-purple-50 text-[#5B4FCB]" : "text-slate-600 hover:bg-slate-50"}`}
                >
                  {item.label}
                </Link>
              );
            })}
          </div>
        )}
      </header>

      {/* ── Page Content ── */}
      <main className="max-w-7xl mx-auto px-5 sm:px-8 py-8 space-y-8">
        {/* Page Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-slate-900">User Management</h1>
          <p className="text-slate-500 mt-2">
            Manage user accounts, verification, and access control
          </p>
        </div>

        {/* Search and Filters */}
        <div className="bg-white rounded-lg border border-slate-200 p-6 mb-8">
          <div className="flex flex-col lg:flex-row gap-4">
            {/* Search */}
            <div className="flex-1">
              <div className="relative">
                <SearchIcon />
                <input
                  type="text"
                  placeholder="Search worker by name or case ID"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  className="w-full pl-10 pr-4 py-3 border border-slate-200 rounded-full focus:outline-none focus:ring-2 focus:ring-[#5B4FCB]"
                />
              </div>
            </div>

            {/* Filters */}
            <div className="flex flex-col sm:flex-row gap-3">
              {/* Countries Filter */}
              <div className="relative">
                <select className="w-full sm:w-48 px-4 py-3 border border-slate-200 rounded-full appearance-none bg-white cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#5B4FCB] pr-10 text-slate-700">
                  <option>All Countries</option>
                  <option>Middle East</option>
                  <option>Southeast Asia</option>
                  <option>East Africa</option>
                </select>
                <ChevronDownIcon />
              </div>

              {/* Status Filter */}
              <div className="relative">
                <select className="w-full sm:w-48 px-4 py-3 border border-slate-200 rounded-full appearance-none bg-white cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#5B4FCB] pr-10 text-slate-700">
                  <option>All Status</option>
                  <option>Active</option>
                  <option>Inactive</option>
                  <option>Suspended</option>
                </select>
                <ChevronDownIcon />
              </div>

              {/* Roles Filter */}
              <button className="flex items-center gap-2 px-4 py-3 border border-slate-200 rounded-full hover:bg-slate-50 transition-colors text-slate-700">
                <SlidersIcon />
                <span className="text-sm font-medium">Roles</span>
              </button>
            </div>
          </div>
        </div>

        {/* Tabs and Content */}
        <div className="mb-8">
          <div className="flex gap-0 border-b border-slate-200 mb-6">
            <TabButton
              label="Workers"
              isActive={activeTab === "workers"}
              onClick={() => setActiveTab("workers")}
            />
            <TabButton
              label="NGO Verification Queue"
              isActive={activeTab === "ngo"}
              onClick={() => setActiveTab("ngo")}
            />
          </div>

          {/* User Count */}
          <h2 className="text-lg font-semibold text-slate-900 mb-6">
            Users ({displayUsers.length})
          </h2>

          {/* Users Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {displayUsers.map((user, idx) => (
              <UserCard
                key={idx}
                initials={user.initials}
                name={user.name}
                userId={user.userId}
                country={user.country}
                registered={user.registered}
                status={user.status}
                verified={user.verified}
                onViewProfile={() => console.log("View profile:", user.userId)}
                onVerify={() => console.log("Verify:", user.userId)}
              />
            ))}
          </div>
        </div>
      </main>
    </div>
  );
}
