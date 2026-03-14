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

function LightningIcon() {
  return (
    <svg
      width="16"
      height="16"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M13 10V3L4 14h7v7l9-11h-7z"
      />
    </svg>
  );
}

function TargetIcon() {
  return (
    <svg
      width="16"
      height="16"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 8c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-3.31 0-6 2.69-6 6s2.69 6 6 6 6-2.69 6-6-2.69-6-6-6z"
      />
    </svg>
  );
}

function PersonIcon() {
  return (
    <svg
      width="16"
      height="16"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
      />
    </svg>
  );
}

function ChartIcon() {
  return (
    <svg
      width="16"
      height="16"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"
      />
    </svg>
  );
}

function AlertIcon() {
  return (
    <svg
      width="16"
      height="16"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 9v2m0 4v2m-6-4a6 6 0 0112 0z"
      />
    </svg>
  );
}

function RobotIcon() {
  return (
    <svg
      width="16"
      height="16"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9 3h6v2H9V3zm-2 2h10a2 2 0 012 2v10a2 2 0 01-2 2h-1v4h-6v-4H9a2 2 0 01-2-2V7a2 2 0 012-2zm3 6a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm3 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"
      />
    </svg>
  );
}

// ── Data ──────────────────────────────────────────────────────────────────────

const NAV_ITEMS = ["Home", "Users", "Contents", "Job Lists", "System"];

const TABS = ["AI Activity", "Usage Metrics", "Risk Alerts", "Error Logs"];

// ── Sub-components ────────────────────────────────────────────────────────────

function TabButton({
  label,
  isActive,
  onClick,
}: {
  label: string;
  isActive: boolean;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className={`px-5 py-3 font-medium text-sm border-b-2 transition-colors ${
        isActive
          ? "text-[#5B4FCB] border-b-[#5B4FCB]"
          : "text-slate-500 border-b-transparent hover:text-slate-700"
      }`}
    >
      {label}
    </button>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function SystemPage() {
  const { user, signOut } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [activeTab, setActiveTab] = useState("AI Activity");

  // Determine the home URL based on user role
  const homeUrl = user?.role === USER_ROLE.ADMIN ? ROUTES.ADMIN : ROUTES.HOME;

  async function handleSignOut() {
    await signOut();
    navigate(ROUTES.LOGIN, { replace: true });
  }

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
                (item === "Contents" &&
                  location.pathname === ROUTES.ADMIN_CONTENTS) ||
                (item === "Job Lists" &&
                  location.pathname === ROUTES.ADMIN_JOB_LISTS) ||
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
                (item === "Contents" &&
                  location.pathname === ROUTES.ADMIN_CONTENTS) ||
                (item === "Job Lists" &&
                  location.pathname === ROUTES.ADMIN_JOB_LISTS) ||
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
        {/* Page title */}
        <div>
          <h1 className="text-3xl font-bold text-slate-900">
            System Monitoring
          </h1>
          <p className="text-slate-500 mt-2">
            Monitor system health, AI activity, and platform metrics
          </p>
        </div>

        {/* Tabs */}
        <div className="flex gap-0 border-b border-slate-200">
          {TABS.map((tab) => (
            <TabButton
              key={tab}
              label={tab}
              isActive={activeTab === tab}
              onClick={() => setActiveTab(tab)}
            />
          ))}
        </div>

        {/* Tab Content */}
        <div className="space-y-6">
          {activeTab === "AI Activity" && (
            <div className="space-y-6">
              <h2 className="text-lg font-semibold text-slate-900">
                AI Activity Log
              </h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                {[
                  {
                    type: "content",
                    title: "Content Analysis",
                    id: "Post: P002",
                    desc: "Flagged as high-risk scam (confidence 54%)",
                    date: "2024-03-08 15:22",
                  },
                  {
                    type: "pattern",
                    title: "Pattern Detection",
                    id: "Job: J002",
                    desc: "Suspicious salary pattern detected",
                    date: "2024-03-08 15:10",
                  },
                  {
                    type: "user",
                    title: "User Behavior Analysis",
                    id: "User: U003",
                    desc: "Normal activity pattern confirmed",
                    date: "2024-03-08 08:15",
                  },
                  {
                    type: "chart",
                    title: "Content Analysis",
                    id: "Post: P004",
                    desc: "Promotional content detected (confidence 70%)",
                    date: "2024-03-07 18:40",
                  },
                  {
                    type: "alert",
                    title: "Risk Score Update",
                    id: "User: U005",
                    desc: "Risk score increased to 8.5/10",
                    date: "2024-03-08 14:45",
                  },
                  {
                    type: "robot",
                    title: "Auto-moderation",
                    id: "Post: P004",
                    desc: "Content auto-removed for illegal activity",
                    date: "2024-03-08 11:30",
                  },
                ].map((item, idx) => {
                  const getIconColor = (type: string) => {
                    const colors: { [key: string]: string } = {
                      content: "bg-purple-100 text-[#5B4FCB]",
                      pattern: "bg-blue-100 text-blue-600",
                      user: "bg-green-100 text-green-600",
                      chart: "bg-purple-100 text-[#5B4FCB]",
                      alert: "bg-orange-100 text-orange-600",
                      robot: "bg-indigo-100 text-indigo-600",
                    };
                    return colors[type] || "bg-slate-100 text-slate-600";
                  };

                  const getIcon = (type: string) => {
                    switch (type) {
                      case "content":
                        return <LightningIcon />;
                      case "pattern":
                        return <TargetIcon />;
                      case "user":
                        return <PersonIcon />;
                      case "chart":
                        return <ChartIcon />;
                      case "alert":
                        return <AlertIcon />;
                      case "robot":
                        return <RobotIcon />;
                      default:
                        return null;
                    }
                  };

                  return (
                    <div
                      key={idx}
                      className="bg-white rounded-2xl border border-slate-200 p-5 hover:shadow-md transition-shadow"
                    >
                      <div className="flex gap-4">
                        <div
                          className={`flex-shrink-0 w-12 h-12 rounded-xl flex items-center justify-center ${getIconColor(
                            item.type
                          )}`}
                        >
                          {getIcon(item.type)}
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="font-semibold text-slate-900 text-sm">
                            {item.title}
                          </p>
                          <p className="text-xs text-slate-500 mt-1">
                            {item.id}
                          </p>
                          <p className="text-sm text-slate-600 mt-2">
                            {item.desc}
                          </p>
                          <p className="text-xs text-slate-400 mt-3">
                            {item.date}
                          </p>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          )}

          {activeTab === "Usage Metrics" && (
            <div className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
                {[
                  {
                    title: "Active Sessions",
                    value: "342",
                    change: "+12% from yesterday",
                  },
                  {
                    title: "API Call Volume",
                    value: "15,678",
                    change: "+8% from yesterday",
                  },
                  {
                    title: "Records Processed Today",
                    value: "4,521",
                    change: "+15% from yesterday",
                  },
                ].map((metric, idx) => (
                  <div
                    key={idx}
                    className="bg-white rounded-2xl border border-slate-200 p-6"
                  >
                    <p className="text-slate-500 text-sm font-medium">
                      {metric.title}
                    </p>
                    <p className="text-3xl font-bold text-[#5B4FCB] mt-2">
                      {metric.value}
                    </p>
                    <p className="text-sm text-green-600 mt-2">
                      {metric.change}
                    </p>
                  </div>
                ))}
              </div>

              <div className="bg-white rounded-2xl border border-slate-200 p-6 space-y-4">
                <h3 className="font-semibold text-slate-900">
                  System Performance
                </h3>
                <div className="h-64 bg-slate-50 rounded-lg flex items-center justify-center text-slate-400">
                  Performance Graph (Chart)
                </div>
              </div>

              <div className="bg-white rounded-2xl border border-slate-200 p-6 space-y-4">
                <h3 className="font-semibold text-slate-900">
                  Resource Usage
                </h3>
                {[
                  { label: "CPU Usage", value: 42 },
                  { label: "Memory Usage", value: 67 },
                  { label: "Database Load", value: 55 },
                ].map((resource, idx) => (
                  <div key={idx} className="space-y-2">
                    <div className="flex justify-between">
                      <span className="text-sm font-medium text-slate-700">
                        {resource.label}
                      </span>
                      <span className="text-sm font-medium text-slate-700">
                        {resource.value}%
                      </span>
                    </div>
                    <div className="w-full bg-slate-200 rounded-full h-2">
                      <div
                        className="bg-[#5B4FCB] h-2 rounded-full"
                        style={{ width: `${resource.value}%` }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {activeTab === "Risk Alerts" && (
            <div className="space-y-6">
              <h2 className="text-lg font-semibold text-slate-900">
                Active Risk Alerts (1)
              </h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                {[
                  {
                    id: "RA001",
                    title: "Unusual Login Pattern",
                    desc: "Multiple failed login attempts from different geographic locations for user U005",
                    severity: "Urgent",
                    severityColor: "red",
                    timestamp: "Triggered: 2024-03-08 14:00",
                    actions: ["Acknowledge", "Faculate", "Mark Resolved"],
                  },
                  {
                    id: "RA002",
                    title: "Content Spike",
                    desc: "Unusual increase in flagged content (300% above baseline)",
                    severity: "Critical",
                    severityColor: "red",
                    timestamp: "Triggered: 2024-03-08 14:00",
                    actions: ["Escalate", "Resolve"],
                  },
                  {
                    id: "RA003",
                    title: "Fraudulent Job Posting",
                    desc: "Multiple job postings with suspicious payment terms",
                    severity: "Critical",
                    severityColor: "red",
                    timestamp: "Triggered: 2024-03-08 13:30",
                    actions: ["Mark Resolved"],
                  },
                  {
                    id: "RA005",
                    title: "API Rate Limit Exceeded",
                    desc: "Single IP address exceeded API rate limit by 250%",
                    severity: "Low",
                    severityColor: "blue",
                    timestamp: "Triggered: 2024-03-08 12:30",
                    actions: ["Escalate", "Resolve"],
                  },
                ].map((alert, idx) => {
                  const getSeverityStyles = (color: string) => {
                    if (color === "red") return "bg-red-100 text-red-700";
                    if (color === "orange") return "bg-orange-100 text-orange-700";
                    if (color === "blue") return "bg-blue-100 text-blue-700";
                    return "bg-slate-100 text-slate-700";
                  };

                  return (
                    <div
                      key={idx}
                      className="bg-white rounded-2xl border border-slate-200 p-5 flex flex-col"
                    >
                      <div className="flex items-start gap-3 mb-4">
                        <div className="flex gap-2">
                          <span
                            className={`text-xs font-bold px-2.5 py-1 rounded ${getSeverityStyles(
                              alert.severityColor
                            )}`}
                          >
                            {alert.id}
                          </span>
                          <span
                            className={`text-xs font-bold px-2.5 py-1 rounded ${getSeverityStyles(
                              alert.severityColor
                            )}`}
                          >
                            {alert.severity}
                          </span>
                        </div>
                      </div>

                      <h3 className="font-semibold text-slate-900 mb-2">
                        {alert.title}
                      </h3>

                      <p className="text-sm text-slate-600 mb-3">
                        {alert.desc}
                      </p>

                      <p className="text-xs text-slate-400 mb-4">
                        {alert.timestamp}
                      </p>

                      <div className="flex flex-wrap gap-2 mt-auto">
                        {alert.actions.map((action, actionIdx) => (
                          <button
                            key={actionIdx}
                            className={`px-4 py-2 text-sm font-medium rounded-lg transition-colors ${
                              actionIdx === 0
                                ? "bg-[#5B4FCB] text-white hover:bg-[#4A3FAA]"
                                : "border border-slate-300 text-slate-700 hover:bg-slate-50"
                            }`}
                          >
                            {action}
                          </button>
                        ))}
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          )}

          {activeTab === "Error Logs" && (
            <div className="space-y-4">
              <h2 className="text-lg font-semibold text-slate-900">
                Recent Error Logs
              </h2>
              {[
                {
                  title: "Database Connection Timeout",
                  category: "User Management",
                  desc: "Connection pool exhausted during peak traffic.",
                  date: "2024-03-08 18:30",
                  status: "Investigating",
                },
                {
                  title: "Image Upload Failure",
                  category: "Content Upload",
                  desc: "S3 bucket permissions issue - fixed by updating IAM policy",
                  date: "2024-03-01 12:15",
                  status: "Resolved",
                },
                {
                  title: "Email Service Error",
                  category: "Notifications",
                  desc: "SMTP server temporarily unavailable",
                  date: "2024-03-07 08:45",
                  status: "Resolved",
                },
                {
                  title: "Payment Gateway Error",
                  category: "Job Posting Payment",
                  desc: "Transaction declined - insufficient error handling",
                  date: "2024-03-07 14:22",
                  status: "New",
                },
                {
                  title: "Cache Invalidation Error",
                  category: "Content Moderation",
                  desc: "Redis cache key mismatch causing stale data",
                  date: "2024-03-08 11:30",
                  status: "Resolved",
                },
              ].map((log, idx) => (
                <div
                  key={idx}
                  className="bg-white rounded-2xl border border-slate-200 p-5"
                >
                  <div className="flex items-start justify-between gap-4">
                    <div className="flex-1">
                      <p className="font-semibold text-[#5B4FCB]">
                        {log.title}
                      </p>
                      <p className="text-sm text-slate-500 mt-1">
                        {log.category}
                      </p>
                      <p className="text-sm text-slate-600 mt-2">
                        {log.desc}
                      </p>
                      <p className="text-xs text-slate-400 mt-3">
                        {log.date}
                      </p>
                    </div>
                    <span
                      className={`text-xs font-semibold px-3 py-1 rounded-full whitespace-nowrap ${
                        log.status === "Resolved"
                          ? "bg-green-100 text-green-700"
                          : log.status === "Investigating"
                            ? "bg-yellow-100 text-yellow-700"
                            : "bg-red-100 text-red-700"
                      }`}
                    >
                      {log.status}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </main>
    </div>
  );
}
