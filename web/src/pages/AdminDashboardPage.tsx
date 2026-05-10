import { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { ROUTES } from "../core/config/routes";
import { useAuth } from "../core/context/AuthContext";

// ── Icons ─────────────────────────────────────────────────────────────────────

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

function FlagIcon({ className }: { className?: string }) {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
      className={className}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M3 3v18M3 6l9-3 9 3-9 3-9-3z"
      />
    </svg>
  );
}

function JobIcon({ className }: { className?: string }) {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
      className={className}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m7 4v7a2 2 0 01-2 2H5a2 2 0 01-2-2v-7"
      />
    </svg>
  );
}

function PersonIcon({ className }: { className?: string }) {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
      className={className}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
      />
    </svg>
  );
}

function AlertTriangleIcon({ className }: { className?: string }) {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
      className={className}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 9v2m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"
      />
    </svg>
  );
}

function BriefcaseIcon({ className }: { className?: string }) {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.5}
      className={className}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
      />
    </svg>
  );
}

// ── Data ──────────────────────────────────────────────────────────────────────

const STAT_CARDS = [
  { value: "1,247", label: "Total Users", filled: true },
  { value: "23", label: "Suspended Accounts", filled: true },
  { value: "8", label: "Pending NGO Verifications", filled: true },
  { value: "15", label: "Flagged Posts", filled: false },
  { value: "42", label: "Pending Job Approvals", filled: false },
  { value: "5", label: "Active Risk Alerts", filled: false },
];

const PENDING_ACTIONS = [
  {
    icon: "flag",
    label: "Flagged Content Pending Review",
    sub: "2 items",
    count: 2,
    action: "Review",
    isAlert: false,
  },
  {
    icon: "job",
    label: "Job Listings Awaiting Approval",
    sub: "2 items",
    count: 2,
    action: "Review",
    isAlert: false,
  },
  {
    icon: "person",
    label: "Unverified NGO Accounts",
    sub: "2 items",
    count: 2,
    action: "Verify",
    isAlert: false,
  },
  {
    icon: "alert",
    label: "Active Risk Alerts",
    sub: "3 active",
    count: 3,
    action: "View",
    isAlert: true,
  },
];

const RECENT_ACTIVITY = [
  {
    icon: "flag",
    type: "Post Flagged",
    desc: '"Urgent: Employer...',
    date: "2024-03-08 14:30",
    action: "Review",
  },
  {
    icon: "person",
    type: "User Registered",
    desc: "Fatima Al-Mansoori",
    date: "2024-03-08 10:15",
    action: "View",
  },
  {
    icon: "alert",
    type: "Risk Alert",
    desc: "Unusual login pattern",
    date: "2024-03-08 09:45",
    action: "Review",
  },
  {
    icon: "briefcase",
    type: "Job Listing Submitted",
    desc: "Construction Worker",
    date: "2024-03-07 15:20",
    action: "Review",
  },
  {
    icon: "flag",
    type: "Post Flagged",
    desc: '"Make $5000/week...',
    date: "2024-03-07 09:15",
    action: "Review",
  },
];

const NAV_ITEMS = ["Home", "Users", "Contents", "Job Lists", "System"];

// ── Sub-components ────────────────────────────────────────────────────────────

function StatCard({ value, label, filled }: { value: string; label: string; filled: boolean }) {
  if (filled) {
    return (
      <div
        className="rounded-[16px] p-6 flex flex-col justify-between min-h-[110px] bg-[#0D2B6B]"
        style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
      >
        <p className="text-[30px] font-bold text-white">{value}</p>
        <p className="text-white/60 text-[14px] leading-tight mt-2">{label}</p>
      </div>
    );
  }
  return (
    <div
      className="rounded-[16px] p-6 bg-white flex flex-col justify-between min-h-[110px]"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      <p className="text-[30px] font-bold text-[#0D1B3E]">{value}</p>
      <p className="text-[#6B7280] text-[14px] leading-tight mt-2">{label}</p>
    </div>
  );
}

function PendingIcon({ icon, isAlert }: { icon: string; isAlert?: boolean }) {
  const bgColor = isAlert ? "bg-amber-100" : "bg-[#F3F4F6]";
  const textColor = isAlert ? "text-[#D97706]" : "text-[#6B7280]";

  if (icon === "flag")
    return (
      <span className={`w-9 h-9 rounded-lg ${bgColor} flex items-center justify-center shrink-0`}>
        <FlagIcon className={textColor} />
      </span>
    );
  if (icon === "job")
    return (
      <span className={`w-9 h-9 rounded-lg ${bgColor} flex items-center justify-center shrink-0`}>
        <JobIcon className={textColor} />
      </span>
    );
  if (icon === "person")
    return (
      <span className={`w-9 h-9 rounded-lg ${bgColor} flex items-center justify-center shrink-0`}>
        <PersonIcon className={textColor} />
      </span>
    );
  return (
    <span className={`w-9 h-9 rounded-lg ${bgColor} flex items-center justify-center shrink-0`}>
      <AlertTriangleIcon className={textColor} />
    </span>
  );
}

function ActivityIcon({ icon }: { icon: string }) {
  if (icon === "flag")
    return (
      <span className="w-9 h-9 rounded-lg bg-[#F3F4F6] flex items-center justify-center shrink-0">
        <FlagIcon className="text-[#6B7280]" />
      </span>
    );
  if (icon === "person")
    return (
      <span className="w-9 h-9 rounded-lg bg-[#F3F4F6] flex items-center justify-center shrink-0">
        <PersonIcon className="text-[#6B7280]" />
      </span>
    );
  if (icon === "alert")
    return (
      <span className="w-9 h-9 rounded-lg bg-amber-100 flex items-center justify-center shrink-0">
        <AlertTriangleIcon className="text-[#D97706]" />
      </span>
    );
  return (
    <span className="w-9 h-9 rounded-lg bg-[#F3F4F6] flex items-center justify-center shrink-0">
      <BriefcaseIcon className="text-[#6B7280]" />
    </span>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function AdminDashboardPage() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { signOut } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  async function handleSignOut() {
    await signOut();
    navigate(ROUTES.LOGIN, { replace: true });
  }

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
      <main className="max-w-7xl mx-auto px-5 sm:px-8 py-8 space-y-8">
        {/* Page title */}
        <div>
          <p
            className="text-[11px] font-semibold uppercase text-[#6B7280] tracking-[0.12em]"
            style={{ letterSpacing: "0.12em" }}
          >
            Admin Dashboard
          </p>
          <h1 className="mt-3 text-[30px] font-bold text-[#0D1B3E]">Welcome back</h1>
          <p className="text-[14px] text-[#6B7280] mt-2 font-normal">
            Quick overview of platform status, pending actions, and recent activity
          </p>
        </div>

        {/* System overview */}
        <section>
          <h2
            className="text-[11px] font-semibold uppercase text-[#6B7280] mb-4 tracking-[0.12em]"
            style={{ letterSpacing: "0.12em" }}
          >
            System overview
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-4">
            {STAT_CARDS.map((card) => (
              <StatCard key={card.label} {...card} />
            ))}
          </div>
        </section>

        {/* Two-column layout */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Pending Actions */}
          <section
            className="bg-white rounded-[16px] overflow-hidden"
            style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
          >
            <div className="flex items-center justify-between px-6 py-6 border-b border-[#F3F4F6]">
              <h3 className="font-semibold text-[#0D1B3E] text-[16px]">Pending Actions</h3>
              <button className="text-[14px] text-[#6B7280] flex items-center gap-1 hover:text-[#0D1B3E] transition-colors font-medium">
                View all <span>›</span>
              </button>
            </div>
            <div className="divide-y divide-[#F3F4F6]">
              {PENDING_ACTIONS.map((item) => (
                <div
                  key={item.label}
                  className="flex items-center gap-4 px-6 py-4 hover:bg-[#F9FAFB] transition-colors"
                >
                  <PendingIcon icon={item.icon} isAlert={item.isAlert} />
                  <div className="flex-1 min-w-0">
                    <p className="text-[14px] font-semibold text-[#0D1B3E] leading-snug">{item.label}</p>
                    <p className="text-[12px] text-[#9CA3AF] mt-0.5">{item.sub}</p>
                  </div>
                  <span
                    className={`w-6 h-6 rounded-full text-white text-[12px] font-bold flex items-center justify-center shrink-0 ${
                      item.isAlert ? "bg-[#D97706]" : "bg-[#0D2B6B]"
                    }`}
                  >
                    {item.count}
                  </span>
                  <button
                    className={`text-[14px] font-medium flex items-center gap-0.5 transition-colors shrink-0 ${
                      item.isAlert ? "text-[#D97706] hover:text-[#B45309]" : "text-[#0D1B3E] hover:text-[#0D2B6B]"
                    }`}
                  >
                    {item.action}
                  </button>
                </div>
              ))}
            </div>
          </section>

          {/* Recent Activity */}
          <section
            className="bg-white rounded-[16px] overflow-hidden"
            style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
          >
            <div className="flex items-center justify-between px-6 py-6 border-b border-[#F3F4F6]">
              <h3 className="font-semibold text-[#0D1B3E] text-[16px]">Recent Activity</h3>
              <button className="text-[14px] text-[#6B7280] flex items-center gap-1 hover:text-[#0D1B3E] transition-colors font-medium">
                View all <span>›</span>
              </button>
            </div>
            <div className="divide-y divide-[#F3F4F6]">
              {RECENT_ACTIVITY.map((item, i) => (
                <div
                  key={i}
                  className="flex items-center gap-4 px-6 py-4 hover:bg-[#F9FAFB] transition-colors"
                >
                  <ActivityIcon icon={item.icon} />
                  <div className="flex-1 min-w-0">
                    <p className="text-[14px] font-semibold text-[#0D2B6B] leading-snug">{item.type}</p>
                    <p className="text-[13px] text-[#374151] mt-0.5 truncate">{item.desc}</p>
                    <p className="text-[11px] text-[#9CA3AF] mt-0.5">{item.date}</p>
                  </div>
                  <button className="text-[14px] text-[#0D1B3E] hover:text-[#0D2B6B] font-medium transition-colors shrink-0">
                    {item.action}
                  </button>
                </div>
              ))}
            </div>
          </section>
        </div>
      </main>
    </div>
  );
}