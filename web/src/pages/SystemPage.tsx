import { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { ROUTES } from "../core/config/routes";
import { useAuth } from "../core/context/AuthContext";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";

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

function CheckCircleIcon({ className }: { className?: string }) {
  return (
    <svg
      width="20"
      height="20"
      fill="currentColor"
      viewBox="0 0 24 24"
      className={className}
    >
      <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z" />
    </svg>
  );
}

function AlertCircleIcon({ className }: { className?: string }) {
  return (
    <svg
      width="20"
      height="20"
      fill="currentColor"
      viewBox="0 0 24 24"
      className={className}
    >
      <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z" />
    </svg>
  );
}

// ── Data ──────────────────────────────────────────────────────────────────────

interface AIActivity {
  id: string;
  type: "detection" | "flagged" | "resolved";
  title: string;
  refId: string;
  description: string;
  timestamp: string;
}

interface UsageMetric {
  label: string;
  value: number;
  delta: number;
  percentage: number;
}

interface RiskAlert {
  id: string;
  title: string;
  description: string;
  severity: "Urgent" | "Critical" | "Low";
  timestamp: string;
}

interface ErrorLog {
  id: string;
  title: string;
  module: string;
  description: string;
  status: "Investigating" | "Resolved" | "New";
  timestamp: string;
}

interface ResourceUsage {
  label: string;
  value: number;
}

const AI_ACTIVITIES: AIActivity[] = [
  {
    id: "1",
    type: "detection",
    title: "Content Anomaly Detected",
    refId: "DET-2847",
    description: "Potential policy violation in job posting",
    timestamp: "2024-03-08 14:32",
  },
  {
    id: "2",
    type: "flagged",
    title: "User Behavior Flagged",
    refId: "FLAG-2846",
    description: "Unusual account activity pattern detected",
    timestamp: "2024-03-08 13:15",
  },
  {
    id: "3",
    type: "resolved",
    title: "Issue Resolved",
    refId: "RES-2845",
    description: "Previously flagged content verified as safe",
    timestamp: "2024-03-08 12:00",
  },
  {
    id: "4",
    type: "detection",
    title: "Fraud Pattern Identified",
    refId: "DET-2844",
    description: "Suspicious payment transaction detected",
    timestamp: "2024-03-08 11:45",
  },
];

const USAGE_METRICS: UsageMetric[] = [
  { label: "Active Sessions", value: 2847, delta: 142, percentage: 65 },
  { label: "API Call Volume", value: 45230, delta: 3240, percentage: 80 },
  { label: "Records Processed Today", value: 158942, delta: 12450, percentage: 92 },
];

const RISK_ALERTS: RiskAlert[] = [
  {
    id: "RA001",
    title: "Suspicious Account Creation Spike",
    description: "500+ accounts created in last 2 hours from same IP range",
    severity: "Urgent",
    timestamp: "2024-03-08 15:20",
  },
  {
    id: "RA002",
    title: "Payment Gateway Error Rate High",
    description: "Error rate exceeded 15% threshold",
    severity: "Critical",
    timestamp: "2024-03-08 14:50",
  },
  {
    id: "RA003",
    title: "Database Query Performance Degradation",
    description: "Average query time increased by 200ms",
    severity: "Low",
    timestamp: "2024-03-08 13:30",
  },
];

const ERROR_LOGS: ErrorLog[] = [
  {
    id: "ERR-001",
    title: "Database Connection Timeout",
    module: "Auth Service",
    description: "Connection pool exhausted",
    status: "Investigating",
    timestamp: "2024-03-08 15:15",
  },
  {
    id: "ERR-002",
    title: "Cache Layer Failure",
    module: "Content Service",
    description: "Redis connection lost",
    status: "Resolved",
    timestamp: "2024-03-08 14:20",
  },
  {
    id: "ERR-003",
    title: "API Rate Limit Exceeded",
    module: "External API",
    description: "Third-party service throttling",
    status: "New",
    timestamp: "2024-03-08 13:45",
  },
];

const RESOURCE_USAGE: ResourceUsage[] = [
  { label: "CPU Usage", value: 65 },
  { label: "Memory Usage", value: 78 },
  { label: "Database Load", value: 52 },
];

const NAV_ITEMS = ["Home", "Users", "Contents", "Job Lists", "System"];

// ── Badge Components ──────────────────────────────────────────────────────────

function ActivityBadge({ type }: { type: "detection" | "flagged" | "resolved" }) {
  const colors = {
    detection: "bg-[#FEE2E2]",
    flagged: "bg-[#FEF3C7]",
    resolved: "bg-[#DCFCE7]",
  };
  const icons = {
    detection: <AlertCircleIcon className="w-4 h-4 text-[#DC2626]" />,
    flagged: <AlertCircleIcon className="w-4 h-4 text-[#D97706]" />,
    resolved: <CheckCircleIcon className="w-4 h-4 text-[#15803D]" />,
  };
  return (
    <div className={`inline-flex items-center justify-center w-9 h-9 rounded-lg ${colors[type]}`}>
      {icons[type]}
    </div>
  );
}

function SeverityBadge({ severity }: { severity: "Urgent" | "Critical" | "Low" }) {
  const badgeConfig = {
    Urgent: { bgColor: "bg-[#FEE2E2]", textColor: "text-[#DC2626]" },
    Critical: { bgColor: "bg-[#FEE2E2]", textColor: "text-[#DC2626]" },
    Low: { bgColor: "bg-[#EFF6FF]", textColor: "text-[#3B82F6]" },
  };
  const config = badgeConfig[severity];
  return (
    <div
      className={`inline-flex items-center px-3 py-1.5 rounded-full text-[11px] font-medium ${config.bgColor} ${config.textColor}`}
    >
      {severity}
    </div>
  );
}

function ErrorStatusBadge({ status }: { status: "Investigating" | "Resolved" | "New" }) {
  const badgeConfig = {
    Investigating: { bgColor: "bg-[#FEF3C7]", textColor: "text-[#D97706]" },
    Resolved: { bgColor: "bg-[#DCFCE7]", textColor: "text-[#15803D]" },
    New: { bgColor: "bg-[#FEE2E2]", textColor: "text-[#DC2626]" },
  };
  const config = badgeConfig[status];
  return (
    <div
      className={`inline-flex items-center px-3 py-1.5 rounded-full text-[11px] font-medium ${config.bgColor} ${config.textColor}`}
    >
      {status}
    </div>
  );
}

function IDBadge({ id }: { id: string }) {
  return (
    <div className="inline-flex items-center px-3 py-1.5 rounded-full text-[11px] font-medium bg-[#F3F4F6] text-[#374151]">
      {id}
    </div>
  );
}

// ── Sub-components ────────────────────────────────────────────────────────────

function AIActivityCard({ activity }: { activity: AIActivity }) {
  return (
    <div
      className="bg-white rounded-[16px] p-6 flex gap-4"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      <ActivityBadge type={activity.type} />
      <div className="flex-1 min-w-0">
        <p className="text-[14px] font-semibold text-[#0D1B3E]">{activity.title}</p>
        <p className="text-[12px] text-[#9CA3AF] mt-1">{activity.refId}</p>
        <p className="text-[13px] text-[#374151] mt-2">{activity.description}</p>
        <p className="text-[11px] text-[#9CA3AF] mt-3">{activity.timestamp}</p>
      </div>
    </div>
  );
}

function StatCard({ metric }: { metric: UsageMetric }) {
  return (
    <div
      className="bg-white rounded-[16px] p-6 flex flex-col gap-4"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      <p className="text-[13px] font-normal text-[#6B7280]">{metric.label}</p>
      <div className="flex items-end gap-3">
        <p className="text-[28px] font-bold text-[#0D2B6B]">{metric.value}</p>
        <p className="text-[13px] font-medium text-[#15803D] mb-1">+{metric.delta}</p>
      </div>
    </div>
  );
}

function SystemPerformanceCard() {
  const performanceData = [
    { time: "00:00", Requests: 420, Errors: 3 },
    { time: "04:00", Requests: 380, Errors: 2 },
    { time: "08:00", Requests: 820, Errors: 5 },
    { time: "12:00", Requests: 1280, Errors: 8 },
    { time: "16:00", Requests: 1200, Errors: 6 },
    { time: "20:00", Requests: 900, Errors: 4 },
    { time: "23:59", Requests: 720, Errors: 3 },
  ];

  return (
    <div
      className="bg-white rounded-[16px] p-6 w-full"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      <h3 className="text-[16px] font-semibold text-[#0D1B3E] mb-6">System Performance</h3>
      <div style={{ width: "100%", height: "300px" }}>
        <ResponsiveContainer width="100%" height="100%">
          <LineChart
            data={performanceData}
            margin={{ top: 5, right: 30, left: 0, bottom: 5 }}
          >
            <CartesianGrid strokeDasharray="3 3" stroke="#F3F4F6" vertical={false} />
            <XAxis
              dataKey="time"
              tick={{ fontSize: 11, fill: "#9CA3AF" }}
              axisLine={false}
              tickLine={false}
            />
            <YAxis
              tick={{ fontSize: 11, fill: "#9CA3AF" }}
              axisLine={false}
              tickLine={false}
            />
            <Tooltip
              contentStyle={{
                backgroundColor: "#FFFFFF",
                border: "1px solid #E5E7EB",
                borderRadius: "8px",
                boxShadow: "0 4px 12px rgba(0, 0, 0, 0.1)",
              }}
            />
            <Legend iconType="circle" iconSize={8} wrapperStyle={{ paddingTop: "20px" }} />
            <Line
              dataKey="Requests"
              stroke="#7C6FF7"
              strokeWidth={2}
              dot={{ r: 4, fill: "#7C6FF7" }}
              activeDot={{ r: 6 }}
              type="monotone"
            />
            <Line
              dataKey="Errors"
              stroke="#EF4444"
              strokeWidth={2}
              dot={{ r: 4, fill: "#EF4444" }}
              activeDot={{ r: 6 }}
              type="monotone"
            />
          </LineChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
}

function ResourceUsageCard() {
  return (
    <div
      className="bg-white rounded-[16px] p-6"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      <h3 className="text-[16px] font-semibold text-[#0D1B3E] mb-6">Resource Usage</h3>
      <div className="space-y-6">
        {RESOURCE_USAGE.map((resource, idx) => (
          <div key={idx} className="space-y-2">
            <div className="flex items-center justify-between">
              <p className="text-[13px] font-normal text-[#0D1B3E]">{resource.label}</p>
              <p className="text-[13px] font-medium text-[#0D1B3E]">{resource.value}%</p>
            </div>
            <div className="w-full bg-[#E5E7EB] rounded-full h-2">
              <div
                className="bg-[#0D2B6B] h-2 rounded-full"
                style={{ width: `${resource.value}%` }}
              />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function RiskAlertCard({ alert }: { alert: RiskAlert }) {
  return (
    <div
      className="bg-white rounded-[16px] p-6 flex flex-col gap-3"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      <div className="flex items-start justify-between gap-3">
        <div className="flex-1 min-w-0">
          <p className="text-[15px] font-semibold text-[#0D1B3E]">{alert.title}</p>
          <p className="text-[13px] text-[#374151] mt-2">{alert.description}</p>
        </div>
      </div>
      <div className="flex items-center gap-2.5">
        <IDBadge id={alert.id} />
        <SeverityBadge severity={alert.severity} />
      </div>
      <p className="text-[11px] text-[#9CA3AF]">{alert.timestamp}</p>
      <div className="flex gap-2.5 mt-2">
        <button className="flex-1 px-4 py-2.5 rounded-full bg-[#0D2B6B] text-white text-[13px] font-semibold hover:bg-[#0D1B3E] transition-colors">
          Acknowledge
        </button>
        <button className="flex-1 px-4 py-2.5 rounded-full bg-white border border-[#0D2B6B] text-[#0D2B6B] text-[13px] font-semibold hover:bg-[#F9FAFB] transition-colors">
          Escalate
        </button>
      </div>
    </div>
  );
}

function ErrorLogItem({ log }: { log: ErrorLog }) {
  return (
    <div
      className="bg-white rounded-[16px] p-6 flex flex-col gap-2"
      style={{ boxShadow: "0 2px 8px rgba(0,0,0,0.06)" }}
    >
      <div className="flex items-start justify-between gap-3">
        <div className="flex-1 min-w-0">
          <p className="text-[14px] font-semibold text-[#0D2B6B]">{log.title}</p>
          <p className="text-[13px] text-[#6B7280] mt-1">{log.module}</p>
          <p className="text-[13px] text-[#374151] mt-1">{log.description}</p>
        </div>
        <ErrorStatusBadge status={log.status} />
      </div>
      <p className="text-[11px] text-[#9CA3AF]">{log.timestamp}</p>
    </div>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function SystemPage() {
  const [activeTab, setActiveTab] = useState<"ai" | "metrics" | "risks" | "errors">("ai");
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
      <main className="max-w-7xl mx-auto px-5 sm:px-8 py-8 space-y-6">
        {/* Page Title */}
        <div>
          <p
            className="text-[11px] font-semibold uppercase text-[#6B7280]"
            style={{ letterSpacing: "0.12em" }}
          >
            System Analytics
          </p>
          <h1 className="mt-3 text-[30px] font-bold text-[#0D1B3E]">System Monitor</h1>
          <p className="text-[14px] text-[#6B7280] mt-2 font-normal">
            Monitor AI activities, system metrics, risk alerts, and error logs
          </p>
        </div>

        {/* Tabs */}
        <div className="flex gap-3 overflow-x-auto">
          <button
            onClick={() => setActiveTab("ai")}
            className={`px-4 py-3 text-[14px] font-medium rounded-[8px] transition-all whitespace-nowrap ${
              activeTab === "ai"
                ? "text-white bg-[#0D2B6B]"
                : "text-[#6B7280] hover:text-[#0D1B3E]"
            }`}
          >
            AI Activity
          </button>
          <button
            onClick={() => setActiveTab("metrics")}
            className={`px-4 py-3 text-[14px] font-medium rounded-[8px] transition-all whitespace-nowrap ${
              activeTab === "metrics"
                ? "text-white bg-[#0D2B6B]"
                : "text-[#6B7280] hover:text-[#0D1B3E]"
            }`}
          >
            Usage Metrics
          </button>
          <button
            onClick={() => setActiveTab("risks")}
            className={`px-4 py-3 text-[14px] font-medium rounded-[8px] transition-all whitespace-nowrap ${
              activeTab === "risks"
                ? "text-white bg-[#0D2B6B]"
                : "text-[#6B7280] hover:text-[#0D1B3E]"
            }`}
          >
            Risk Alerts
          </button>
          <button
            onClick={() => setActiveTab("errors")}
            className={`px-4 py-3 text-[14px] font-medium rounded-[8px] transition-all whitespace-nowrap ${
              activeTab === "errors"
                ? "text-white bg-[#0D2B6B]"
                : "text-[#6B7280] hover:text-[#0D1B3E]"
            }`}
          >
            Error Logs
          </button>
        </div>

        {/* AI Activity Tab */}
        {activeTab === "ai" && (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {AI_ACTIVITIES.map((activity) => (
              <AIActivityCard key={activity.id} activity={activity} />
            ))}
          </div>
        )}

        {/* Usage Metrics Tab */}
        {activeTab === "metrics" && (
          <div className="space-y-6">
            {/* Stat Cards Row */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {USAGE_METRICS.map((metric, idx) => (
                <StatCard key={idx} metric={metric} />
              ))}
            </div>

            {/* Performance and Resource Usage Cards */}
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
              <div className="lg:col-span-2">
                <SystemPerformanceCard />
              </div>
              <div className="lg:col-span-1">
                <ResourceUsageCard />
              </div>
            </div>
          </div>
        )}

        {/* Risk Alerts Tab */}
        {activeTab === "risks" && (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {RISK_ALERTS.map((alert) => (
              <RiskAlertCard key={alert.id} alert={alert} />
            ))}
          </div>
        )}

        {/* Error Logs Tab */}
        {activeTab === "errors" && (
          <div className="space-y-4">
            {ERROR_LOGS.map((log) => (
              <ErrorLogItem key={log.id} log={log} />
            ))}
          </div>
        )}
      </main>
    </div>
  );
}