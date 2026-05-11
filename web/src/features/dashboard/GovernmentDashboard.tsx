import { useEffect, useMemo, useState } from "react";
import { NgoLayout } from "../../components/layout/NgoLayout";

const STATS = [
  {
    value: "47",
    label: "Abuse Report",
    sublabel: "vs last month",
    change: "+12%",
    icon: "warning",
  },
  {
    value: "8",
    label: "Support Request",
    sublabel: "vs last month",
    change: "+8%",
    icon: "trend",
  },
  {
    value: "23",
    label: "High Risk Employers",
    sublabel: "vs last month",
    change: "+3",
    icon: "people",
  },
  {
    value: "12",
    label: "Countries Monitored",
    sublabel: "no change",
    change: "Stable",
    icon: "pin",
  },
] as const;

const CHART_DATA = [
  { label: "Qatar", value: 65 },
  { label: "UAE", value: 57 },
  { label: "Saudi Arabia", value: 45 },
  { label: "Kuwait", value: 33 },
  { label: "Bahrain", value: 29 },
  { label: "Oman", value: 18 },
] as const;

const CHART_MAX = 75;
const GRID_LINES = [75, 60, 45, 30, 15, 0] as const;

const ALERTS = [
  {
    workerName: "Worker Name",
    country: "Country",
    employer: "Employer Name",
    date: "2026-03-05",
    riskLevel: "High",
  },
  {
    workerName: "Worker Name",
    country: "Country",
    employer: "Employer Name",
    date: "2026-03-05",
    riskLevel: "High",
  },
  {
    workerName: "Worker Name",
    country: "Country",
    employer: "Employer Name",
    date: "2026-03-05",
    riskLevel: "High",
  },
  {
    workerName: "Worker Name",
    country: "Country",
    employer: "Employer Name",
    date: "2026-03-05",
    riskLevel: "High",
  },
  {
    workerName: "Worker Name",
    country: "Country",
    employer: "Employer Name",
    date: "2026-03-05",
    riskLevel: "High",
  },
] as const;

const EMPLOYERS = [
  {
    name: "Al Noor Recruitment Co.",
    country: "Saudi Arabia",
    score: 50,
    workers: "340",
    reports: "12",
    violations: "5",
    lastIncident: "Mar 18, 2026",
  },
  {
    name: "Gulf Horizon Manpower",
    country: "UAE",
    score: 92,
    workers: "220",
    reports: "19",
    violations: "8",
    lastIncident: "Mar 16, 2026",
  },
  {
    name: "Qatar Workforce Link",
    country: "Qatar",
    score: 27,
    workers: "410",
    reports: "4",
    violations: "1",
    lastIncident: "Mar 09, 2026",
  },
  {
    name: "Kuwait Prime Services",
    country: "Kuwait",
    score: 84,
    workers: "290",
    reports: "14",
    violations: "6",
    lastIncident: "Mar 12, 2026",
  },
  {
    name: "Bahrain Labor Connect",
    country: "Bahrain",
    score: 84,
    workers: "175",
    reports: "9",
    violations: "4",
    lastIncident: "Feb 25, 2026",
  },
] as const;

const ABUSE_REPORTS = [
  {
    name: "Maria Santos",
    country: "Saudi Arabia",
    employer: "Al Noor Recruitment Co.",
    reportId: "RPT-2026-0342",
    abuseType: "Wage Withholding",
    dateFiled: "Mar 19, 2026",
    status: "Investigation",
  },
  {
    name: "Jose Ramirez",
    country: "UAE",
    employer: "Gulf Horizon Manpower",
    reportId: "RPT-2026-0343",
    abuseType: "Passport Confiscation",
    dateFiled: "Mar 17, 2026",
    status: "Investigation",
  },
  {
    name: "Lina Cruz",
    country: "Qatar",
    employer: "Qatar Workforce Link",
    reportId: "RPT-2026-0344",
    abuseType: "Contract Substitution",
    dateFiled: "Mar 10, 2026",
    status: "In Review",
  },
  {
    name: "Ramon Ortega",
    country: "Kuwait",
    employer: "Kuwait Prime Services",
    reportId: "RPT-2026-0345",
    abuseType: "Illegal Deductions",
    dateFiled: "Feb 26, 2026",
    status: "Resolved",
  },
  {
    name: "Ana Gutierrez",
    country: "Bahrain",
    employer: "Bahrain Labor Connect",
    reportId: "RPT-2026-0346",
    abuseType: "Threat of Deportation",
    dateFiled: "Feb 20, 2026",
    status: "Investigation",
  },
] as const;

const CONTRACT_ISSUES = [
  {
    name: "Fatima Noor",
    country: "Saudi Arabia",
    employer: "Al Noor Recruitment Co.",
    contractId: "CNT-2026-0089",
    issueType: "Salary Discrepancy",
    dateFiled: "Mar 15, 2026",
    status: "Legal Review",
  },
  {
    name: "Joan Mercado",
    country: "UAE",
    employer: "Gulf Horizon Manpower",
    contractId: "CNT-2026-0090",
    issueType: "Hours Mismatch",
    dateFiled: "Mar 11, 2026",
    status: "Mediation",
  },
  {
    name: "Nina Velasco",
    country: "Qatar",
    employer: "Qatar Workforce Link",
    contractId: "CNT-2026-0091",
    issueType: "Accommodation Clause",
    dateFiled: "Mar 07, 2026",
    status: "Mediation",
  },
  {
    name: "Carlo Dela Cruz",
    country: "Bahrain",
    employer: "Bahrain Labor Connect",
    contractId: "CNT-2026-0092",
    issueType: "Contract Duration",
    dateFiled: "Feb 22, 2026",
    status: "Resolved",
  },
] as const;

const ASSISTANCE_CASES = [
  {
    name: "Maria Santos",
    country: "Saudi Arabia",
    employer: "Al Noor Recruitment Co.",
    issue: "Contract Substitution",
    date: "Mar 19, 2026",
    status: "In review",
  },
  {
    name: "Jose Ramirez",
    country: "UAE",
    employer: "Gulf Horizon Manpower",
    issue: "Passport Retention",
    date: "Mar 16, 2026",
    status: "Resolved",
  },
  {
    name: "Lina Cruz",
    country: "Qatar",
    employer: "Qatar Workforce Link",
    issue: "Wage Delay",
    date: "Mar 10, 2026",
    status: "In review",
  },
  {
    name: "Ramon Ortega",
    country: "Kuwait",
    employer: "Kuwait Prime Services",
    issue: "Physical Threat",
    date: "Mar 08, 2026",
    status: "Critical",
  },
  {
    name: "Ana Gutierrez",
    country: "Bahrain",
    employer: "Bahrain Labor Connect",
    issue: "Contract Mismatch",
    date: "Feb 24, 2026",
    status: "Resolved",
  },
  {
    name: "Fatima Noor",
    country: "Saudi Arabia",
    employer: "Al Noor Recruitment Co.",
    issue: "Wage Withholding",
    date: "Feb 14, 2026",
    status: "In review",
  },
] as const;

const COUNTRY_OPTIONS = [
  "All Countries",
  "Saudi Arabia",
  "UAE",
  "Qatar",
  "Kuwait",
  "Bahrain",
];

const STATUS_OPTIONS = ["All Status", "In review", "Resolved", "Critical"];

const RISK_LEVEL_OPTIONS = ["Risk Level", "High", "Medium", "Low"];

const DATE_OPTIONS = ["All Date", "Today", "This Week", "This Month", "This Year"];

const ABUSE_STATUS_OPTIONS = [
  "All Status",
  "Investigation",
  "In Review",
  "Resolved",
];

const CONTRACT_STATUS_OPTIONS = [
  "All Status",
  "Legal Review",
  "Mediation",
  "Resolved",
];

const TABS = ["Home", "Monitoring", "Assistance"] as const;
const MONITORING_TABS = ["Employers", "Abuse Reports", "Contract Issues"] as const;

type MonitoringTab = (typeof MONITORING_TABS)[number];

type Tab = (typeof TABS)[number];

function formatIsoDate(rawDate: string) {
  try {
    const parts = rawDate.split("-");
    if (parts.length !== 3) return rawDate;
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    const month = Number(parts[1]);
    const day = Number(parts[2]);
    const year = parts[0];
    if (!month || !day) return rawDate;
    return `${months[month]} ${day}, ${year}`;
  } catch {
    return rawDate;
  }
}

function parsePrettyDate(rawDate: string) {
  const parsed = new Date(rawDate);
  if (!Number.isNaN(parsed.valueOf())) return parsed;

  const months: Record<string, number> = {
    jan: 1,
    feb: 2,
    mar: 3,
    apr: 4,
    may: 5,
    jun: 6,
    jul: 7,
    aug: 8,
    sep: 9,
    oct: 10,
    nov: 11,
    dec: 12,
  };

  const match = /^([A-Za-z]{3})\s+(\d{1,2}),\s*(\d{4})$/.exec(rawDate.trim());
  if (!match) return null;
  const month = months[match[1].toLowerCase()];
  const day = Number(match[2]);
  const year = Number(match[3]);
  if (!month || !day || !year) return null;
  return new Date(year, month - 1, day);
}

function matchesDateFilter(rawDate: string, selectedDate: string) {
  if (selectedDate === "All Date") return true;
  const parsed = parsePrettyDate(rawDate) ?? new Date(rawDate);
  if (Number.isNaN(parsed.valueOf())) return false;
  const now = new Date();
  const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
  const thatDay = new Date(parsed.getFullYear(), parsed.getMonth(), parsed.getDate());
  const diff = Math.floor((today.getTime() - thatDay.getTime()) / 86400000);

  if (selectedDate === "Today") return diff === 0;
  if (selectedDate === "This Week") return diff >= 0 && diff <= 7;
  if (selectedDate === "This Month") return parsed.getFullYear() === now.getFullYear() && parsed.getMonth() === now.getMonth();
  if (selectedDate === "This Year") return parsed.getFullYear() === now.getFullYear();
  return true;
}

function StatIcon({ type }: { type: (typeof STATS)[number]["icon"] }) {
  const props = { width: 18, height: 18, stroke: "currentColor", strokeWidth: 1.8, fill: "none" } as const;
  if (type === "warning") {
    return (
      <svg viewBox="0 0 24 24" {...props}>
        <path d="M12 9v4" />
        <path d="M12 17h.01" />
        <path d="M10.3 3.9 2.6 17.1a1 1 0 0 0 .9 1.4h16.9a1 1 0 0 0 .9-1.4L13.7 3.9a1 1 0 0 0-1.4 0z" />
      </svg>
    );
  }
  if (type === "trend") {
    return (
      <svg viewBox="0 0 24 24" {...props}>
        <path d="M3 17 9 11 13 15 21 7" />
        <path d="M21 7v6h-6" />
      </svg>
    );
  }
  if (type === "people") {
    return (
      <svg viewBox="0 0 24 24" {...props}>
        <path d="M12 12a4 4 0 1 0-4-4 4 4 0 0 0 4 4z" />
        <path d="M16 20v-1a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v1" />
        <path d="M18 8a3 3 0 1 1-3-3" />
        <path d="M22 20v-1a4 4 0 0 0-3-3.87" />
      </svg>
    );
  }
  return (
    <svg viewBox="0 0 24 24" {...props}>
      <path d="M12 21s-6-5.7-6-10a6 6 0 0 1 12 0c0 4.3-6 10-6 10z" />
      <path d="M12 11a2 2 0 1 0-2-2 2 2 0 0 0 2 2z" />
    </svg>
  );
}

function Badge({ label }: { label: string }) {
  return (
    <span className="rounded-full bg-[#DFEDFF] px-3 py-1 text-[11px] font-semibold text-[#003696]">
      {label}
    </span>
  );
}

export default function GovernmentDashboard() {
  const [activeTab, setActiveTab] = useState<Tab>("Home");
  const [monitoringTab, setMonitoringTab] = useState<MonitoringTab>("Employers");
  const [selectedCountry, setSelectedCountry] = useState("All Countries");
  const [selectedStatus, setSelectedStatus] = useState("All Status");
  const [selectedDate, setSelectedDate] = useState("All Date");
  const [searchAssistance, setSearchAssistance] = useState("");

  useEffect(() => {
    const options =
      monitoringTab === "Abuse Reports"
        ? ABUSE_STATUS_OPTIONS
        : monitoringTab === "Contract Issues"
          ? CONTRACT_STATUS_OPTIONS
          : RISK_LEVEL_OPTIONS;
    if (!options.includes(selectedStatus)) {
      setSelectedStatus(options[0]);
    }
  }, [monitoringTab, selectedStatus]);

  const filteredEmployers = useMemo(() => {
    return EMPLOYERS.filter((item) => {
      const matchesCountry = selectedCountry === "All Countries" || item.country === selectedCountry;
      const riskLabel = item.score >= 70 ? "High" : item.score >= 40 ? "Medium" : "Low";
      const matchesStatus =
        selectedStatus === "All Status" ||
        selectedStatus === "Risk Level" ||
        !RISK_LEVEL_OPTIONS.includes(selectedStatus) ||
        riskLabel === selectedStatus;
      const matchesDate = matchesDateFilter(item.lastIncident, selectedDate);
      return matchesCountry && matchesStatus && matchesDate;
    });
  }, [selectedCountry, selectedDate, selectedStatus]);

  const filteredAbuseReports = useMemo(() => {
    return ABUSE_REPORTS.filter((item) => {
      const matchesCountry = selectedCountry === "All Countries" || item.country === selectedCountry;
      const matchesStatus = selectedStatus === "All Status" || item.status === selectedStatus;
      const matchesDate = matchesDateFilter(item.dateFiled, selectedDate);
      return matchesCountry && matchesStatus && matchesDate;
    });
  }, [selectedCountry, selectedDate, selectedStatus]);

  const filteredContractIssues = useMemo(() => {
    return CONTRACT_ISSUES.filter((item) => {
      const matchesCountry = selectedCountry === "All Countries" || item.country === selectedCountry;
      const matchesStatus = selectedStatus === "All Status" || item.status === selectedStatus;
      const matchesDate = matchesDateFilter(item.dateFiled, selectedDate);
      return matchesCountry && matchesStatus && matchesDate;
    });
  }, [selectedCountry, selectedDate, selectedStatus]);

  const filteredAssistanceCases = useMemo(() => {
    return ASSISTANCE_CASES.filter((item) => {
      const matchesCountry = selectedCountry === "All Countries" || item.country === selectedCountry;
      const matchesStatus = selectedStatus === "All Status" || item.status === selectedStatus;
      const matchesDate = matchesDateFilter(item.date, selectedDate);
      const query = searchAssistance.trim().toLowerCase();
      const matchesQuery =
        query.length === 0 ||
        item.name.toLowerCase().includes(query) ||
        item.issue.toLowerCase().includes(query);
      return matchesCountry && matchesStatus && matchesDate && matchesQuery;
    });
  }, [searchAssistance, selectedCountry, selectedDate, selectedStatus]);

  const monitoringStatusOptions =
    monitoringTab === "Abuse Reports"
      ? ABUSE_STATUS_OPTIONS
      : monitoringTab === "Contract Issues"
        ? CONTRACT_STATUS_OPTIONS
        : RISK_LEVEL_OPTIONS;

  const normalizedStatus =
    monitoringTab === "Employers" && !RISK_LEVEL_OPTIONS.includes(selectedStatus)
      ? "Risk Level"
      : selectedStatus;

  return (
    <NgoLayout>
      <main className="mx-auto w-full max-w-6xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="flex flex-col gap-4">
          <div className="flex flex-col gap-2">
            <h1 className="text-[18px] font-extrabold text-[#0F172A]">Government Dashboard</h1>
            <div className="flex flex-wrap gap-2">
              {TABS.map((tab) => (
                <button
                  key={tab}
                  onClick={() => setActiveTab(tab)}
                  className={`rounded-full px-4 py-2 text-[12px] font-semibold transition ${
                    activeTab === tab
                      ? "bg-[#003696] text-white"
                      : "bg-white text-slate-600 border border-[#E2E5EA]"
                  }`}
                >
                  {tab}
                </button>
              ))}
            </div>
          </div>

          {activeTab === "Home" && (
            <div className="space-y-6">
              <section>
                <p className="text-[16px] font-semibold text-slate-900">System Overview</p>
                <div className="mt-3 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
                  {STATS.map((stat) => {
                    const isNegative = stat.label.toLowerCase().includes("high risk");
                    return (
                      <article
                        key={stat.label}
                        className="rounded-[16px] border border-[#E5E7EB] bg-white p-4 shadow-[0_6px_16px_rgba(15,23,42,0.06)]"
                      >
                        <div className="mb-3 flex items-start justify-between">
                          <span className="flex h-9 w-9 items-center justify-center rounded-[12px] bg-[#0D2B6B] text-white">
                            <StatIcon type={stat.icon} />
                          </span>
                          <div className={`text-[13px] font-semibold ${isNegative ? "text-[#8E0012]" : "text-emerald-600"}`}>
                            {stat.change}
                          </div>
                        </div>
                        <p className="text-[24px] font-extrabold text-slate-900 leading-none">{stat.value}</p>
                        <p className="mt-2 text-[13px] font-semibold text-slate-800">{stat.label}</p>
                        <p className="text-[12px] text-slate-400">{stat.sublabel}</p>
                      </article>
                    );
                  })}
                </div>
              </section>

              <section>
                <p className="text-[16px] font-semibold text-slate-900">Abuse Reports Summary</p>
                <div className="mt-3 rounded-[24px] border border-[#E5E7EB] bg-white p-4 shadow-[0_12px_20px_rgba(15,23,42,0.08)]">
                  <div className="flex gap-4">
                    <div className="flex h-[215px] flex-col justify-between text-[10px] text-slate-400">
                      {GRID_LINES.map((line) => (
                        <span key={line}>{line}</span>
                      ))}
                    </div>
                    <div className="relative flex-1">
                      {GRID_LINES.map((_, index) => (
                        <div
                          key={`grid-${index}`}
                          className="absolute left-0 right-0 h-px bg-[#E5E7EB]"
                          style={{ top: `${(index / (GRID_LINES.length - 1)) * 100}%` }}
                        />
                      ))}
                      <div className="relative z-10 flex h-[215px] items-end gap-2">
                        {CHART_DATA.map((item) => {
                          const height = (item.value / CHART_MAX) * 198;
                          return (
                            <div key={item.label} className="flex flex-1 flex-col items-center gap-2">
                              <div
                                className="w-8 rounded-t-lg bg-[#C7D5EB]"
                                style={{ height: `${height}px` }}
                              />
                              <span className="text-center text-[10px] text-slate-500">
                                {item.label}
                              </span>
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  </div>
                </div>
              </section>

              <section>
                <div className="flex items-center justify-between">
                  <p className="text-[16px] font-semibold text-slate-900">Recent Alerts Feed</p>
                  <button
                    onClick={() => {
                      setActiveTab("Monitoring");
                      setMonitoringTab("Abuse Reports");
                    }}
                    className="text-[12px] font-semibold text-slate-500"
                  >
                    View all {"\u2192"}
                  </button>
                </div>
                <div className="mt-3 grid gap-4">
                  {ALERTS.slice(0, 4).map((alert, idx) => {
                    const risk = alert.riskLevel.toLowerCase();
                    const riskLabel = risk.includes("high") || risk.includes("critical") ? "HIGH" : "MED";
                    const riskDot = riskLabel === "HIGH" ? "bg-[#8E0012]" : "bg-[#EAB308]";
                    return (
                      <article
                        key={`${alert.workerName}-${idx}`}
                        className="rounded-[16px] border border-[#E5E7EB] bg-white p-4 shadow-[0_10px_18px_rgba(15,23,42,0.07)]"
                      >
                        <div className="flex items-start gap-3">
                          <div className="flex h-11 w-11 items-center justify-center rounded-xl bg-[#DFEDFF] text-[#003696]">
                            <span className="text-sm font-bold">A</span>
                          </div>
                          <div className="flex-1">
                            <div className="flex items-start justify-between gap-3">
                              <div>
                                <p className="text-[14px] font-bold text-slate-900">{alert.workerName}</p>
                                <p className="mt-1 text-[12px] text-slate-500">{alert.country}</p>
                              </div>
                              <Badge label="In Review" />
                            </div>
                            <div className="mt-3 space-y-1 text-[12px] text-slate-700">
                              <p>
                                <span className="font-semibold">Employer:</span> {alert.employer}
                              </p>
                              <p>
                                <span className="font-semibold">Date:</span> {formatIsoDate(alert.date)}
                              </p>
                              <div className="flex items-center gap-2">
                                <span className="font-semibold">Risk Level:</span>
                                <span className={`h-2 w-2 rounded-full ${riskDot}`} />
                                <span>{riskLabel}</span>
                              </div>
                            </div>
                          </div>
                        </div>
                      </article>
                    );
                  })}
                </div>
              </section>
            </div>
          )}

          {activeTab === "Monitoring" && (
            <div className="space-y-5">
              <div>
                <p className="text-[16px] font-semibold text-slate-900">Risk Monitoring</p>
                <div className="mt-3 flex flex-wrap gap-2">
                  {MONITORING_TABS.map((tab) => (
                    <button
                      key={tab}
                      onClick={() => setMonitoringTab(tab)}
                      className={`rounded-full px-4 py-2 text-[12px] font-semibold transition ${
                        monitoringTab === tab
                          ? "bg-[#003696] text-white"
                          : "bg-white text-slate-600 border border-[#E2E5EA]"
                      }`}
                    >
                      {tab}
                    </button>
                  ))}
                </div>
              </div>

              <div className="grid gap-3 md:grid-cols-3">
                <select
                  value={selectedCountry}
                  onChange={(e) => setSelectedCountry(e.target.value)}
                  className="h-[42px] rounded-full border border-[#E2E5EA] bg-white px-4 text-[12px] text-slate-600"
                >
                  {COUNTRY_OPTIONS.map((option) => (
                    <option key={option}>{option}</option>
                  ))}
                </select>
                <select
                  value={normalizedStatus}
                  onChange={(e) => setSelectedStatus(e.target.value)}
                  className="h-[42px] rounded-full border border-[#E2E5EA] bg-white px-4 text-[12px] text-slate-600"
                >
                  {monitoringStatusOptions.map((option) => (
                    <option key={option}>{option}</option>
                  ))}
                </select>
                <select
                  value={selectedDate}
                  onChange={(e) => setSelectedDate(e.target.value)}
                  className="h-[42px] rounded-full border border-[#E2E5EA] bg-white px-4 text-[12px] text-slate-600"
                >
                  {DATE_OPTIONS.map((option) => (
                    <option key={option}>{option}</option>
                  ))}
                </select>
              </div>

              {monitoringTab === "Employers" && (
                <div className="space-y-4">
                  <div>
                    <p className="text-[15px] font-bold text-slate-900">High-Risk Employers</p>
                    <p className="text-[12px] text-slate-500">Showing {filteredEmployers.length} employers</p>
                  </div>
                  <div className="grid gap-4">
                    {filteredEmployers.map((item) => {
                      const riskLabel = item.score >= 70 ? "High Risk" : item.score >= 40 ? "Medium Risk" : "Low Risk";
                      const riskColor = item.score >= 70 ? "text-[#8E0012]" : item.score >= 40 ? "text-[#EAB308]" : "text-emerald-600";
                      const progress = Math.min(item.score / 100, 1) * 100;
                      return (
                        <article key={item.name} className="rounded-[16px] border border-[#E5E7EB] bg-white p-4 shadow-sm">
                          <div className="flex items-start justify-between gap-3">
                            <div>
                              <p className="text-[14px] font-bold text-slate-900">{item.name}</p>
                              <p className="mt-1 text-[12px] text-slate-500">{item.country}</p>
                            </div>
                            <span className={`text-[12px] font-semibold ${riskColor}`}>{riskLabel}</span>
                          </div>
                          <div className="mt-3">
                            <div className="flex items-center justify-between text-[11px] text-slate-500">
                              <span>Score</span>
                              <span className="font-semibold text-slate-700">{item.score}</span>
                            </div>
                            <div className="mt-2 h-2 w-full rounded-full bg-[#E5E7EB]">
                              <div
                                className="h-2 rounded-full bg-[#003696]"
                                style={{ width: `${progress}%` }}
                              />
                            </div>
                          </div>
                          <div className="mt-3 grid gap-2 text-[12px] text-slate-600 sm:grid-cols-2">
                            <p><span className="font-semibold text-slate-700">Workers:</span> {item.workers}</p>
                            <p><span className="font-semibold text-slate-700">Reports:</span> {item.reports}</p>
                            <p><span className="font-semibold text-slate-700">Violations:</span> {item.violations}</p>
                            <p><span className="font-semibold text-slate-700">Last Incident:</span> {item.lastIncident}</p>
                          </div>
                        </article>
                      );
                    })}
                  </div>
                  <Pagination />
                </div>
              )}

              {monitoringTab === "Abuse Reports" && (
                <div className="space-y-4">
                  <div>
                    <p className="text-[15px] font-bold text-slate-900">Abuse Reports</p>
                    <p className="text-[12px] text-slate-500">Showing {filteredAbuseReports.length} reports</p>
                  </div>
                  <div className="grid gap-4">
                    {filteredAbuseReports.map((item) => (
                      <article key={item.reportId} className="rounded-[16px] border border-[#E5E7EB] bg-white p-4 shadow-sm">
                        <div className="flex items-start justify-between gap-3">
                          <div>
                            <p className="text-[14px] font-bold text-slate-900">{item.name}</p>
                            <p className="mt-1 text-[12px] text-slate-500">{item.country}</p>
                          </div>
                          <Badge label={item.status} />
                        </div>
                        <div className="mt-3 grid gap-2 text-[12px] text-slate-600 sm:grid-cols-2">
                          <p><span className="font-semibold text-slate-700">Employer:</span> {item.employer}</p>
                          <p><span className="font-semibold text-slate-700">Issue:</span> {item.abuseType}</p>
                          <p><span className="font-semibold text-slate-700">Report ID:</span> {item.reportId}</p>
                          <p><span className="font-semibold text-slate-700">Date Filed:</span> {item.dateFiled}</p>
                        </div>
                        <div className="mt-4 flex items-center justify-between">
                          <div className="text-[12px] text-slate-600">
                            <span className="font-semibold text-slate-700">Severity:</span> {item.status === "Resolved" ? "Low" : item.status === "In Review" ? "Medium" : "High"}
                          </div>
                          <button className="rounded-lg bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white">
                            View Report
                          </button>
                        </div>
                      </article>
                    ))}
                  </div>
                  <Pagination />
                </div>
              )}

              {monitoringTab === "Contract Issues" && (
                <div className="space-y-4">
                  <div>
                    <p className="text-[15px] font-bold text-slate-900">Contract Issue Reports</p>
                    <p className="text-[12px] text-slate-500">Showing {filteredContractIssues.length} flagged contracts</p>
                  </div>
                  <div className="grid gap-4">
                    {filteredContractIssues.map((item) => (
                      <article key={item.contractId} className="rounded-[16px] border border-[#E5E7EB] bg-white p-4 shadow-sm">
                        <div className="flex items-start justify-between gap-3">
                          <div>
                            <p className="text-[14px] font-bold text-slate-900">{item.name}</p>
                            <p className="mt-1 text-[12px] text-slate-500">{item.country}</p>
                          </div>
                          <Badge label={item.status} />
                        </div>
                        <div className="mt-3 grid gap-2 text-[12px] text-slate-600 sm:grid-cols-2">
                          <p><span className="font-semibold text-slate-700">Employer:</span> {item.employer}</p>
                          <p><span className="font-semibold text-slate-700">Issue:</span> {item.issueType}</p>
                          <p><span className="font-semibold text-slate-700">Contract ID:</span> {item.contractId}</p>
                          <p><span className="font-semibold text-slate-700">Date Filed:</span> {item.dateFiled}</p>
                        </div>
                        <div className="mt-4 flex items-center justify-between">
                          <div className="text-[12px] text-slate-600">
                            <span className="font-semibold text-slate-700">Severity:</span> {item.status === "Resolved" ? "Low" : item.status === "Mediation" ? "Medium" : "High"}
                          </div>
                          <button className="rounded-lg bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white">
                            View contract
                          </button>
                        </div>
                      </article>
                    ))}
                  </div>
                  <Pagination />
                </div>
              )}
            </div>
          )}

          {activeTab === "Assistance" && (
            <div className="space-y-4">
              <div>
                <p className="text-[16px] font-semibold text-slate-900">Work Assistance</p>
                <div className="mt-3 grid gap-3 md:grid-cols-3">
                  <div className="md:col-span-3">
                    <input
                      value={searchAssistance}
                      onChange={(e) => setSearchAssistance(e.target.value)}
                      placeholder="Search worker by name or case ID"
                      className="h-[44px] w-full rounded-full border border-[#E2E5EA] bg-white px-4 text-[12px] text-slate-600"
                    />
                  </div>
                  <select
                    value={selectedCountry}
                    onChange={(e) => setSelectedCountry(e.target.value)}
                    className="h-[42px] rounded-full border border-[#E2E5EA] bg-white px-4 text-[12px] text-slate-600"
                  >
                    {COUNTRY_OPTIONS.map((option) => (
                      <option key={option}>{option}</option>
                    ))}
                  </select>
                  <select
                    value={selectedStatus}
                    onChange={(e) => setSelectedStatus(e.target.value)}
                    className="h-[42px] rounded-full border border-[#E2E5EA] bg-white px-4 text-[12px] text-slate-600"
                  >
                    {STATUS_OPTIONS.map((option) => (
                      <option key={option}>{option}</option>
                    ))}
                  </select>
                  <select
                    value={selectedDate}
                    onChange={(e) => setSelectedDate(e.target.value)}
                    className="h-[42px] rounded-full border border-[#E2E5EA] bg-white px-4 text-[12px] text-slate-600"
                  >
                    {DATE_OPTIONS.map((option) => (
                      <option key={option}>{option}</option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="grid gap-4">
                {filteredAssistanceCases.map((item) => (
                  <article key={`${item.name}-${item.issue}`} className="rounded-[16px] border border-[#E5E7EB] bg-white p-4 shadow-sm">
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <p className="text-[14px] font-bold text-slate-900">{item.name}</p>
                        <p className="mt-1 text-[12px] text-slate-500">{item.country}</p>
                      </div>
                      <Badge label={item.status} />
                    </div>
                    <div className="mt-3 grid gap-2 text-[12px] text-slate-600 sm:grid-cols-2">
                      <p><span className="font-semibold text-slate-700">Employer:</span> {item.employer}</p>
                      <p><span className="font-semibold text-slate-700">Issue:</span> {item.issue}</p>
                      <p><span className="font-semibold text-slate-700">Date:</span> {item.date}</p>
                    </div>
                  </article>
                ))}
              </div>
              <Pagination />
            </div>
          )}
        </div>
      </main>
    </NgoLayout>
  );
}

function Pagination() {
  return (
    <div className="flex items-center justify-between rounded-[12px] border border-[#E5E7EB] bg-white px-4 py-3 text-[12px] text-slate-600">
      <button className="rounded-full border border-[#E2E5EA] px-3 py-1">Previous</button>
      <span>Page 1 of 3</span>
      <button className="rounded-full border border-[#E2E5EA] px-3 py-1">Next</button>
    </div>
  );
}
