import { useState } from "react";
import { useNavigate } from "react-router-dom";
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
        d="M4 6h16M4 12h16M4 18h16"
      />
    </svg>
  );
}

function ChevronRight({ size = 14 }: { size?: number }) {
  return (
    <svg
      width={size}
      height={size}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2.5}
    >
      <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
    </svg>
  );
}

function FlagIcon({ className }: { className?: string }) {
  return (
    <svg
      width="14"
      height="14"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
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
      width="14"
      height="14"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
      className={className}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
      />
    </svg>
  );
}

function PersonIcon({ className }: { className?: string }) {
  return (
    <svg
      width="14"
      height="14"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
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
      width="14"
      height="14"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
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
      width="14"
      height="14"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
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
  { value: "1,247", label: "Total Users", filled: true, dark: false },
  { value: "23", label: "Suspended Accounts", filled: true, dark: false },
  { value: "8", label: "Pending NGO\nVerifications", filled: true, dark: true },
  { value: "15", label: "Flagged Posts", filled: false, dark: false },
  { value: "42", label: "Pending Job Approvals", filled: false, dark: false },
  { value: "5", label: "Active Risk Alerts", filled: false, dark: false },
];

const PENDING_ACTIONS = [
  {
    icon: "flag",
    label: "Flagged Content Pending Review",
    sub: "2 items",
    count: 2,
    action: "Review",
    badgeColor: "bg-[#5B6BE8]",
  },
  {
    icon: "job",
    label: "Job Listings Awaiting Approval",
    sub: "2 items",
    count: 2,
    action: "Review",
    badgeColor: "bg-[#5B6BE8]",
  },
  {
    icon: "person",
    label: "Unverified NGO Accounts",
    sub: "2 items",
    count: 2,
    action: "Verify",
    badgeColor: "bg-[#5B6BE8]",
  },
  {
    icon: "alert",
    label: "Active Risk Alerts",
    sub: "3 active",
    count: 3,
    action: "View",
    badgeColor: "bg-orange-400",
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

function StatCard({
  value,
  label,
  filled,
  dark,
}: {
  value: string;
  label: string;
  filled: boolean;
  dark: boolean;
}) {
  if (filled) {
    return (
      <div
        className="rounded-2xl p-5 flex flex-col justify-between min-h-[110px]"
        style={{
          background: dark
            ? "linear-gradient(135deg, #5649C0 0%, #3D33A0 100%)"
            : "linear-gradient(135deg, #7B72D8 0%, #5B4FCB 100%)",
        }}
      >
        <p className="text-3xl font-bold text-white">{value}</p>
        <p className="text-white/75 text-xs leading-snug mt-2 whitespace-pre-line">
          {label}
        </p>
      </div>
    );
  }
  return (
    <div className="rounded-2xl p-5 bg-white border border-slate-200 flex flex-col justify-between min-h-[110px]">
      <p className="text-3xl font-bold text-[#4A3FC0]">{value}</p>
      <p className="text-slate-400 text-xs leading-snug mt-2">{label}</p>
    </div>
  );
}

function PendingIcon({ icon }: { icon: string }) {
  if (icon === "flag")
    return (
      <span className="w-8 h-8 rounded-lg bg-slate-100 flex items-center justify-center shrink-0">
        <FlagIcon className="text-slate-500" />
      </span>
    );
  if (icon === "job")
    return (
      <span className="w-8 h-8 rounded-lg bg-slate-100 flex items-center justify-center shrink-0">
        <JobIcon className="text-slate-500" />
      </span>
    );
  if (icon === "person")
    return (
      <span className="w-8 h-8 rounded-lg bg-slate-100 flex items-center justify-center shrink-0">
        <PersonIcon className="text-slate-500" />
      </span>
    );
  return (
    <span className="w-8 h-8 rounded-lg bg-orange-50 flex items-center justify-center shrink-0">
      <AlertTriangleIcon className="text-orange-400" />
    </span>
  );
}

function ActivityIcon({ icon }: { icon: string }) {
  if (icon === "flag")
    return (
      <span className="w-8 h-8 rounded-lg bg-purple-50 flex items-center justify-center shrink-0">
        <FlagIcon className="text-[#5B4FCB]" />
      </span>
    );
  if (icon === "person")
    return (
      <span className="w-8 h-8 rounded-lg bg-purple-50 flex items-center justify-center shrink-0">
        <PersonIcon className="text-[#5B4FCB]" />
      </span>
    );
  if (icon === "alert")
    return (
      <span className="w-8 h-8 rounded-lg bg-orange-50 flex items-center justify-center shrink-0">
        <AlertTriangleIcon className="text-orange-400" />
      </span>
    );
  return (
    <span className="w-8 h-8 rounded-lg bg-purple-50 flex items-center justify-center shrink-0">
      <BriefcaseIcon className="text-[#5B4FCB]" />
    </span>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function AdminDashboardPage() {
  const [activeNav, setActiveNav] = useState("Home");
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { signOut } = useAuth();
  const navigate = useNavigate();

  async function handleSignOut() {
    await signOut();
    navigate(ROUTES.LOGIN, { replace: true });
  }

  return (
    <div className="min-h-screen bg-[#F5F6FA]">
      {/* ── Top Navigation ── */}
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
              const isActive = activeNav === item;
              return (
                <button
                  key={item}
                  onClick={() => {
                    setActiveNav(item);
                    if (item === "Users") {
                      navigate(ROUTES.ADMIN_USERS);
                    }
                  }}
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
                </button>
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
            <button
              onClick={handleSignOut}
              className="hidden md:block text-sm text-slate-500 hover:text-slate-800 transition-colors ml-1"
            >
              Sign out
            </button>
          </div>
        </div>

        {/* Mobile nav drawer */}
        {mobileMenuOpen && (
          <div className="md:hidden border-t border-slate-100 bg-white px-5 py-3 flex flex-col gap-1">
            {NAV_ITEMS.map((item) => (
              <button
                key={item}
                onClick={() => {
                  setActiveNav(item);
                  setMobileMenuOpen(false);
                  if (item === "Users") {
                    navigate(ROUTES.ADMIN_USERS);
                  }
                }}
                className={`text-left px-3 py-2.5 rounded-xl text-sm font-medium transition-colors ${activeNav === item ? "bg-purple-50 text-[#5B4FCB]" : "text-slate-600 hover:bg-slate-50"}`}
              >
                {item}
              </button>
            ))}
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
        {/* Page title */}
        <div>
          <h1 className="text-[22px] font-bold text-slate-900">
            Admin Dashboard
          </h1>
          <p className="text-slate-400 text-sm mt-1">
            Quick overview of platform status, pending actions, and recent
            activity
          </p>
        </div>

        {/* System overview */}
        <section>
          <h2 className="text-[15px] font-semibold text-slate-800 mb-3">
            System overview
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3">
            {STAT_CARDS.map((card) => (
              <StatCard key={card.label} {...card} />
            ))}
          </div>
        </section>

        {/* Two-column layout */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">
          {/* Pending Actions */}
          <section className="bg-white rounded-2xl border border-slate-200 overflow-hidden">
            <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
              <h3 className="font-semibold text-slate-800 text-[15px]">
                Pending Actions
              </h3>
              <button className="text-sm text-slate-400 flex items-center gap-1 hover:text-slate-600 transition-colors">
                View all <ChevronRight />
              </button>
            </div>
            <div className="divide-y divide-slate-100">
              {PENDING_ACTIONS.map((item) => (
                <div
                  key={item.label}
                  className="flex items-center gap-3 px-5 py-3.5 hover:bg-slate-50 transition-colors"
                >
                  <PendingIcon icon={item.icon} />
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium text-slate-700 leading-snug">
                      {item.label}
                    </p>
                    <p className="text-xs text-slate-400 mt-0.5">{item.sub}</p>
                  </div>
                  <span
                    className={`w-6 h-6 rounded-full ${item.badgeColor} text-white text-xs font-bold flex items-center justify-center shrink-0`}
                  >
                    {item.count}
                  </span>
                  <button className="text-sm text-slate-500 hover:text-[#5B4FCB] flex items-center gap-0.5 transition-colors shrink-0 font-medium">
                    {item.action} <ChevronRight size={12} />
                  </button>
                </div>
              ))}
            </div>
          </section>

          {/* Recent Activity */}
          <section className="bg-white rounded-2xl border border-slate-200 overflow-hidden">
            <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
              <h3 className="font-semibold text-slate-800 text-[15px]">
                Recent Activity
              </h3>
              <button className="text-sm text-slate-400 flex items-center gap-1 hover:text-slate-600 transition-colors">
                View all <ChevronRight />
              </button>
            </div>
            <div className="divide-y divide-slate-100">
              {RECENT_ACTIVITY.map((item, i) => (
                <div
                  key={i}
                  className="flex items-center gap-3 px-5 py-3.5 hover:bg-slate-50 transition-colors"
                >
                  <ActivityIcon icon={item.icon} />
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-semibold text-[#5B4FCB] leading-snug">
                      {item.type}
                    </p>
                    <p className="text-xs text-slate-500 mt-0.5 truncate">
                      {item.desc}
                    </p>
                    <p className="text-xs text-slate-400 mt-0.5">{item.date}</p>
                  </div>
                  <button className="text-sm text-slate-500 hover:text-[#5B4FCB] font-medium transition-colors shrink-0">
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
