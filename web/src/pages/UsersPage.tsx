import { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { ROUTES } from "../core/config/routes";
import { useAuth } from "../core/context/AuthContext";

// ── Icons ─────────────────────────────────────────────────────────────────────

function SearchIcon() {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
      className="absolute left-3 top-1/2 transform -translate-y-1/2 text-[#6B7280]"
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
      />
    </svg>
  );
}

function ChevronDownIcon() {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
      className="absolute right-3 top-1/2 transform -translate-y-1/2 pointer-events-none text-[#6B7280]"
    >
      <path strokeLinecap="round" strokeLinejoin="round" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
    </svg>
  );
}

function BellIcon() {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
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
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M4 6h16M4 12h16M4 18h16"
      />
    </svg>
  );
}

// ── Data ──────────────────────────────────────────────────────────────────────

interface User {
  id: string;
  name: string;
  avatar: string;
  email: string;
  country: string;
  status: "Active" | "Verified" | "Inactive";
  registered: string;
  role: "Worker" | "NGO" | "Employer";
}

const USERS: User[] = [
  {
    id: "USR-001",
    name: "Ahmed Hassan",
    avatar: "AH",
    email: "ahmed.hassan@email.com",
    country: "United Arab Emirates",
    status: "Active",
    registered: "2026-02-15",
    role: "Worker",
  },
  {
    id: "USR-002",
    name: "Fatima Al-Mansoori",
    avatar: "FM",
    email: "fatima.mansoori@ngo.org",
    country: "United Arab Emirates",
    status: "Verified",
    registered: "2026-01-20",
    role: "NGO",
  },
  {
    id: "USR-003",
    name: "Mohammed Al-Mazrouei",
    avatar: "MM",
    email: "m.mazrouei@email.com",
    country: "United Arab Emirates",
    status: "Active",
    registered: "2026-03-01",
    role: "Worker",
  },
  {
    id: "USR-004",
    name: "Layla Al-Shamsi",
    avatar: "LS",
    email: "layla.shamsi@company.com",
    country: "Saudi Arabia",
    status: "Verified",
    registered: "2025-12-10",
    role: "Employer",
  },
  {
    id: "USR-005",
    name: "Khalid Al-Ketbi",
    avatar: "KA",
    email: "khalid.ketbi@email.com",
    country: "United Arab Emirates",
    status: "Active",
    registered: "2026-02-28",
    role: "Worker",
  },
  {
    id: "USR-006",
    name: "Zainab Al-Naqbi",
    avatar: "ZN",
    email: "zainab.naqbi@ngo.org",
    country: "Qatar",
    status: "Verified",
    registered: "2026-01-05",
    role: "NGO",
  },
];

const COUNTRIES = [
  "All Countries",
  "United Arab Emirates",
  "Saudi Arabia",
  "Qatar",
  "Bahrain",
  "Kuwait",
];

const STATUSES = ["All Status", "Active", "Verified", "Inactive"];
const ROLES = ["All Roles", "Worker", "NGO", "Employer"];
const NAV_ITEMS = ["Home", "Users", "Contents", "Job Lists", "System"];

// ── Badge Component ───────────────────────────────────────────────────────────

function StatusBadge({ status }: { status: "Active" | "Verified" | "Inactive" }) {
  const badgeConfig = {
    Active: { bgColor: "bg-[#DCFCE7]", textColor: "text-[#15803D]", dotColor: "bg-[#15803D]" },
    Verified: { bgColor: "bg-[#EEF2FF]", textColor: "text-[#0D2B6B]", dotColor: "bg-[#0D2B6B]" },
    Inactive: { bgColor: "bg-[#F3F4F6]", textColor: "text-[#6B7280]", dotColor: "bg-[#6B7280]" },
  };

  const config = badgeConfig[status];

  return (
    <div
      className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full w-fit text-[11px] font-medium ${config.bgColor} ${config.textColor}`}
    >
      <span className={`w-1.5 h-1.5 rounded-full ${config.dotColor}`} />
      {status}
    </div>
  );
}

// ── Sub-components ────────────────────────────────────────────────────────────

function UserCard({ user }: { user: User }) {
  return (
    <div
      className="bg-white rounded-[16px] p-6 flex flex-col gap-4"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      {/* Avatar & Name */}
      <div className="flex items-start gap-3">
        <div className="w-10 h-10 rounded-[8px] bg-[#0D2B6B] flex items-center justify-center shrink-0">
          <span className="text-white text-[14px] font-bold">{user.avatar}</span>
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-[15px] font-semibold text-[#0D1B3E]">{user.name}</p>
          <p className="text-[12px] text-[#9CA3AF] mt-0.5">{user.id}</p>
        </div>
      </div>

      {/* Status Badge */}
      <StatusBadge status={user.status} />

      {/* Meta Info */}
      <div className="space-y-2.5">
        <div>
          <p className="text-[13px] text-[#6B7280] font-normal">Country</p>
          <p className="text-[13px] font-semibold text-[#0D1B3E] mt-0.5">{user.country}</p>
        </div>
        <div>
          <p className="text-[13px] text-[#6B7280] font-normal">Registered</p>
          <p className="text-[13px] font-semibold text-[#0D1B3E] mt-0.5">{user.registered}</p>
        </div>
      </div>

      {/* Action Buttons */}
      <div className="grid grid-cols-2 gap-2.5 mt-2">
        <button className="px-4 py-2.5 rounded-full bg-white border border-[#E5E7EB] text-[13px] font-medium text-[#0D1B3E] hover:bg-[#F9FAFB] transition-colors">
          View Profile
        </button>
        {user.status === "Verified" ? (
          <button
            disabled
            className="px-4 py-2.5 rounded-full bg-[#0D2B6B] text-white text-[13px] font-medium opacity-75 cursor-not-allowed"
          >
            Verified
          </button>
        ) : (
          <button className="px-4 py-2.5 rounded-full bg-[#0D2B6B] text-white text-[13px] font-medium hover:bg-[#0D1B3E] transition-colors">
            Verify
          </button>
        )}
      </div>
    </div>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function UsersPage() {
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCountry, setSelectedCountry] = useState("All Countries");
  const [selectedStatus, setSelectedStatus] = useState("All Status");
  const [selectedRole, setSelectedRole] = useState("All Roles");
  const [activeTab, setActiveTab] = useState<"workers" | "ngo">("workers");
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { signOut } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  async function handleSignOut() {
    await signOut();
    navigate(ROUTES.LOGIN, { replace: true });
  }

  const filteredUsers = USERS.filter((user) => {
    const matchesSearch =
      user.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      user.email.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesCountry =
      selectedCountry === "All Countries" || user.country === selectedCountry;
    const matchesStatus =
      selectedStatus === "All Status" || user.status === selectedStatus;
    const matchesRole = selectedRole === "All Roles" || user.role === selectedRole;
    const matchesTab =
      (activeTab === "workers" && (user.role === "Worker" || user.role === "Employer")) ||
      (activeTab === "ngo" && user.role === "NGO");

    return (
      matchesSearch && matchesCountry && matchesStatus && matchesRole && matchesTab
    );
  });

  return (
    <div className="min-h-screen bg-[#EDEEF2]" style={{ fontFamily: "Inter, sans-serif" }}>
      {/* ── Top Navigation ── */}
      <header className="bg-white sticky top-0 z-20">
        <div className="max-w-7xl mx-auto px-5 sm:px-8 h-16 flex items-center gap-6 justify-between">
          {/* Logo */}
          <div className="flex items-center gap-2.5 shrink-0">
            <div className="w-10 h-10 rounded-full bg-[#0D2B6B] flex items-center justify-center">
              <div className="w-3.5 h-3.5 rounded-full bg-white" />
            </div>
            <span className="text-[20px] font-bold text-[#0D1B3E] tracking-tight">
              Anchor
            </span>
          </div>

          {/* Desktop center nav */}
          <nav className="hidden md:flex items-stretch gap-1 h-full">
            {NAV_ITEMS.map((item) => {
              const isActive =
                (item === "Home" && location.pathname === ROUTES.ADMIN) ||
                (item === "Users" && location.pathname === ROUTES.ADMIN_USERS) ||
                (item === "Contents" && location.pathname === ROUTES.ADMIN_CONTENTS) ||
                (item === "Job Lists" && location.pathname === ROUTES.ADMIN_JOB_LISTS) ||
                (item === "System" && location.pathname === ROUTES.ADMIN_SYSTEM);
              return (
                <Link
                  key={item}
                  to={
                    item === "Users"
                      ? ROUTES.ADMIN_USERS
                      : item === "Contents"
                        ? ROUTES.ADMIN_CONTENTS
                        : item === "Job Lists"
                          ? ROUTES.ADMIN_JOB_LISTS
                          : item === "System"
                            ? ROUTES.ADMIN_SYSTEM
                            : item === "Home"
                              ? ROUTES.ADMIN
                              : "#"
                  }
                  className={`relative px-4 text-[15px] font-medium transition-colors h-full flex items-center ${
                    isActive ? "text-[#1A1A2E]" : "text-[#6B7280] hover:text-[#1A1A2E]"
                  }`}
                >
                  {item}
                  {isActive && (
                    <span
                      className="absolute bottom-0 left-0 right-0 bg-[#0D2B6B] rounded-full"
                      style={{ height: "2px" }}
                    />
                  )}
                </Link>
              );
            })}
          </nav>

          {/* Right icons */}
          <div className="flex items-center gap-4 text-[#6B7280] shrink-0">
            <button className="hover:text-[#0D1B3E] transition-colors p-1">
              <BellIcon />
            </button>
            <button
              className="md:hidden hover:text-[#0D1B3E] transition-colors p-1"
              onClick={() => setMobileMenuOpen((v) => !v)}
            >
              <MenuIcon />
            </button>
            <button
              onClick={handleSignOut}
              className="hidden md:block text-[15px] text-[#6B7280] hover:text-[#0D1B3E] transition-colors font-medium"
            >
              Sign out
            </button>
          </div>
        </div>

        {/* Mobile nav drawer */}
        {mobileMenuOpen && (
          <div className="md:hidden border-t border-[#E5E7EB] bg-white px-5 py-3 flex flex-col gap-1">
            {NAV_ITEMS.map((item) => {
              const isActive =
                (item === "Home" && location.pathname === ROUTES.ADMIN) ||
                (item === "Users" && location.pathname === ROUTES.ADMIN_USERS) ||
                (item === "Contents" && location.pathname === ROUTES.ADMIN_CONTENTS) ||
                (item === "Job Lists" && location.pathname === ROUTES.ADMIN_JOB_LISTS) ||
                (item === "System" && location.pathname === ROUTES.ADMIN_SYSTEM);
              return (
                <Link
                  key={item}
                  to={
                    item === "Users"
                      ? ROUTES.ADMIN_USERS
                      : item === "Contents"
                        ? ROUTES.ADMIN_CONTENTS
                        : item === "Job Lists"
                          ? ROUTES.ADMIN_JOB_LISTS
                          : item === "System"
                            ? ROUTES.ADMIN_SYSTEM
                            : item === "Home"
                              ? ROUTES.ADMIN
                              : "#"
                  }
                  onClick={() => setMobileMenuOpen(false)}
                  className={`text-left px-3 py-2.5 rounded-lg text-[15px] font-medium transition-colors ${
                    isActive
                      ? "bg-[#F3F4F6] text-[#0D2B6B]"
                      : "text-[#374151] hover:bg-[#F9FAFB]"
                  }`}
                >
                  {item}
                </Link>
              );
            })}
            <button
              onClick={handleSignOut}
              className="text-left px-3 py-2.5 rounded-lg text-[15px] font-medium text-red-600 hover:bg-red-50 mt-1"
            >
              Sign out
            </button>
          </div>
        )}
      </header>

      {/* ── Page Content ── */}
      <main className="max-w-7xl mx-auto px-5 sm:px-8 py-8 space-y-6">
        {/* Page Title */}
        <div>
          <p
            className="text-[11px] font-semibold uppercase text-[#6B7280] tracking-[0.12em]"
            style={{ letterSpacing: "0.12em" }}
          >
            System User Overview
          </p>
          <h1 className="mt-3 text-[30px] font-bold text-[#0D1B3E]">User Management</h1>
          <p className="text-[14px] text-[#6B7280] mt-2 font-normal">
            View, manage, and verify user accounts across the platform
          </p>
        </div>

        {/* Search & Filters */}
        <div className="flex flex-col gap-4 md:flex-row md:items-end md:gap-3">
          {/* Search */}
          <div className="relative flex-1 md:max-w-xs">
            <SearchIcon />
            <input
              type="text"
              placeholder="Search by name or email..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-10 pr-4 py-2.5 rounded-full text-[14px] text-[#0D1B3E] placeholder-[#6B7280] focus:outline-none focus:ring-2 focus:ring-[#0D2B6B] focus:ring-offset-1 bg-white"
              style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
            />
          </div>

          {/* Filters */}
          <div className="flex flex-wrap gap-3">
            {/* Country */}
            <div className="relative">
              <select
                value={selectedCountry}
                onChange={(e) => setSelectedCountry(e.target.value)}
                className="appearance-none px-4 py-2.5 bg-white rounded-[8px] text-[14px] font-medium text-[#0D1B3E] cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#0D2B6B] focus:ring-offset-1 pr-10"
                style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
              >
                {COUNTRIES.map((country) => (
                  <option key={country} value={country}>
                    {country}
                  </option>
                ))}
              </select>
              <ChevronDownIcon />
            </div>

            {/* Status */}
            <div className="relative">
              <select
                value={selectedStatus}
                onChange={(e) => setSelectedStatus(e.target.value)}
                className="appearance-none px-4 py-2.5 bg-white rounded-[8px] text-[14px] font-medium text-[#0D1B3E] cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#0D2B6B] focus:ring-offset-1 pr-10"
                style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
              >
                {STATUSES.map((status) => (
                  <option key={status} value={status}>
                    {status}
                  </option>
                ))}
              </select>
              <ChevronDownIcon />
            </div>

            {/* Role */}
            <div className="relative">
              <select
                value={selectedRole}
                onChange={(e) => setSelectedRole(e.target.value)}
                className="appearance-none px-4 py-2.5 bg-white rounded-[8px] text-[14px] font-medium text-[#0D1B3E] cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#0D2B6B] focus:ring-offset-1 pr-10"
                style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
              >
                {ROLES.map((role) => (
                  <option key={role} value={role}>
                    {role}
                  </option>
                ))}
              </select>
              <ChevronDownIcon />
            </div>
          </div>
        </div>

        {/* Tabs */}
        <div className="flex gap-3">
          <button
            onClick={() => setActiveTab("workers")}
            className={`px-4 py-3 text-[14px] font-medium rounded-[8px] transition-all ${
              activeTab === "workers"
                ? "text-white bg-[#0D2B6B]"
                : "text-[#6B7280] hover:text-[#0D1B3E]"
            }`}
          >
            Workers & Employers
          </button>
          <button
            onClick={() => setActiveTab("ngo")}
            className={`px-4 py-3 text-[14px] font-medium rounded-[8px] transition-all ${
              activeTab === "ngo"
                ? "text-white bg-[#0D2B6B]"
                : "text-[#6B7280] hover:text-[#0D1B3E]"
            }`}
          >
            NGO Verification Queue
          </button>
        </div>

        {/* Users Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredUsers.map((user) => (
            <UserCard key={user.id} user={user} />
          ))}
        </div>

        {/* Empty State */}
        {filteredUsers.length === 0 && (
          <div className="text-center py-12">
            <p className="text-[16px] text-[#6B7280]">No users found matching your filters</p>
          </div>
        )}
      </main>
    </div>
  );
}