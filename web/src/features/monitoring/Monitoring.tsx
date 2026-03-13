import { useMemo, useState } from "react";
import { AppHeader } from "../../components/layout/AppHeader";

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
  statusBadgeTone: "sky" | "amber" | "emerald" | "slate" | "orange" | "rose";
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
    statusBadgeTone: "orange",
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
    statusBadgeTone: "rose",
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
    statusBadgeTone: "emerald",
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
    statusBadgeTone: "sky",
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
    statusBadgeTone: "amber",
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
    statusBadgeTone: "slate",
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
    statusBadgeTone: "slate",
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
    statusBadgeTone: "slate",
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

// ─── Helpers ───────────────────────────────────────────────────────────────────

function getBadgeColors(tone: "sky" | "amber" | "emerald" | "slate" | "orange" | "rose") {
  const colorMap = {
    sky: { borderColor: "#0284C7", bgColor: "#0284C7" },
    amber: { borderColor: "#AD4B00", bgColor: "#AD4B00" },
    emerald: { borderColor: "#00AA28", bgColor: "#00AA28" },
    slate: { borderColor: "#6B7280", bgColor: "#6B7280" },
    orange: { borderColor: "#F54900", bgColor: "#F54900" },
    rose: { borderColor: "#8E0012", bgColor: "#8E0012" },
  };
  return colorMap[tone];
}

// ─── Component ────────────────────────────────────────────────────────────────

export function Monitoring() {
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedCountry, setSelectedCountry] = useState("All Countries");
  const [selectedIssue, setSelectedIssue] = useState("All Issues");
  const [selectedStatus, setSelectedStatus] = useState("All Status");
  const [selectedCase, setSelectedCase] = useState<WorkerCase | null>(null);
  const [showModal, setShowModal] = useState(false);

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

  return (
    <div className="min-h-screen bg-[#F6F6F8]">
      <AppHeader />

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
                className="h-[42px] w-full appearance-none rounded-full border border-[#E2E5EA] bg-white px-4 pr-9 text-[11px] font-medium text-slate-600 outline-none ring-[#003696]/15 focus:ring-4"
              >
                <option>All Countries</option>
                {COUNTRIES.map((country) => (
                  <option key={country} value={country}>
                    {country}
                  </option>
                ))}
              </select>
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
                className="h-[42px] w-full appearance-none rounded-full border border-[#E2E5EA] bg-white px-4 pr-9 text-[11px] font-medium text-slate-600 outline-none ring-[#003696]/15 focus:ring-4"
              >
                <option>All Issues</option>
                {ISSUE_TYPES.map((issue) => (
                  <option key={issue} value={issue}>
                    {issue}
                  </option>
                ))}
              </select>
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
                className="h-[42px] w-full appearance-none rounded-full border border-[#E2E5EA] bg-white px-4 pr-9 text-[11px] font-medium text-slate-600 outline-none ring-[#003696]/15 focus:ring-4"
              >
                <option>All Status</option>
                {STATUS_OPTIONS.map((status) => (
                  <option key={status} value={status}>
                    {status}
                  </option>
                ))}
              </select>
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
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            d="M12 21s-6-4.35-6-10a6 6 0 1112 0c0 5.65-6 10-6 10z"
                          />
                          <circle cx="12" cy="11" r="2.5" />
                        </svg>
                        {case_.country}
                      </p>
                    </div>
                  </div>
                  {(() => {
                    const colors = getBadgeColors(case_.statusBadgeTone);
                    return (
                      <span
                        className="flex h-6 items-center whitespace-nowrap text-[10px] font-bold"
                        style={{
                          padding: "4px 12px",
                          borderRadius: "8px",
                          border: `1px solid ${colors.borderColor}`,
                          backgroundColor: `rgba(${parseInt(colors.bgColor.slice(1, 3), 16)}, ${parseInt(colors.bgColor.slice(3, 5), 16)}, ${parseInt(colors.bgColor.slice(5, 7), 16)}, 0.20)`,
                          color: colors.borderColor,
                        }}
                      >
                        {case_.status}
                      </span>
                    );
                  })()}
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
                    <span className="font-semibold text-slate-700">Report ID:</span> <span className="font-semibold text-[#003696]">{case_.reportId}</span>
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
                        className="bg-[#003696] h-1.5 rounded-full transition-all"
                        style={{ width: `${case_.credibility}%` }}
                      />
                    </div>
                  </div>
                </div>

                {/* Action Buttons */}
                <div className="mt-3 flex gap-2">
                  <button 
                    onClick={() => {
                      setSelectedCase(case_);
                      setShowModal(true);
                    }}
                    className="flex-1 h-7 rounded-[4px] bg-[#003696] text-[10px] font-semibold text-white hover:bg-[#002060]"
                  >
                    View Case
                  </button>
                  <button className="flex-1 h-7 rounded-[4px] border border-[#E2E5EA] text-[10px] font-semibold text-slate-600 hover:bg-slate-50">
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
            <div className="mb-5 flex items-start justify-between">
              <div>
                <div className="flex items-baseline gap-2">
                  <h3 className="text-[20px] font-bold text-slate-900">Report Details</h3>
                  <p className="text-[16px] font-bold text-[#003696]">{selectedCase.reportId}</p>
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

            {/* Worker Info Pills */}
            <div className="mb-6 grid grid-cols-3 gap-3">
              <div 
                className="flex flex-1 h-14 items-center justify-center gap-3 rounded-[12px] border-2 px-6"
                style={{
                  borderColor: "#003696",
                  backgroundColor: "rgba(0, 54, 150, 0.05)"
                }}
              >
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#003696" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2M12 3a4 4 0 1 0 0 8 4 4 0 0 0 0-8z" />
                </svg>
                <div className="text-center">
                  <p className="text-[8px] text-slate-500 font-bold uppercase tracking-wider">Worker</p>
                  <p className="text-[13px] font-bold text-slate-900">{selectedCase.workerName}</p>
                </div>
              </div>
              <div 
                className="flex flex-1 h-14 items-center justify-center gap-3 rounded-[12px] border-2 px-6"
                style={{
                  borderColor: "#003696",
                  backgroundColor: "rgba(0, 54, 150, 0.05)"
                }}
              >
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#003696" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path strokeLinecap="round" strokeLinejoin="round" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
                <div className="text-center">
                  <p className="text-[8px] text-slate-500 font-bold uppercase tracking-wider">Location</p>
                  <p className="text-[13px] font-bold text-slate-900">{selectedCase.country}</p>
                </div>
              </div>
              <div 
                className="flex flex-1 h-14 items-center justify-center gap-3 rounded-[12px] border-2 px-6"
                style={{
                  borderColor: "#003696",
                  backgroundColor: "rgba(0, 54, 150, 0.05)"
                }}
              >
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#003696" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                </svg>
                <div className="text-center">
                  <p className="text-[8px] text-slate-500 font-bold uppercase tracking-wider">Date</p>
                  <p className="text-[13px] font-bold text-slate-900">{selectedCase.reportDate}</p>
                </div>
              </div>
            </div>

            {/* Content Grid: Details on left, Credibility on right */}
            <div className="mb-6 grid grid-cols-[1fr_1fr] gap-6">
              {/* Left Column: Details */}
              <div className="space-y-4">
                <div>
                  <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Employer</p>
                  <p className="mt-2 text-[13px] font-semibold text-slate-900">{selectedCase.employer}</p>
                </div>
                <div>
                  <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Issue Type</p>
                  <p className="mt-2 text-[13px] font-semibold text-slate-900">{selectedCase.issue}</p>
                </div>
                <div>
                  <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Severity</p>
                  <p className={`mt-2 text-[13px] font-bold ${getSeverityColor(selectedCase.severity)}`}>{selectedCase.severity.toUpperCase()}</p>
                </div>
                <div>
                  <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Status</p>
                  <div className="mt-2">
                    {(() => {
                      const colors = getBadgeColors(selectedCase.statusBadgeTone);
                      return (
                        <span
                          className="inline-flex h-6 items-center whitespace-nowrap rounded-lg text-[10px] font-bold"
                          style={{
                            padding: "4px 12px",
                            border: `1px solid ${colors.borderColor}`,
                            backgroundColor: `rgba(${parseInt(colors.bgColor.slice(1, 3), 16)}, ${parseInt(colors.bgColor.slice(3, 5), 16)}, ${parseInt(colors.bgColor.slice(5, 7), 16)}, 0.20)`,
                            color: colors.borderColor,
                          }}
                        >
                          {selectedCase.status}
                        </span>
                      );
                    })()}
                  </div>
                </div>
              </div>

              {/* Right Column: Credibility Circle */}
              <div className="flex flex-col items-center justify-center rounded-2xl border border-[#E5E7EB] bg-[#F9FAFB] p-6">
                <div className="relative h-[140px] w-[140px] mb-4">
                  <svg className="h-full w-full -rotate-90" viewBox="0 0 100 100">
                    <circle cx="50" cy="50" r="40" fill="none" stroke="#E5E7EB" strokeWidth="8" />
                    <circle 
                      cx="50" 
                      cy="50" 
                      r="40" 
                      fill="none" 
                      stroke="#003696" 
                      strokeWidth="8"
                      strokeDasharray={`${2 * Math.PI * 40 * (selectedCase.credibility / 100)} ${2 * Math.PI * 40}`}
                      strokeLinecap="round"
                    />
                  </svg>
                  <div className="absolute inset-0 flex flex-col items-center justify-center">
                    <span className="text-[32px] font-bold text-slate-900">{selectedCase.credibility}%</span>
                    <span className="text-[9px] font-semibold text-slate-500 uppercase">Credibility Score</span>
                  </div>
                </div>
                <p className="text-[11px] text-slate-500 text-center">Last updated: {selectedCase.updatedDate}</p>
              </div>
            </div>

            {/* Description */}
            <div className="mb-6">
              <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-2">Description</p>
              <p className="text-[12px] leading-5 text-slate-600 bg-[#F9FAFB] p-4 rounded-lg">
                {selectedCase.description}
              </p>
            </div>

            {/* Review Notes */}
            <div className="mb-6">
              <p className="text-[10px] font-bold text-slate-500 uppercase tracking-wider mb-2">Review Notes</p>
              <textarea 
                placeholder="Add review notes..."
                className="w-full rounded-lg border border-[#E2E5EA] bg-[#F9FAFB] p-4 text-[12px] text-slate-600 placeholder-slate-400 outline-none focus:ring-4 focus:ring-[#003696]/15"
                rows={4}
              />
            </div>

            {/* Action Buttons */}
            <div className="flex gap-3">
              <button className="flex-1 h-10 rounded-lg bg-[#003696] text-[13px] font-semibold text-white hover:bg-[#002060] transition">
                Verify Report
              </button>
              <button className="flex-1 h-10 rounded-lg bg-[#DFEDFF] text-[13px] font-semibold text-[#003696] hover:bg-[#C4DFFF] transition">
                Mark Resolved
              </button>
              <button 
                onClick={() => setShowModal(false)}
                className="flex-1 h-10 rounded-lg border border-[#E5E7EB] bg-white text-[13px] font-semibold text-slate-700 hover:bg-slate-50 transition"
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
