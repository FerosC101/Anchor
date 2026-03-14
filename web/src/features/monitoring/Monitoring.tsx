import { useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ROUTES } from "../../core/config/routes";
import { NgoColors } from "../../core/theme/ngo-colors";
import { NgoDrawer } from "../../components/layout/NgoDrawer";
import { useNotifications } from "../../core/context/NotificationContext";
import { useAuth } from "../../core/context/AuthContext";

// ─── Types ────────────────────────────────────────────────────────────────────

interface WorkerCase {
  id: string;
  initials: string;
  workerName: string;
  country: string;
  employer: string;
  issue: string;
  reportId: string;
  severity: "Critical" | "High" | "Medium" | "Low";
  credibility: number;
  status: "Pending" | "In Review" | "Verified" | "Archived" | "Revisit";
  description: string;
  reportDate: string;
  updatedDate: string;
}

// ─── Mock Data ─────────────────────────────────────────────────────────────────

const WORKER_CASES: WorkerCase[] = [
  {
    id: "1",
    initials: "MS",
    workerName: "Maria Santos",
    country: "Saudi Arabia",
    employer: "Al-Rashid Household Services",
    issue: "Wage Theft",
    reportId: "RPT-001",
    severity: "Critical",
    credibility: 85,
    status: "In Review",
    description: "Employer has not paid agreed salary for 3 months. Contract promised 5,000 SAR/month but only received 2,000 SAR since January 2026. Documents withheld.",
    reportDate: "2/28/2026",
    updatedDate: "Mar 12, 2026",
  },
  {
    id: "2",
    initials: "JR",
    workerName: "John Reyes",
    country: "Singapore",
    employer: "BuildRight Construction Pvt Ltd",
    issue: "Unsafe Working Conditions",
    reportId: "RPT-002",
    severity: "Critical",
    credibility: 92,
    status: "Pending",
    description: "Worker reports lack of safety equipment at construction site. No harnesses, helmets, or gloves provided. Multiple incidents of near-misses reported. Site supervisor dismissive of safety concerns.",
    reportDate: "3/10/2026",
    updatedDate: "Mar 11, 2026",
  },
  {
    id: "3",
    initials: "AD",
    workerName: "Anna Dela Cruz",
    country: "Hong Kong",
    employer: "Clean Family Residence",
    issue: "Physical Abuse",
    reportId: "RPT-003",
    severity: "Critical",
    credibility: 85,
    status: "Verified",
    description: "Domestic worker reports physical abuse by employer. Bruises documented on arms and back. Witness account from colleague confirms mistreatment. Medical records available.",
    reportDate: "3/05/2026",
    updatedDate: "Mar 8, 2026",
  },
  {
    id: "4",
    initials: "RC",
    workerName: "Roberto Cruz",
    country: "UAE",
    employer: "Dubai Hospitality Group",
    issue: "Document Confiscation",
    reportId: "RPT-004",
    severity: "Critical",
    credibility: 85,
    status: "In Review",
    description: "Employer has withheld passport and identification documents. Worker confined to employer premises. Unable to access services or seek medical help independently.",
    reportDate: "2/15/2026",
    updatedDate: "Mar 9, 2026",
  },
  {
    id: "5",
    initials: "LT",
    workerName: "Lisa Tan",
    country: "Kuwait",
    employer: "Al-Tabuk Trading Company",
    issue: "Unpaid Overtime",
    reportId: "RPT-005",
    severity: "Medium",
    credibility: 88,
    status: "Pending",
    description: "Worker consistently works 2-3 hours overtime daily without additional compensation. Payslips do not reflect actual hours worked. Requested time off denied.",
    reportDate: "3/02/2026",
    updatedDate: "Mar 10, 2026",
  },
  {
    id: "6",
    initials: "CM",
    workerName: "Carlos Martinez",
    country: "Saudi Arabia",
    employer: "Al-Rashid Household Services",
    issue: "Poor Living Conditions",
    reportId: "RPT-006",
    severity: "Critical",
    credibility: 85,
    status: "Revisit",
    description: "Workers housed in overcrowded accommodation without proper ventilation. Unsanitary conditions with limited access to clean water. Bedding and facilities substandard.",
    reportDate: "1/20/2026",
    updatedDate: "Mar 6, 2026",
  },
  {
    id: "7",
    initials: "PM",
    workerName: "Paulo Mendes",
    country: "Malaysia",
    employer: "Tech Solutions Asia",
    issue: "Wage Theft",
    reportId: "RPT-007",
    severity: "Medium",
    credibility: 85,
    status: "Revisit",
    description: "Deductions from salary not previously disclosed in employment contract. Company claims deductions for accommodation and utilities not paid by employee.",
    reportDate: "2/01/2026",
    updatedDate: "Mar 5, 2026",
  },
  {
    id: "8",
    initials: "SN",
    workerName: "Siti Nurul",
    country: "Malaysia",
    employer: "Global Staffing Services",
    issue: "Poor Living Conditions",
    reportId: "RPT-008",
    severity: "Medium",
    credibility: 85,
    status: "Archived",
    description: "Previous report status changed after employer improvements. Accommodation upgraded with better ventilation and sanitation facilities.",
    reportDate: "1/15/2026",
    updatedDate: "Mar 1, 2026",
  },
];

const ISSUE_TYPES = [
  "Wage Theft",
  "Unsafe Working Conditions",
  "Physical Abuse",
  "Document Confiscation",
  "Unpaid Overtime",
  "Poor Living Conditions",
];

const COUNTRIES = [
  "Saudi Arabia",
  "Singapore",
  "Hong Kong",
  "UAE",
  "Kuwait",
  "Malaysia",
];

const STATUS_OPTIONS = ["Pending", "In Review", "Verified", "Archived", "Revisit"];

// ─── Component ────────────────────────────────────────────────────────────────

export function Monitoring() {
  const navigate = useNavigate();
  const { unreadCount } = useNotifications();
  const { signOut } = useAuth();
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedCountry, setSelectedCountry] = useState("All Countries");
  const [selectedIssue, setSelectedIssue] = useState("All Issues");
  const [selectedStatus, setSelectedStatus] = useState("All Status");
  const [selectedCase, setSelectedCase] = useState<WorkerCase | null>(null);
  const [showModal, setShowModal] = useState(false);
  const [drawerOpen, setDrawerOpen] = useState(false);

  const handleLogout = async () => {
    await signOut();
    navigate(ROUTES.LOGIN);
  };

  const handlePrivacy = () => {
    navigate(ROUTES.PRIVACY);
  };

  const filteredCases = useMemo(() => {
    return WORKER_CASES.filter((case_) => {
      const matchesSearch =
        case_.workerName.toLowerCase().includes(searchTerm.toLowerCase()) ||
        case_.reportId.toLowerCase().includes(searchTerm.toLowerCase());

      const matchesCountry =
        selectedCountry === "All Countries" || case_.country === selectedCountry;

      const matchesIssue =
        selectedIssue === "All Issues" || case_.issue === selectedIssue;

      const matchesStatus =
        selectedStatus === "All Status" || case_.status === selectedStatus;

      return matchesSearch && matchesCountry && matchesIssue && matchesStatus;
    });
  }, [searchTerm, selectedCountry, selectedIssue, selectedStatus]);

  const getSeverityColor = (severity: string) => {
    switch (severity) {
      case "Critical":
        return "text-rose-600";
      case "High":
        return "text-orange-600";
      case "Medium":
        return "text-amber-600";
      case "Low":
        return "text-emerald-600";
      default:
        return "text-slate-600";
    }
  };

  const getStatusColors = (status: string) => {
    switch (status) {
      case "In Review":
        return { bg: "#DFEDFF", text: "#003696" };
      case "Pending":
        return { bg: "#FFFBE8", text: "#AD4B00" };
      case "Verified":
        return { bg: "#EEFDF3", text: "#00AA28" };
      case "Revisit":
        return { bg: "#FFF3F3", text: "#8E0012" };
      case "Archived":
        return { bg: "#F3F4F6", text: "#6B7280" };
      default:
        return { bg: "#F3F4F6", text: "#6B7280" };
    }
  };

  return (
    <div className="min-h-screen" style={{ backgroundColor: NgoColors.bg }}>
      {/* Header */}
      <header className="sticky top-0 z-20 border-b border-[#D9DCE3] bg-white/95 backdrop-blur w-full">
        <div className="mx-auto flex h-[54px] w-full items-center px-4 sm:px-6 lg:px-8">
          {/* Logo */}
          <div className="flex items-center gap-3 flex-shrink-0">
            <span className="h-6 w-6 rounded-full bg-[#003696]" />
            <p className="text-[20px] font-extrabold text-[#003696] tracking-[-0.03em]">Anchor</p>
          </div>

          {/* Center Navigation */}
          <nav className="hidden md:flex flex-1 items-center justify-center gap-12 text-[14px] font-semibold text-slate-500">
            <button onClick={() => navigate(ROUTES.DASHBOARD)} className="relative transition text-slate-500 hover:text-slate-700">Home</button>
            <button className="relative transition text-[#003696]">Monitoring<span className="absolute -bottom-[17px] left-1/2 h-[2px] w-20 -translate-x-1/2 rounded-full bg-[#003696]" /></button>
            <button onClick={() => navigate(ROUTES.ALERT)} className="relative transition text-slate-500 hover:text-slate-700">Alert</button>
          </nav>

          {/* Right Actions */}
          <div className="flex flex-shrink-0 items-center gap-3 text-slate-500 ml-auto">
            <button className="rounded-md p-1.5 hover:bg-slate-100 relative" onClick={() => navigate(ROUTES.NOTIFICATIONS)}>
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                <path strokeLinecap="round" strokeLinejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 00-5-5.917V4a1 1 0 10-2 0v1.083A6 6 0 006 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
              </svg>
              {unreadCount > 0 && (
                <span 
                  className="absolute top-0 right-0 flex h-5 w-5 items-center justify-center rounded-full text-[11px] font-bold text-white"
                  style={{ backgroundColor: "#8E0012" }}
                >
                  {unreadCount}
                </span>
              )}
            </button>
            <button className="rounded-md p-1.5 hover:bg-slate-100" onClick={() => setDrawerOpen(true)}>
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
          </div>
        </div>
      </header>

      {/* Drawer */}
      <NgoDrawer
        isOpen={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        onProfileClick={() => navigate(ROUTES.PROFILE)}
        onNotificationsClick={() => navigate(ROUTES.NOTIFICATIONS)}
        onPrivacyClick={handlePrivacy}
        onLogoutClick={handleLogout}
      />

      {/* Main Content */}
      <main className="mx-auto w-full px-4 py-6 sm:px-6 lg:px-8">
        <h1 className="text-[16px] font-extrabold tracking-[-0.01em] text-slate-900">Report Management</h1>

        {/* Search and Filters */}
        <div className="mt-5 flex flex-col gap-3 lg:flex-row lg:items-center">
          <label className="relative block flex-1">
            <span className="pointer-events-none absolute left-4 top-1/2 -translate-y-1/2 text-slate-300">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                <circle cx="11" cy="11" r="8" />
                <path strokeLinecap="round" d="M21 21l-4.3-4.3" />
              </svg>
            </span>
            <input
              type="text"
              placeholder="Search worker by name or case ID"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="h-[42px] w-full rounded-full border border-[#E2E5EA] bg-white pl-11 pr-4 text-[11px] text-slate-600 outline-none ring-[#003696]/15 transition focus:ring-4"
            />
          </label>

          <div className="grid grid-cols-1 gap-2 sm:grid-cols-3 lg:w-[520px]">
            {/* Country Filter */}
            <div className="relative">
              <select
                value={selectedCountry}
                onChange={(e) => setSelectedCountry(e.target.value)}
                className="h-[42px] w-full appearance-none rounded-full border border-[#E2E5EA] bg-white pl-11 pr-9 text-[11px] font-medium text-slate-600 outline-none ring-[#003696]/15 focus:ring-4"
              >
                <option>All Countries</option>
                {COUNTRIES.map((country) => (
                  <option key={country} value={country}>
                    {country}
                  </option>
                ))}
              </select>
              <span className="pointer-events-none absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M12 21s-6-4.35-6-10a6 6 0 1112 0c0 5.65-6 10-6 10z"/>
                  <circle cx="12" cy="11" r="2.5" />
                </svg>
              </span>
              <span className="pointer-events-none absolute right-4 top-1/2 -translate-y-1/2 text-slate-300">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M6 9l6 6 6-6" />
                </svg>
              </span>
            </div>

            {/* Issue Filter */}
            <div className="relative">
              <select
                value={selectedIssue}
                onChange={(e) => setSelectedIssue(e.target.value)}
                className="h-[42px] w-full appearance-none rounded-full border border-[#E2E5EA] bg-white pl-11 pr-9 text-[11px] font-medium text-slate-600 outline-none ring-[#003696]/15 focus:ring-4"
              >
                <option>All Issues</option>
                {ISSUE_TYPES.map((issue) => (
                  <option key={issue} value={issue}>
                    {issue}
                  </option>
                ))}
              </select>
              <span className="pointer-events-none absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M9 7V5a3 3 0 013-3h0a3 3 0 013 3v2m5 2H4a1 1 0 00-1 1v8a2 2 0 002 2h14a2 2 0 002-2v-8a1 1 0 00-1-1z"/>
                </svg>
              </span>
              <span className="pointer-events-none absolute right-4 top-1/2 -translate-y-1/2 text-slate-300">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M6 9l6 6 6-6" />
                </svg>
              </span>
            </div>

            {/* Status Filter */}
            <div className="relative">
              <select
                value={selectedStatus}
                onChange={(e) => setSelectedStatus(e.target.value)}
                className="h-[42px] w-full appearance-none rounded-full border border-[#E2E5EA] bg-white pl-11 pr-9 text-[11px] font-medium text-slate-600 outline-none ring-[#003696]/15 focus:ring-4"
              >
                <option>All Status</option>
                {STATUS_OPTIONS.map((status) => (
                  <option key={status} value={status}>
                    {status}
                  </option>
                ))}
              </select>
              <span className="pointer-events-none absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M12 8v4m0 4v.01M12 3a9 9 0 110 18 9 9 0 010-18z"/>
                </svg>
              </span>
              <span className="pointer-events-none absolute right-4 top-1/2 -translate-y-1/2 text-slate-300">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M6 9l6 6 6-6" />
                </svg>
              </span>
            </div>
          </div>
        </div>

        {/* Cases Grid */}
        {filteredCases.length > 0 ? (
          <div className="mt-6 grid w-full gap-4 md:grid-cols-2 lg:grid-cols-2">
            {filteredCases.map((case_) => (
              <article
                key={case_.id}
                className="rounded-[14px] border border-[#DEE2E8] bg-white p-4 shadow-[0_1px_2px_rgba(15,23,42,0.04)]"
              >
                {/* Card Header */}
                <div className="mb-3 flex items-start justify-between gap-3">
                  <div className="flex min-w-0 items-start gap-3">
                    <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-[#E7EAF0] text-[10px] font-bold text-slate-700">
                      {case_.initials}
                    </span>
                    <div className="min-w-0">
                      <p className="truncate text-[13px] font-bold text-slate-800">{case_.workerName}</p>
                      <p className="flex items-center gap-1 text-[10px] text-slate-400">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                          <path strokeLinecap="round" strokeLinejoin="round" d="M12 21s-6-4.35-6-10a6 6 0 1112 0c0 5.65-6 10-6 10z"/>
                          <circle cx="12" cy="11" r="2.5" />
                        </svg>
                        {case_.country}
                      </p>
                    </div>
                  </div>
                  <span
                    className="flex h-6 items-center whitespace-nowrap text-[10px] font-bold rounded-lg"
                    style={{
                      padding: "4px 12px",
                      backgroundColor: getStatusColors(case_.status).bg,
                      color: getStatusColors(case_.status).text,
                    }}
                  >
                    {case_.status}
                  </span>
                </div>

                {/* Card Body */}
                <div className="space-y-1 text-[11px] leading-5">
                  <p className="text-slate-500">
                    <span className="font-semibold text-slate-700">Employer:</span> {case_.employer}
                  </p>
                  <p className="text-slate-500">
                    <span className="font-semibold text-slate-700">Issue:</span> {case_.issue}
                  </p>
                  <p className="text-slate-500">
                    <span className="font-semibold text-slate-700">Report ID:</span> <span className="font-semibold" style={{ color: NgoColors.navy }}>{case_.reportId}</span>
                  </p>
                </div>

                {/* Severity and Credibility */}
                <div className="mt-3 space-y-1.5">
                  <div className="flex items-center justify-between text-[10px]">
                    <span className="text-slate-600">
                      Severity: <span className={`font-semibold ${getSeverityColor(case_.severity)}`}>{case_.severity}</span>
                    </span>
                  </div>
                  <div>
                    <div className="flex justify-between items-center mb-1">
                      <span className="text-[10px] text-slate-600">Credibility:</span>
                      <span className="text-[10px] font-semibold text-slate-900">{case_.credibility}%</span>
                    </div>
                    <div className="w-full bg-[#E2E5EA] rounded-full h-1.5">
                      <div
                        className="h-1.5 rounded-full transition-all"
                        style={{ width: `${case_.credibility}%`, backgroundColor: NgoColors.navy }}
                      />
                    </div>
                  </div>
                </div>

                {/* Action Buttons */}
                <div className="mt-3 flex gap-3">
                  <button 
                    onClick={() => {
                      setSelectedCase(case_);
                      setShowModal(true);
                    }}
                    className="flex-1 rounded-lg px-5 py-2 text-[12px] font-bold text-white hover:opacity-90 transition"
                    style={{ backgroundColor: NgoColors.navy }}
                  >
                    View Case
                  </button>
                  <button 
                    className="flex-1 rounded-lg px-5 py-2 text-[12px] font-bold hover:opacity-90 transition"
                    style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
                  >
                    Verify
                  </button>
                </div>
              </article>
            ))}
          </div>
        ) : (
          <p className="mt-5 rounded-2xl border border-dashed border-slate-300 bg-white px-5 py-10 text-center text-sm text-slate-500">
            No cases found. Try adjusting your filters.
          </p>
        )}
      </main>

      {/* Modal */}
      {showModal && selectedCase && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50">
          <div className="w-full max-w-2xl rounded-2xl bg-white p-8 shadow-xl mx-4 max-h-[90vh] overflow-y-auto">
            {/* Modal Header */}
            <div className="mb-6 flex items-start justify-between">
              <div>
                <div className="flex items-baseline gap-2">
                  <h3 className="text-[20px] font-bold text-slate-900">Report Details</h3>
                  <p className="text-[16px] font-bold" style={{ color: NgoColors.navy }}>{selectedCase.reportId}</p>
                </div>
                <p className="mt-1 text-[13px] text-slate-500">Review and manage report status</p>
              </div>
              <button 
                onClick={() => setShowModal(false)}
                className="text-slate-400 hover:text-slate-600"
              >
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            {/* Info Boxes */}
            <div className="grid grid-cols-3 gap-3 mb-6">
              <div className="rounded-xl border-2 border-[#E5E7EB] p-4">
                <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-1 flex items-center gap-1.5">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke={NgoColors.navy} strokeWidth="2">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8z" />
                  </svg>
                  Worker
                </p>
                <p className="text-[14px] font-bold text-slate-900">{selectedCase.workerName}</p>
              </div>
              <div className="rounded-xl border-2 border-[#E5E7EB] p-4">
                <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-1 flex items-center gap-1.5">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke={NgoColors.navy} strokeWidth="2">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M12 21s-6-4.35-6-10a6 6 0 1112 0c0 5.65-6 10-6 10z"/>
                    <circle cx="12" cy="11" r="2.5" />
                  </svg>
                  Location
                </p>
                <p className="text-[14px] font-bold text-slate-900">{selectedCase.country}</p>
              </div>
              <div className="rounded-xl border-2 border-[#E5E7EB] p-4">
                <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-1 flex items-center gap-1.5">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke={NgoColors.navy} strokeWidth="2">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                  </svg>
                  Date
                </p>
                <p className="text-[14px] font-bold text-slate-900">{selectedCase.reportDate}</p>
              </div>
            </div>

            {/* Main Content */}
            <div className="grid grid-cols-3 gap-6 mb-6">
              {/* Left Column */}
              <div className="col-span-2 space-y-4">
                <div>
                  <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-1">Employer</p>
                  <p className="text-[14px] font-semibold text-slate-900">{selectedCase.employer}</p>
                </div>
                <div>
                  <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-1">Issue Type</p>
                  <p className="text-[14px] font-semibold text-slate-900">{selectedCase.issue}</p>
                </div>
                <div>
                  <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-1">Severity</p>
                  <p className={`text-[12px] font-bold inline-block px-3 py-1 rounded-full ${
                    selectedCase.severity === "Critical" ? "bg-rose-100 text-rose-700" : "bg-orange-100 text-orange-700"
                  }`}>
                    {selectedCase.severity}
                  </p>
                </div>
                <div>
                  <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-1">Status</p>
                  <p className="text-[12px] font-bold inline-block px-3 py-1 rounded-full bg-blue-100" style={{ color: "#0284C7" }}>
                    {selectedCase.status}
                  </p>
                </div>
              </div>

              {/* Right Column - Credibility Score */}
              <div className="rounded-2xl border border-[#E5E7EB] p-6 flex flex-col items-center justify-center">
                <div className="relative w-32 h-32 flex items-center justify-center mb-3">
                  <svg className="w-full h-full" viewBox="0 0 120 120">
                    <circle cx="60" cy="60" r="54" fill="none" stroke="#E5E7EB" strokeWidth="8" />
                    <circle 
                      cx="60" cy="60" r="54" fill="none" 
                      stroke={NgoColors.navy} strokeWidth="8"
                      strokeDasharray={`${(selectedCase.credibility / 100) * 340} 340`}
                      strokeLinecap="round"
                      style={{ transform: 'rotate(-90deg)', transformOrigin: '60px 60px' }}
                    />
                  </svg>
                  <div className="absolute text-center">
                    <p className="text-[28px] font-bold text-slate-900">{selectedCase.credibility}%</p>
                  </div>
                </div>
                <p className="text-[11px] font-bold text-slate-600 uppercase text-center">Credibility Score</p>
                <p className="text-[11px] text-slate-500 text-center mt-2">Last updated: Mar 9, 2026</p>
              </div>
            </div>

            {/* Description */}
            <div className="mb-6">
              <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-2">Description</p>
              <p className="text-[13px] text-slate-700 leading-relaxed">{selectedCase.description}</p>
            </div>

            {/* Review Notes */}
            <div className="mb-6">
              <p className="text-[11px] font-bold text-slate-600 uppercase tracking-wide mb-2">Review Notes</p>
              <textarea 
                placeholder="Add review notes..."
                className="w-full h-24 rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] p-3 text-[13px] text-slate-700 placeholder-slate-400 outline-none"
              />
            </div>

            {/* Action Buttons */}
            <div className="flex gap-3">
              <button 
                className="flex-1 h-10 rounded-lg text-[13px] font-semibold text-white hover:opacity-90 transition"
                style={{ backgroundColor: NgoColors.navy }}
              >
                Verify Report
              </button>
              <button 
                className="flex-1 h-10 rounded-lg text-[13px] font-semibold hover:opacity-90 transition"
                style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
              >
                Mark Resolved
              </button>
              <button 
                onClick={() => setShowModal(false)}
                className="flex-1 h-10 rounded-lg text-[13px] font-semibold hover:opacity-90 transition"
                style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
              >
                Dismiss
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
