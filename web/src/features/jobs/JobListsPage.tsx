import { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
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

function CalendarIcon() {
  return (
    <svg
      width="18"
      height="18"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
      <path d="M16 2v4M8 2v4M3 10h18" />
    </svg>
  );
}

interface JobListingCardProps {
  id: string;
  status: "Pending" | "Active" | "Approved";
  title: string;
  company: string;
  country: string;
  salary: string;
  submitted: string;
  onApprove: () => void;
  onRemove: () => void;
  onReview: () => void;
}

function JobListingCard({
  id,
  status,
  title,
  company,
  country,
  salary,
  submitted,
  onApprove,
  onRemove,
  onReview,
}: JobListingCardProps) {
  return (
    <div className="bg-white border border-slate-200 rounded-lg p-6 flex flex-col gap-4">
      {/* Header */}
      <div className="flex items-start justify-between">
        <div className="flex flex-col gap-1">
          <div className="flex items-center gap-2">
            <span className="text-sm font-semibold text-slate-700">{id}</span>
            <span className="inline-flex items-center gap-1 px-2 py-1 bg-yellow-50 text-yellow-700 rounded text-xs font-medium">
              {status}
            </span>
          </div>
        </div>
      </div>

      {/* Job Title and Company */}
      <div className="flex flex-col gap-1">
        <h3 className="text-sm font-semibold text-[#5B4FCB]">{title}</h3>
        <p className="text-xs text-slate-600">{company}</p>
      </div>

      {/* Job Details */}
      <div className="flex flex-col gap-2">
        <div>
          <p className="text-xs text-slate-600">Country:</p>
          <p className="text-sm font-medium text-slate-900">{country}</p>
        </div>
        <div>
          <p className="text-xs text-slate-600">Salary:</p>
          <p className="text-sm font-medium text-slate-900">{salary}</p>
        </div>
        <div>
          <p className="text-xs text-slate-600">Submitted:</p>
          <p className="text-sm font-medium text-slate-900">{submitted}</p>
        </div>
      </div>

      {/* Actions */}
      <div className="flex flex-col gap-3 pt-2">
        <button
          onClick={onApprove}
          className="w-full py-2 px-3 bg-[#5B4FCB] text-white rounded-lg font-medium text-sm hover:bg-[#4A3FC0] transition-colors"
        >
          Approve
        </button>
        <div className="flex gap-3">
          <button
            onClick={onRemove}
            className="flex-1 py-2 px-3 border border-slate-200 rounded-lg text-slate-700 font-medium text-sm hover:bg-slate-50 transition-colors"
          >
            Remove
          </button>
          <button
            onClick={onReview}
            className="flex-1 py-2 px-3 border border-slate-200 rounded-lg text-slate-700 font-medium text-sm hover:bg-slate-50 transition-colors"
          >
            Review
          </button>
        </div>
      </div>
    </div>
  );
}

const NAV_ITEMS = ["Home", "Users", "Contents", "Job Lists", "System"];

export default function JobListsPage() {
  const { user, signOut } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");

  // Determine the home URL based on user role
  const homeUrl = user?.role === USER_ROLE.ADMIN ? ROUTES.ADMIN : ROUTES.HOME;

  async function handleSignOut() {
    await signOut();
    navigate(ROUTES.LOGIN, { replace: true });
  }

  // Mock data for job listings
  const jobListings = [
    {
      id: "JOB-004",
      status: "Pending" as const,
      title: "Factory Worker",
      company: "Quick Hire Agency",
      country: "Malaysia",
      salary: "$200/month",
      submitted: "2026-03-09",
    },
    {
      id: "JOB-004",
      status: "Pending" as const,
      title: "Factory Worker",
      company: "Quick Hire Agency",
      country: "Malaysia",
      salary: "$200/month",
      submitted: "2026-03-09",
    },
    {
      id: "JOB-004",
      status: "Pending" as const,
      title: "Factory Worker",
      company: "Quick Hire Agency",
      country: "Malaysia",
      salary: "$200/month",
      submitted: "2026-03-09",
    },
    {
      id: "JOB-004",
      status: "Pending" as const,
      title: "Factory Worker",
      company: "Quick Hire Agency",
      country: "Malaysia",
      salary: "$200/month",
      submitted: "2026-03-09",
    },
    {
      id: "JOB-004",
      status: "Pending" as const,
      title: "Factory Worker",
      company: "Quick Hire Agency",
      country: "Malaysia",
      salary: "$200/month",
      submitted: "2026-03-09",
    },
    {
      id: "JOB-004",
      status: "Pending" as const,
      title: "Factory Worker",
      company: "Quick Hire Agency",
      country: "Malaysia",
      salary: "$200/month",
      submitted: "2026-03-09",
    },
  ];

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
                  className={`relative px-4 text-sm font-medium transition-colors h-full flex items-center ${
                    isActive
                      ? "text-[#5B4FCB]"
                      : "text-slate-500 hover:text-slate-800"
                  }`}
                >
                  {item}
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
              onClick={handleSignOut}
              className="hidden md:block text-sm text-slate-500 hover:text-slate-800 transition-colors ml-1"
            >
              Sign out
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
                  className={`text-left px-3 py-2.5 rounded-xl text-sm font-medium transition-colors ${isActive ? "bg-purple-50 text-[#5B4FCB]" : "text-slate-600 hover:bg-slate-50"}`}
                >
                  {item}
                </Link>
              );
            })}
            <button
              onClick={handleSignOut}
              className="text-left px-3 py-2.5 rounded-xl text-sm font-medium text-red-500 hover:bg-red-50 mt-1"
            >
              Sign out
            </button>
          </div>
        )}
      </header>

      {/* ── Page Content ── */}
      <main className="max-w-7xl mx-auto px-5 sm:px-8 py-8 space-y-8">
        {/* Page Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-slate-900">Job Listings</h1>
          <p className="text-slate-500 mt-2">System oversight and moderation</p>
        </div>

        {/* Search and Filters */}
        <div className="flex flex-col md:flex-row gap-5 items-start md:items-center">
          {/* Search */}
          <div className="w-full md:flex-1 md:min-w-[500px]">
            <div className="relative">
              <span className="absolute left-4 top-1/2 transform -translate-y-1/2 text-slate-400">
                <SearchIcon />
              </span>
              <input
                type="text"
                placeholder="Search job listings"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full pl-10 pr-4 py-3 border border-slate-200 rounded-full bg-white focus:outline-none focus:ring-2 focus:ring-[#5B4FCB] text-sm"
              />
            </div>
          </div>

          {/* Filters */}
          <div className="flex flex-wrap gap-3 md:gap-3 items-center w-full md:w-auto">
            {/* Countries Filter */}
            <div className="relative">
              <select className="px-4 py-3 border border-slate-200 rounded-full appearance-none bg-white cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#5B4FCB] pr-10 text-slate-700 text-sm font-medium">
                <option>All Countries</option>
                <option>Malaysia</option>
                <option>Singapore</option>
                <option>Thailand</option>
              </select>
              <span className="absolute right-3 top-1/2 transform -translate-y-1/2 text-slate-400 pointer-events-none">
                <ChevronDownIcon />
              </span>
            </div>

            {/* Status Filter */}
            <div className="relative">
              <select className="px-4 py-3 border border-slate-200 rounded-full appearance-none bg-white cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#5B4FCB] pr-10 text-slate-700 text-sm font-medium">
                <option>All Status</option>
                <option>Pending</option>
                <option>Active</option>
                <option>Approved</option>
              </select>
              <span className="absolute right-3 top-1/2 transform -translate-y-1/2 text-slate-400 pointer-events-none">
                <ChevronDownIcon />
              </span>
            </div>

            {/* Dates Filter */}
            <button className="flex items-center gap-2 px-4 py-3 border border-slate-200 rounded-full bg-white hover:bg-slate-50 transition-colors text-slate-700 text-sm font-medium">
              <CalendarIcon />
              <span>Dates</span>
            </button>
          </div>
        </div>

        {/* Job Count and Grid */}
        <div className="mb-8">
          {/* Job Count */}
          <h2 className="text-lg font-semibold text-slate-900 mb-6">
            Job Listings ({jobListings.length})
          </h2>

          {/* Job Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {jobListings.map((job, idx) => (
              <JobListingCard
                key={idx}
                id={job.id}
                status={job.status}
                title={job.title}
                company={job.company}
                country={job.country}
                salary={job.salary}
                submitted={job.submitted}
                onApprove={() => console.log("Approve:", job.id)}
                onRemove={() => console.log("Remove:", job.id)}
                onReview={() => console.log("Review:", job.id)}
              />
            ))}
          </div>
        </div>
      </main>
    </div>
  );
}
