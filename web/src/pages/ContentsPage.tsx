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

function BellIcon({ hasNotification = false }: { hasNotification?: boolean }) {
  return (
    <div className="relative">
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
      {hasNotification && (
        <span className="absolute -top-1 -right-1 w-2.5 h-2.5 bg-red-500 rounded-full" />
      )}
    </div>
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

interface ContentItem {
  id: string;
  postId: string;
  title: string;
  author: string;
  status: "Pending" | "In Review" | "Submitted" | "High Risk" | "Medium Risk";
  reportCount: number;
  date: string;
  riskLevel?: "High" | "Medium" | "Low";
}

const CONTENTS: ContentItem[] = [
  {
    id: "CNT-001",
    postId: "POST-5847",
    title: "Job Posting - Construction Worker",
    author: "Ahmed Hassan",
    status: "In Review",
    reportCount: 2,
    date: "2024-03-08",
  },
  {
    id: "CNT-002",
    postId: "POST-5846",
    title: "Urgent: Need Domestic Help",
    author: "Fatima Al-Mansoori",
    status: "High Risk",
    reportCount: 5,
    date: "2024-03-08",
    riskLevel: "High",
  },
  {
    id: "CNT-003",
    postId: "POST-5845",
    title: "Professional Services Available",
    author: "Mohammed Al-Mazrouei",
    status: "Pending",
    reportCount: 0,
    date: "2024-03-07",
  },
  {
    id: "CNT-004",
    postId: "POST-5844",
    title: "Make $5000/week Working from Home",
    author: "Unknown User",
    status: "Medium Risk",
    reportCount: 8,
    date: "2024-03-07",
    riskLevel: "Medium",
  },
  {
    id: "CNT-005",
    postId: "POST-5843",
    title: "Driver Needed - Full Time",
    author: "Layla Al-Shamsi",
    status: "Submitted",
    reportCount: 1,
    date: "2024-03-06",
  },
  {
    id: "CNT-006",
    postId: "POST-5842",
    title: "NGO Recruitment Drive",
    author: "Zainab Al-Naqbi",
    status: "Pending",
    reportCount: 0,
    date: "2024-03-06",
  },
];

const STATUSES = ["All Status", "Pending", "In Review", "Submitted", "High Risk", "Medium Risk"];
const NAV_ITEMS = ["Home", "Users", "Contents", "Job Lists", "System"];

// ── Sub-components ────────────────────────────────────────────────────────────

function ContentCard({ content }: { content: ContentItem }) {
  const statusConfig = {
    Pending: {
      bgColor: "bg-[#FEF3C7]",
      textColor: "text-[#D97706]",
    },
    "In Review": {
      bgColor: "bg-[#EEF2FF]",
      textColor: "text-[#0D2B6B]",
    },
    Submitted: {
      bgColor: "bg-[#FEF3C7]",
      textColor: "text-[#D97706]",
    },
    "High Risk": {
      bgColor: "bg-[#FEE2E2]",
      textColor: "text-[#DC2626]",
    },
    "Medium Risk": {
      bgColor: "bg-[#FEF3C7]",
      textColor: "text-[#D97706]",
    },
  };

  const config = statusConfig[content.status];

  return (
    <div
      className="bg-white rounded-[14px] p-5 flex flex-col gap-4"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      {/* Header */}
      <div className="flex items-start justify-between gap-3">
        <div className="flex-1 min-w-0">
          <p className="text-[14px] font-semibold text-[#0D1B3E]">{content.title}</p>
          <p className="text-[12px] text-[#9CA3AF] mt-1">{content.postId}</p>
        </div>
        <div
          className={`inline-flex items-center px-2.5 py-1 rounded-full text-[11px] font-medium ${config.bgColor} ${config.textColor} shrink-0`}
        >
          {content.status}
        </div>
      </div>

      {/* Meta Info */}
      <div className="space-y-2 text-[13px]">
        <p className="text-[#6B7280]">
          <span className="font-medium text-[#0D1B3E]">Author:</span> {content.author}
        </p>
        <p className="text-[#6B7280]">
          <span className="font-medium text-[#0D1B3E]">Reports:</span> {content.reportCount}
        </p>
        <p className="text-[#9CA3AF]">{content.date}</p>
      </div>

      {/* Action Buttons */}
      <div className="flex gap-2.5 mt-2">
        <button className="flex-1 px-3 py-2 rounded-full bg-[#0D2B6B] text-white text-[12px] font-semibold hover:bg-[#0D1B3E] transition-colors">
          Review
        </button>
        <button className="flex-1 px-3 py-2 rounded-full bg-white border border-[#0D2B6B] text-[#0D2B6B] text-[12px] font-semibold hover:bg-[#F9FAFB] transition-colors">
          Remove
        </button>
      </div>
    </div>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function ContentsPage() {
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedStatus, setSelectedStatus] = useState("All Status");
  const [activeTab, setActiveTab] = useState<"all" | "flagged">("all");
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { signOut } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  async function handleSignOut() {
    await signOut();
    navigate(ROUTES.LOGIN, { replace: true });
  }

  const filteredContents = CONTENTS.filter((content) => {
    const matchesSearch =
      content.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      content.postId.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesStatus =
      selectedStatus === "All Status" || content.status === selectedStatus;
    const matchesTab =
      (activeTab === "all") ||
      (activeTab === "flagged" && (content.status === "High Risk" || content.status === "Medium Risk"));

    return matchesSearch && matchesStatus && matchesTab;
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
                      className="absolute bottom-0 left-0 right-0 h-0.5 bg-[#0D2B6B] rounded-full"
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
              <BellIcon hasNotification={true} />
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
            Content Moderation
          </p>
          <h1 className="mt-3 text-[28px] font-bold text-[#0D1B3E]">Content Management</h1>
          <p className="text-[14px] text-[#6B7280] mt-2 font-normal">
            Review, monitor, and manage user-generated content across the platform
          </p>
        </div>

        {/* Search & Filters */}
        <div className="flex flex-col gap-4 md:flex-row md:items-end md:gap-3">
          {/* Search */}
          <div className="relative flex-1 md:max-w-xs">
            <SearchIcon />
            <input
              type="text"
              placeholder="Search by title or post ID..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-10 pr-4 py-2.5 rounded-full text-[14px] text-[#0D1B3E] placeholder-[#6B7280] focus:outline-none focus:ring-2 focus:ring-[#0D2B6B] focus:ring-offset-1 bg-white"
              style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
            />
          </div>

          {/* Status Filter */}
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

        {/* Tabs */}
        <div className="border-b border-[#E5E7EB] flex gap-3">
          <button
            onClick={() => setActiveTab("all")}
            className={`px-4 py-3 text-[14px] font-medium rounded-[8px] transition-all ${
              activeTab === "all"
                ? "text-white bg-[#0D2B6B]"
                : "text-[#6B7280] hover:text-[#0D1B3E]"
            }`}
          >
            All Content
          </button>
          <button
            onClick={() => setActiveTab("flagged")}
            className={`px-4 py-3 text-[14px] font-medium rounded-[8px] transition-all ${
              activeTab === "flagged"
                ? "text-white bg-[#0D2B6B]"
                : "text-[#6B7280] hover:text-[#0D1B3E]"
            }`}
          >
            Flagged Content
          </button>
        </div>

        {/* Content Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {filteredContents.map((content) => (
            <ContentCard key={content.id} content={content} />
          ))}
        </div>

        {/* Empty State */}
        {filteredContents.length === 0 && (
          <div className="text-center py-12">
            <p className="text-[16px] text-[#6B7280]">No content found matching your filters</p>
          </div>
        )}
      </main>
    </div>
  );
}