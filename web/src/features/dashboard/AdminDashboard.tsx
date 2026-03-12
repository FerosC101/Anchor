import { useState } from "react";

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

function FlagIcon() {
  return (
    <svg
      width="20"
      height="20"
      fill="currentColor"
      viewBox="0 0 24 24"
    >
      <path d="M3 3a1 1 0 0 1 1 1v2h18V4a1 1 0 1 1 0 2v2c0 .414.336.75.75.75.414 0 .75-.336.75-.75V4c0-1.105-.895-2-2-2H4c-1.105 0-2 .895-2 2v13c0 1.105.895 2 2 2h12.25v-2.75H5V6h14v7h2V4c0-1.105-.895-2-2-2H4c-1.105 0-2 .895-2 2z" />
    </svg>
  );
}

function CheckIcon() {
  return (
    <svg
      width="20"
      height="20"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
    </svg>
  );
}

function AlertIcon() {
  return (
    <svg
      width="20"
      height="20"
      fill="currentColor"
      viewBox="0 0 24 24"
    >
      <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z" />
    </svg>
  );
}

function UserIcon() {
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
        d="M12 14l9-5-9-5-9 5m0 0a2 2 0 100 4 2 2 0 000-4z"
      />
    </svg>
  );
}

function ShieldIcon() {
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
        d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
      />
    </svg>
  );
}

function BriefcaseIcon() {
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
        d="M20 7l-8-4-8 4m16 0l-8 4m0 0L4 7m8 4v10m8-17h2a2 2 0 012 2v12a2 2 0 01-2 2h-2m0-15V5a2 2 0 00-2-2h-2a2 2 0 00-2 2v3"
      />
    </svg>
  );
}

interface StatsCardProps {
  value: string | number;
  label: string;
  icon: React.ReactNode;
  highlighted?: boolean;
}

function StatsCard({ value, label, icon, highlighted = false }: StatsCardProps) {
  return (
    <div
      className={`rounded-2xl p-6 flex flex-col justify-between ${
        highlighted
          ? "bg-gradient-to-br from-purple-600 to-blue-700 text-white"
          : "bg-white border border-gray-200"
      }`}
    >
      <div className="flex justify-between items-start">
        <div>
          <div className={`text-4xl font-bold ${highlighted ? "" : "text-blue-700"}`}>
            {value}
          </div>
          <p className={`mt-2 text-sm ${highlighted ? "text-purple-100" : "text-gray-600"}`}>
            {label}
          </p>
        </div>
        <div className={`p-2 rounded-lg ${highlighted ? "bg-white/20" : "bg-gray-100"}`}>
          <div className={highlighted ? "text-white" : "text-gray-600"}>
            {icon}
          </div>
        </div>
      </div>
    </div>
  );
}

interface PendingActionProps {
  title: string;
  count: number;
  icon: React.ReactNode;
  actionLabel: string;
  actionIcon?: React.ReactNode;
}

function PendingActionCard({ title, count, icon, actionLabel, actionIcon }: PendingActionProps) {
  return (
    <div className="bg-white border border-gray-200 rounded-lg p-4 flex items-center justify-between hover:shadow-md transition-shadow">
      <div className="flex items-center gap-4">
        <div className="p-3 bg-blue-50 rounded-lg text-blue-600">
          {icon}
        </div>
        <div>
          <p className="text-gray-800 font-medium text-sm">{title}</p>
          <p className="text-gray-500 text-xs">{count} items</p>
        </div>
      </div>
      <button className="flex items-center gap-2 text-blue-600 hover:bg-blue-50 px-3 py-2 rounded-lg transition-colors">
        <span className="text-sm font-medium">{actionLabel}</span>
        {actionIcon && <div className="text-blue-600">{actionIcon}</div>}
      </button>
    </div>
  );
}

interface ActivityItemProps {
  type: "flagged" | "registered" | "risk" | "job" | "post";
  title: string;
  description: string;
  timestamp: string;
  actionLabel: string;
}

function ActivityItem({ type, title, description, timestamp, actionLabel }: ActivityItemProps) {
  const getIcon = () => {
    switch (type) {
      case "flagged":
        return <FlagIcon />;
      case "registered":
        return <UserIcon />;
      case "risk":
        return <AlertIcon />;
      case "job":
        return <BriefcaseIcon />;
      case "post":
        return <FlagIcon />;
      default:
        return null;
    }
  };

  const getColorClasses = () => {
    switch (type) {
      case "flagged":
        return "bg-red-50 text-red-600";
      case "registered":
        return "bg-green-50 text-green-600";
      case "risk":
        return "bg-yellow-50 text-yellow-600";
      case "job":
        return "bg-blue-50 text-blue-600";
      case "post":
        return "bg-orange-50 text-orange-600";
      default:
        return "bg-gray-50 text-gray-600";
    }
  };

  return (
    <div className="bg-white border border-gray-200 rounded-lg p-4 flex items-start gap-4 hover:shadow-md transition-shadow">
      <div className={`p-3 rounded-lg flex-shrink-0 ${getColorClasses()}`}>
        {getIcon()}
      </div>
      <div className="flex-1 min-w-0">
        <p className="text-gray-800 font-medium text-sm">{title}</p>
        <p className="text-gray-600 text-xs mt-1">{description}</p>
        <p className="text-gray-400 text-xs mt-2">{timestamp}</p>
      </div>
      <button className="text-blue-600 hover:bg-blue-50 px-3 py-2 rounded-lg transition-colors font-medium text-sm flex-shrink-0">
        {actionLabel}
      </button>
    </div>
  );
}

export default function AdminDashboard() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  const pendingActions = [
    {
      title: "Flagged Content Pending Review",
      count: 2,
      icon: <FlagIcon />,
      actionLabel: "Review",
    },
    {
      title: "Job Listings Awaiting Approve",
      count: 3,
      icon: <BriefcaseIcon />,
      actionLabel: "Review",
    },
    {
      title: "Unverified NGO Accounts",
      count: 2,
      icon: <ShieldIcon />,
      actionLabel: "Verify",
    },
    {
      title: "Active Risk Alerts",
      count: 3,
      icon: <AlertIcon />,
      actionLabel: "View",
    },
  ];

  const recentActivities = [
    {
      type: "flagged" as const,
      title: "Post Flagged",
      description: "*Urgent: Employer...",
      timestamp: "2024-03-08 14:30",
      actionLabel: "Review",
    },
    {
      type: "registered" as const,
      title: "User Registered",
      description: "Fatima Al-Mansouri",
      timestamp: "2024-03-08 10:15",
      actionLabel: "View",
    },
    {
      type: "risk" as const,
      title: "Risk Alert",
      description: "Unusual login pattern",
      timestamp: "2024-03-08 09:45",
      actionLabel: "Review",
    },
    {
      type: "job" as const,
      title: "Job Listing Submitted",
      description: "Construction Worker",
      timestamp: "2024-03-07 15:20",
      actionLabel: "Review",
    },
    {
      type: "post" as const,
      title: "Post Flagged",
      description: "*Make $5000/week...",
      timestamp: "2024-03-07 08:15",
      actionLabel: "Review",
    },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* ── Header ────────────────────────────────────────────────────────── */}
      <header className="bg-white border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            {/* Logo */}
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-gradient-to-br from-blue-600 to-purple-600 rounded-lg flex items-center justify-center">
                <span className="text-white font-bold text-lg">⚓</span>
              </div>
              <span className="text-xl font-bold text-blue-900">Anchor</span>
            </div>

            {/* Navigation - Desktop */}
            <nav className="hidden md:flex items-center gap-8">
              <a href="#" className="text-blue-700 font-semibold border-b-2 border-blue-700 pb-1">
                Home
              </a>
              <a href="#" className="text-gray-600 hover:text-gray-800 transition-colors">
                Users
              </a>
              <a href="#" className="text-gray-600 hover:text-gray-800 transition-colors">
                Contents
              </a>
              <a href="#" className="text-gray-600 hover:text-gray-800 transition-colors">
                Job Lists
              </a>
              <a href="#" className="text-gray-600 hover:text-gray-800 transition-colors">
                System
              </a>
            </nav>

            {/* Right Actions */}
            <div className="flex items-center gap-4">
              <button className="p-2 hover:bg-gray-100 rounded-lg transition-colors">
                <BellIcon />
              </button>
              <button
                onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
                className="md:hidden p-2 hover:bg-gray-100 rounded-lg transition-colors"
              >
                <MenuIcon />
              </button>
            </div>
          </div>

          {/* Navigation - Mobile */}
          {mobileMenuOpen && (
            <nav className="md:hidden mt-4 pt-4 border-t border-gray-200 flex flex-col gap-3">
              <a href="#" className="text-blue-700 font-semibold">
                Home
              </a>
              <a href="#" className="text-gray-600 hover:text-gray-800">
                Users
              </a>
              <a href="#" className="text-gray-600 hover:text-gray-800">
                Contents
              </a>
              <a href="#" className="text-gray-600 hover:text-gray-800">
                Job Lists
              </a>
              <a href="#" className="text-gray-600 hover:text-gray-800">
                System
              </a>
            </nav>
          )}
        </div>
      </header>

      {/* ── Main Content ──────────────────────────────────────────────────── */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Page Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Admin Dashboard</h1>
          <p className="text-gray-500 mt-2">
            Quick overview of platform status, pending actions, and recent activity
          </p>
        </div>

        {/* System Overview */}
        <section className="mb-8">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">System overview</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-6 gap-4">
            <StatsCard value="1,247" label="Total Users" icon={<UserIcon />} highlighted />
            <StatsCard value="23" label="Suspended Accounts" icon={<ShieldIcon />} highlighted />
            <StatsCard value="8" label="Pending NGO Verifications" icon={<CheckIcon />} highlighted />
            <StatsCard value="15" label="Flagged Posts" icon={<FlagIcon />} />
            <StatsCard value="42" label="Pending Job Approvals" icon={<BriefcaseIcon />} />
            <StatsCard value="5" label="Active Risk Alerts" icon={<AlertIcon />} />
          </div>
        </section>

        {/* Pending Actions & Recent Activity */}
        <section className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {/* Pending Actions */}
          <div>
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-semibold text-gray-900">Pending Actions</h2>
              <a href="#" className="text-blue-600 hover:text-blue-700 text-sm font-medium">
                View all →
              </a>
            </div>
            <div className="space-y-3">
              {pendingActions.map((action, idx) => (
                <PendingActionCard
                  key={idx}
                  title={action.title}
                  count={action.count}
                  icon={action.icon}
                  actionLabel={action.actionLabel}
                  actionIcon={<span>→</span>}
                />
              ))}
            </div>
          </div>

          {/* Recent Activity */}
          <div>
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-semibold text-gray-900">Recent Activity</h2>
              <a href="#" className="text-blue-600 hover:text-blue-700 text-sm font-medium">
                View all →
              </a>
            </div>
            <div className="space-y-3">
              {recentActivities.map((activity, idx) => (
                <ActivityItem
                  key={idx}
                  type={activity.type}
                  title={activity.title}
                  description={activity.description}
                  timestamp={activity.timestamp}
                  actionLabel={activity.actionLabel}
                />
              ))}
            </div>
          </div>
        </section>
      </main>
    </div>
  );
}
