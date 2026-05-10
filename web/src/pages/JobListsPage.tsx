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

interface JobListing {
  id: string;
  jobId: string;
  title: string;
  agency: string;
  country: string;
  salary: string;
  status: "Pending" | "Approved" | "Rejected";
  submitted: string;
}

const JOB_LISTINGS: JobListing[] = [
  {
    id: "JOB-001",
    jobId: "JL-5847",
    title: "Construction Worker - Full Time",
    agency: "BuildRight Construction",
    country: "United Arab Emirates",
    salary: "AED 2,500 - 3,500/month",
    status: "Pending",
    submitted: "2024-03-08",
  },
  {
    id: "JOB-002",
    jobId: "JL-5846",
    title: "Domestic Helper",
    agency: "Home Services LLC",
    country: "Saudi Arabia",
    salary: "SAR 1,500 - 2,000/month",
    status: "Approved",
    submitted: "2024-03-07",
  },
  {
    id: "JOB-003",
    jobId: "JL-5845",
    title: "Professional Driver",
    agency: "Transport Solutions",
    country: "Qatar",
    salary: "QAR 2,000 - 2,800/month",
    status: "Pending",
    submitted: "2024-03-07",
  },
  {
    id: "JOB-004",
    jobId: "JL-5844",
    title: "Accountant",
    agency: "Finance Plus",
    country: "United Arab Emirates",
    salary: "AED 3,500 - 5,000/month",
    status: "Approved",
    submitted: "2024-03-06",
  },
  {
    id: "JOB-005",
    jobId: "JL-5843",
    title: "Healthcare Worker",
    agency: "Medical Care Centers",
    country: "Kuwait",
    salary: "KWD 400 - 600/month",
    status: "Pending",
    submitted: "2024-03-06",
  },
  {
    id: "JOB-006",
    jobId: "JL-5842",
    title: "IT Support Specialist",
    agency: "Tech Innovations",
    country: "Bahrain",
    salary: "BHD 500 - 700/month",
    status: "Approved",
    submitted: "2024-03-05",
  },
  {
    id: "JOB-007",
    jobId: "JL-5841",
    title: "Marketing Manager",
    agency: "Digital Solutions",
    country: "United Arab Emirates",
    salary: "AED 4,000 - 6,000/month",
    status: "Rejected",
    submitted: "2024-03-04",
  },
];

const COUNTRIES = [
  "All Countries",
  "United Arab Emirates",
  "Saudi Arabia",
  "Qatar",
  "Kuwait",
  "Bahrain",
];

const STATUSES = ["All Status", "Pending", "Approved", "Rejected"];
const NAV_ITEMS = ["Home", "Users", "Contents", "Job Lists", "System"];

// ── Badge Component ────────────────────────────────────────────────────────────

function StatusBadge({ status }: { status: "Pending" | "Approved" | "Rejected" }) {
  const badgeConfig = {
    Pending: { bgColor: "bg-[#FEF3C7]", textColor: "text-[#D97706]" },
    Approved: { bgColor: "bg-[#DCFCE7]", textColor: "text-[#15803D]" },
    Rejected: { bgColor: "bg-[#FEE2E2]", textColor: "text-[#DC2626]" },
  };

  const config = badgeConfig[status];

  return (
    <div
      className={`inline-flex items-center px-3 py-1.5 rounded-full w-fit text-[11px] font-medium ${config.bgColor} ${config.textColor}`}
    >
      {status}
    </div>
  );
}

// ── Sub-components ────────────────────────────────────────────────────────────

function JobCard({ job }: { job: JobListing }) {
  return (
    <div
      className="bg-white rounded-[16px] p-6 flex flex-col gap-4"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      {/* Header */}
      <div className="flex items-start justify-between gap-3">
        <div className="flex-1 min-w-0">
          <p className="text-[14px] font-semibold text-[#0D1B3E]">{job.jobId}</p>
          <Link
            to="#"
            className="text-[15px] font-semibold text-[#0D2B6B] hover:underline mt-1 block leading-snug"
          >
            {job.title}
          </Link>
        </div>
      </div>

      {/* Agency */}
      <p className="text-[13px] text-[#6B7280] font-normal">{job.agency}</p>

      {/* Meta Info */}
      <div className="space-y-2 text-[13px]">
        <div>
          <span className="font-normal text-[#6B7280]">Country:</span>{" "}
          <span className="font-semibold text-[#0D1B3E]">{job.country}</span>
        </div>
        <div>
          <span className="font-normal text-[#6B7280]">Salary:</span>{" "}
          <span className="font-semibold text-[#0D1B3E]">{job.salary}</span>
        </div>
        <div>
          <span className="font-normal text-[#6B7280]">Submitted:</span>{" "}
          <span className="font-semibold text-[#0D1B3E]">{job.submitted}</span>
        </div>
      </div>

      {/* Status Badge */}
      <StatusBadge status={job.status} />

      {/* Action Buttons */}
      <div className="flex gap-2.5 mt-2">
        {job.status === "Pending" ? (
          <>
            <button className="flex-1 px-4 py-2.5 rounded-full bg-[#0D2B6B] text-white text-[13px] font-semibold hover:bg-[#0D1B3E] transition-colors">
              Approve
            </button>
            <button className="flex-1 px-4 py-2.5 rounded-full bg-white border border-[#E5E7EB] text-[#0D1B3E] text-[13px] font-semibold hover:bg-[#F9FAFB] transition-colors">
              Review
            </button>
            <button className="flex-1 px-4 py-2.5 rounded-full bg-white border border-[#E5E7EB] text-[#0D1B3E] text-[13px] font-semibold hover:bg-[#F9FAFB] transition-colors">
              Remove
            </button>
          </>
        ) : (
          <>
            <button className="flex-1 px-4 py-2.5 rounded-full bg-white border border-[#E5E7EB] text-[#0D1B3E] text-[13px] font-semibold hover:bg-[#F9FAFB] transition-colors">
              View
            </button>
            <button className="flex-1 px-4 py-2.5 rounded-full bg-white border border-[#E5E7EB] text-[#0D1B3E] text-[13px] font-semibold hover:bg-[#F9FAFB] transition-colors">
              Remove
            </button>
          </>
        )}
      </div>
    </div>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function JobListsPage() {
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCountry, setSelectedCountry] = useState("All Countries");
  const [selectedStatus, setSelectedStatus] = useState("All Status");
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { signOut } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  async function handleSignOut() {
    await signOut();
    navigate(ROUTES.LOGIN, { replace: true });
  }

  const filteredJobs = JOB_LISTINGS.filter((job) => {
    const matchesSearch =
      job.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      job.jobId.toLowerCase().includes(searchQuery.toLowerCase()) ||
      job.agency.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesCountry =
      selectedCountry === "All Countries" || job.country === selectedCountry;
    const matchesStatus =
      selectedStatus === "All Status" || job.status === selectedStatus;

    return matchesSearch && matchesCountry && matchesStatus;
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
            Job List Overview
          </p>
          <h1 className="mt-3 text-[30px] font-bold text-[#0D1B3E]">Job Listing</h1>
          <p className="text-[14px] text-[#6B7280] mt-2 font-normal">
          Review and manage job listings submitted on the platform
          </p>
        </div>

        {/* Search & Filters */}
        <div className="flex flex-col gap-4 md:flex-row md:items-end md:gap-3">
          {/* Search */}
          <div className="relative flex-1 md:max-w-xs">
            <SearchIcon />
            <input
              type="text"
              placeholder="Search by title, job ID, or agency..."
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
          </div>
        </div>

        {/* Job Cards Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredJobs.map((job) => (
            <JobCard key={job.id} job={job} />
          ))}
        </div>

        {/* Empty State */}
        {filteredJobs.length === 0 && (
          <div className="text-center py-12">
            <p className="text-[16px] text-[#6B7280]">
              No job listings found matching your filters
            </p>
          </div>
        )}
      </main>
    </div>
  );
}