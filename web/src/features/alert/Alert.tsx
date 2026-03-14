import { useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ROUTES } from "../../core/config/routes";
import { NgoColors } from "../../core/theme/ngo-colors";
import { NgoDrawer } from "../../components/layout/NgoDrawer";
import { useNotifications } from "../../core/context/NotificationContext";
import { useAuth } from "../../core/context/AuthContext";

// ─── Types ────────────────────────────────────────────────────────────────────

interface AlertItem {
  id: string;
  title: string;
  type: string;
  target: string;
  country: string;
  alertId: string;
  createdDate: string;
  createdBy: string;
  description: string;
  severity: "HIGH" | "MEDIUM" | "LOW";
}

// ─── Mock Data ─────────────────────────────────────────────────────────────────

const ALERTS: AlertItem[] = [
  {
    id: "1",
    title: "High Risk Employer Alert: Al-Rashid Household Services",
    type: "Employer Warning",
    target: "Al-Rashid Household Services",
    country: "Saudi Arabia",
    alertId: "ALT-001",
    createdDate: "Mar 8, 2026",
    createdBy: "Admin User",
    description: "Multiple reports of wage theft and contract violations. 12 verified incidents in the past 6 months. Workers advised to avoid employment with this organization.",
    severity: "HIGH",
  },
  {
    id: "2",
    title: "Medium Risk Employer Alert: Dubai Hospitality Group",
    type: "Employer Warning",
    target: "Dubai Hospitality Group",
    country: "UAE",
    alertId: "ALT-002",
    createdDate: "Mar 7, 2026",
    createdBy: "Admin User",
    description: "Several reports of contract violations and wage delays. Unconfirmed incidents reported. Monitor situation.",
    severity: "MEDIUM",
  },
  {
    id: "3",
    title: "Low Risk Alert: SafeTech Construction",
    type: "Employer Warning",
    target: "SafeTech Construction",
    country: "Singapore",
    alertId: "ALT-003",
    createdDate: "Mar 6, 2026",
    createdBy: "Admin User",
    description: "Minor issues resolved. Status update required. Organization has improved documentation.",
    severity: "LOW",
  },
  {
    id: "4",
    title: "High Risk Employer Alert: MegaConstruct Ltd",
    type: "Employer Warning",
    target: "MegaConstruct Ltd",
    country: "Kuwait",
    alertId: "ALT-004",
    createdDate: "Mar 5, 2026",
    createdBy: "Admin User",
    description: "Multiple reports of unsafe working conditions and wage theft. 15 verified incidents in the past 6 months.",
    severity: "HIGH",
  },
  {
    id: "5",
    title: "Medium Risk Alert: Global Services Inc",
    type: "Employer Warning",
    target: "Global Services Inc",
    country: "Hong Kong",
    alertId: "ALT-005",
    createdDate: "Mar 4, 2026",
    createdBy: "Admin User",
    description: "Reports of inconsistent contract terms and potential wage deductions. Investigation ongoing.",
    severity: "MEDIUM",
  },
  {
    id: "6",
    title: "Low Risk Alert: Premium Hotels Malaysia",
    type: "Employer Warning",
    target: "Premium Hotels Malaysia",
    country: "Malaysia",
    alertId: "ALT-006",
    createdDate: "Mar 3, 2026",
    createdBy: "Admin User",
    description: "Minor administrative issues. Organization cooperative with authorities.",
    severity: "LOW",
  },
  {
    id: "7",
    title: "High Risk Employer Alert: Vision Recruitment",
    type: "Employer Warning",
    target: "Vision Recruitment",
    country: "Saudi Arabia",
    alertId: "ALT-007",
    createdDate: "Mar 2, 2026",
    createdBy: "Admin User",
    description: "Multiple reports of wage theft and contract violations. 12 verified incidents in the past 6 months. Workers advised to avoid employment with this organization.",
    severity: "HIGH",
  },
  {
    id: "8",
    title: "Medium Risk Alert: Eastern Trade Company",
    type: "Employer Warning",
    target: "Eastern Trade Company",
    country: "Saudi Arabia",
    alertId: "ALT-008",
    createdDate: "Mar 1, 2026",
    createdBy: "Admin User",
    description: "Reports of delayed wage payments and contract disputes. Situation requires monitoring.",
    severity: "MEDIUM",
  },
];

const COUNTRIES = [
  "Saudi Arabia",
  "Singapore",
  "Hong Kong",
  "UAE",
  "Kuwait",
  "Malaysia",
];

const ISSUE_TYPES = [
  "Wage Theft",
  "Unsafe Working Conditions",
  "Physical Abuse",
  "Document Confiscation",
  "Unpaid Overtime",
  "Poor Living Conditions",
];

const STATUS_OPTIONS = ["Active", "Inactive", "Archived"];

// ─── Helpers ───────────────────────────────────────────────────────────────────

function getSeverityColors(severity: "HIGH" | "MEDIUM" | "LOW") {
  switch (severity) {
    case "HIGH":
      return {
        bgIcon: "bg-[#FFF3F3]",
        textIcon: "stroke-[#8E0012]",
        borderColor: "#8E0012",
        bgColor: "#FFF3F3",
        textColor: "#8E0012",
        textBadge: "text-[#8E0012]",
      };
    case "MEDIUM":
      return {
        bgIcon: "bg-[#FFFBE8]",
        textIcon: "stroke-[#AD4B00]",
        borderColor: "#AD4B00",
        bgColor: "#FFFBE8",
        textColor: "#AD4B00",
        textBadge: "text-[#AD4B00]",
      };
    case "LOW":
      return {
        bgIcon: "bg-[#EEFDF3]",
        textIcon: "stroke-[#00AA28]",
        borderColor: "#00AA28",
        bgColor: "#EEFDF3",
        textColor: "#00AA28",
        textBadge: "text-[#00AA28]",
      };
    default:
      return {
        bgIcon: "bg-slate-100",
        textIcon: "stroke-slate-600",
        borderColor: "#6B7280",
        bgColor: "#F3F4F6",
        textColor: "#6B7280",
        textBadge: "text-slate-600",
      };
  }
}

// ─── Component ─────────────────────────────────────────────────────────────────────────

export function Alert() {
  const navigate = useNavigate();
  const { unreadCount } = useNotifications();
  const { signOut } = useAuth();
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedCountry, setSelectedCountry] = useState("All Countries");
  const [selectedIssue, setSelectedIssue] = useState("All Issues");
  const [selectedStatus, setSelectedStatus] = useState("All Status");
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [showEditModal, setShowEditModal] = useState(false);
  const [formData, setFormData] = useState({
    title: "",
    type: "Employer Warning",
    severity: "Medium",
    employerName: "",
    country: "",
    description: "",
  });

  const handleLogout = async () => {
    await signOut();
    navigate(ROUTES.LOGIN);
  };

  const handlePrivacy = () => {
    navigate(ROUTES.PRIVACY);
  };

  const filteredAlerts = useMemo(() => {
    return ALERTS.filter((alert) => {
      const matchesSearch =
        alert.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        alert.alertId.toLowerCase().includes(searchTerm.toLowerCase());

      const matchesCountry =
        selectedCountry === "All Countries" || alert.country === selectedCountry;

      const matchesIssue =
        selectedIssue === "All Issues" || alert.type.includes(selectedIssue);

      const matchesStatus =
        selectedStatus === "All Status";

      return matchesSearch && matchesCountry && matchesIssue && matchesStatus;
    });
  }, [searchTerm, selectedCountry, selectedIssue, selectedStatus]);

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
            <button onClick={() => navigate(ROUTES.MONITORING)} className="relative transition text-slate-500 hover:text-slate-700">Monitoring</button>
            <button className="relative transition text-[#003696]">Alert<span className="absolute -bottom-[17px] left-1/2 h-[2px] w-16 -translate-x-1/2 rounded-full bg-[#003696]" /></button>
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

      <main className="mx-auto w-full px-4 py-6 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between mb-4">
          <h1 className="text-[16px] font-extrabold tracking-[-0.01em] text-slate-900">Alert Generation</h1>
          <button
            onClick={() => {
              setFormData({
                title: "",
                type: "Employer Warning",
                severity: "Medium",
                employerName: "",
                country: "",
                description: "",
              });
              setShowCreateModal(true);
            }}
            className="h-9 px-4 rounded-lg bg-[#003696] text-white text-[13px] font-semibold hover:opacity-90 transition"
          >
            + New Alert
          </button>
        </div>

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
              placeholder="Search alert or employer..."
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

        {/* Alerts Grid */}
        {filteredAlerts.length > 0 ? (
          <div className="mt-6 grid w-full gap-4 md:grid-cols-2 lg:grid-cols-2">
            {filteredAlerts.map((alert) => (
              <article
                key={alert.id}
                className="rounded-[14px] border border-[#DEE2E8] bg-white p-4 shadow-[0_1px_2px_rgba(15,23,42,0.04)]"
              >
                {/* Header with Icon, Title, and Badge */}
                <div className="mb-3 flex items-start gap-3">
                  {(() => {
                    const colors = getSeverityColors(alert.severity);
                    const strokeColor = colors.textIcon.replace("stroke-", "").split("-")[0] === "rose" ? "#e11d48" : colors.textIcon.replace("stroke-", "").split("-")[0] === "amber" ? "#d97706" : "#059669";
                    return (
                      <div className={`flex h-7 w-7 shrink-0 items-center justify-center rounded-full ${colors.bgIcon}`}>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 28 28" fill="none">
                          <path d="M25.3518 21.0001L16.0185 4.66677C15.815 4.30767 15.5199 4.00899 15.1632 3.80118C14.8066 3.59337 14.4012 3.48389 13.9885 3.48389C13.5757 3.48389 13.1704 3.59337 12.8138 3.80118C12.4571 4.00899 12.162 4.30767 11.9585 4.66677L2.62516 21.0001C2.41946 21.3564 2.31159 21.7607 2.31251 22.172C2.31342 22.5834 2.42307 22.9872 2.63035 23.3426C2.83763 23.6979 3.13517 23.9921 3.49281 24.1954C3.85045 24.3987 4.25547 24.5038 4.66683 24.5001H23.3335C23.7429 24.4997 24.1449 24.3916 24.4993 24.1866C24.8537 23.9816 25.1479 23.687 25.3524 23.3324C25.5569 22.9778 25.6645 22.5756 25.6644 22.1662C25.6643 21.7568 25.5565 21.3546 25.3518 21.0001Z" stroke={strokeColor} strokeWidth="2.33333" strokeLinecap="round" strokeLinejoin="round"/>
                          <path d="M14 10.5002V15.1669" stroke={strokeColor} strokeWidth="2.33333" strokeLinecap="round" strokeLinejoin="round"/>
                          <path d="M14 19.8333H14.0117" stroke={strokeColor} strokeWidth="2.33333" strokeLinecap="round" strokeLinejoin="round"/>
                        </svg>
                      </div>
                    );
                  })()}
                  <div className="flex min-w-0 flex-1">
                    <div>
                      <p className="truncate text-[13px] font-bold text-slate-800">{alert.title}</p>
                      <p className="flex items-center gap-1 text-[10px] text-slate-400 mt-0.5">{alert.type}</p>
                    </div>
                  </div>
                  {(() => {
                    const colors = getSeverityColors(alert.severity);
                    return (
                      <span
                        className="flex h-6 items-center whitespace-nowrap text-[10px] font-bold rounded-lg"
                        style={{
                          padding: "4px 12px",
                          backgroundColor: colors.bgColor,
                          color: colors.textColor,
                        }}
                      >
                        {alert.severity}
                      </span>
                    );
                  })()}
                </div>

                {/* Alert Details */}
                <div className="space-y-1 text-[11px] leading-5">
                  <p className="text-slate-500">
                    <span className="font-semibold text-slate-700">Target:</span> {alert.target}
                  </p>
                  <p className="text-slate-500">
                    <span className="font-semibold text-slate-700">Country:</span> {alert.country}
                  </p>
                  <p className="text-slate-500">
                    <span className="font-semibold text-slate-700">Alert ID:</span> <span className="font-semibold" style={{ color: NgoColors.navy }}>{alert.alertId}</span>
                  </p>
                </div>

                {/* Action Buttons */}
                <div className="mt-3 flex gap-3">
                  <button 
                    onClick={() => {
                      setFormData({
                        title: alert.title,
                        type: alert.type,
                        severity: alert.severity,
                        employerName: alert.target,
                        country: alert.country,
                        description: alert.description,
                      });
                      setShowEditModal(true);
                    }}
                    className="flex-1 rounded-lg px-5 py-2 text-[12px] font-bold text-white hover:opacity-90 transition"
                    style={{ backgroundColor: NgoColors.navy }}
                  >
                    Edit Alert
                  </button>
                  <button 
                    onClick={() => {
                      // Handle delete
                    }}
                    className="flex-1 rounded-lg px-5 py-2 text-[12px] font-bold hover:opacity-90 transition"
                    style={{ backgroundColor: NgoColors.blueLight, color: NgoColors.navy }}
                  >
                    Delete
                  </button>
                </div>
              </article>
            ))}
          </div>
        ) : (
          <p className="mt-5 rounded-[14px] border border-dashed border-slate-300 bg-white px-4 py-6 text-center text-[13px] text-slate-500">
            No alerts found. Try adjusting your filters.
          </p>
        )}
      </main>

      {/* Create Alert Modal */}
      {showCreateModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50">
          <div className="w-full max-w-2xl rounded-2xl bg-white p-8 shadow-xl mx-4">
            <div className="mb-6 flex items-start justify-between">
              <div>
                <h3 className="text-[20px] font-bold text-slate-900">Create New Alert</h3>
                <p className="mt-1 text-[13px] text-slate-500">Fill in the details to create a new safety alert</p>
              </div>
              <button 
                onClick={() => setShowCreateModal(false)}
                className="text-slate-400 hover:text-slate-600"
              >
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <div className="space-y-4 mb-6">
              <div>
                <label className="block text-[12px] font-bold text-slate-700 mb-2">Alert Title *</label>
                <input 
                  type="text"
                  placeholder="Enter alert title..."
                  value={formData.title}
                  onChange={(e) => setFormData({...formData, title: e.target.value})}
                  className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-[12px] font-bold text-slate-700 mb-2">Alert Type *</label>
                  <select 
                    value={formData.type}
                    onChange={(e) => setFormData({...formData, type: e.target.value})}
                    className="w-full rounded-lg border border-[#E5E7EB] bg-white px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                  >
                    <option>Employer Warning</option>
                    <option>Safety Alert</option>
                    <option>Compliance Issue</option>
                  </select>
                </div>
                <div>
                  <label className="block text-[12px] font-bold text-slate-700 mb-2">Severity *</label>
                  <select 
                    value={formData.severity}
                    onChange={(e) => setFormData({...formData, severity: e.target.value})}
                    className="w-full rounded-lg border border-[#E5E7EB] bg-white px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                  >
                    <option>Low</option>
                    <option>Medium</option>
                    <option>High</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-[12px] font-bold text-slate-700 mb-2">Employer Name</label>
                  <input 
                    type="text"
                    placeholder="Enter employer name..."
                    value={formData.employerName}
                    onChange={(e) => setFormData({...formData, employerName: e.target.value})}
                    className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                  />
                </div>
                <div>
                  <label className="block text-[12px] font-bold text-slate-700 mb-2">Country</label>
                  <input 
                    type="text"
                    placeholder="Enter country..."
                    value={formData.country}
                    onChange={(e) => setFormData({...formData, country: e.target.value})}
                    className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                  />
                </div>
              </div>

              <div>
                <label className="block text-[12px] font-bold text-slate-700 mb-2">Description *</label>
                <textarea 
                  placeholder="Provide detailed information about this alert..."
                  value={formData.description}
                  onChange={(e) => setFormData({...formData, description: e.target.value})}
                  className="w-full h-24 rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                />
              </div>
            </div>

            <div className="flex gap-3">
              <button 
                onClick={() => setShowCreateModal(false)}
                className="flex-1 h-10 rounded-lg border border-[#E5E7EB] bg-white text-[13px] font-semibold text-slate-700 hover:bg-slate-50 transition"
              >
                Cancel
              </button>
              <button 
                className="flex-1 h-10 rounded-lg text-[13px] font-semibold text-white hover:opacity-90 transition"
                style={{ backgroundColor: NgoColors.navy }}
              >
                Create Alert
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Edit Alert Modal */}
      {showEditModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50">
          <div className="w-full max-w-2xl rounded-2xl bg-white p-8 shadow-xl mx-4">
            <div className="mb-6 flex items-start justify-between">
              <div>
                <h3 className="text-[20px] font-bold text-slate-900">Edit Alert</h3>
                <p className="mt-1 text-[13px] text-slate-500">Update the alert details below</p>
              </div>
              <button 
                onClick={() => setShowEditModal(false)}
                className="text-slate-400 hover:text-slate-600"
              >
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <div className="space-y-4 mb-6">
              <div>
                <label className="block text-[12px] font-bold text-slate-700 mb-2">Alert Title *</label>
                <input 
                  type="text"
                  placeholder="Enter alert title..."
                  value={formData.title}
                  onChange={(e) => setFormData({...formData, title: e.target.value})}
                  className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-[12px] font-bold text-slate-700 mb-2">Alert Type *</label>
                  <select 
                    value={formData.type}
                    onChange={(e) => setFormData({...formData, type: e.target.value})}
                    className="w-full rounded-lg border border-[#E5E7EB] bg-white px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                  >
                    <option>Employer Warning</option>
                    <option>Safety Alert</option>
                    <option>Compliance Issue</option>
                  </select>
                </div>
                <div>
                  <label className="block text-[12px] font-bold text-slate-700 mb-2">Severity *</label>
                  <select 
                    value={formData.severity}
                    onChange={(e) => setFormData({...formData, severity: e.target.value})}
                    className="w-full rounded-lg border border-[#E5E7EB] bg-white px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                  >
                    <option>Low</option>
                    <option>Medium</option>
                    <option>High</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-[12px] font-bold text-slate-700 mb-2">Employer Name</label>
                  <input 
                    type="text"
                    placeholder="Enter employer name..."
                    value={formData.employerName}
                    onChange={(e) => setFormData({...formData, employerName: e.target.value})}
                    className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                  />
                </div>
                <div>
                  <label className="block text-[12px] font-bold text-slate-700 mb-2">Country</label>
                  <input 
                    type="text"
                    placeholder="Enter country..."
                    value={formData.country}
                    onChange={(e) => setFormData({...formData, country: e.target.value})}
                    className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                  />
                </div>
              </div>

              <div>
                <label className="block text-[12px] font-bold text-slate-700 mb-2">Description *</label>
                <textarea 
                  placeholder="Provide detailed information about this alert..."
                  value={formData.description}
                  onChange={(e) => setFormData({...formData, description: e.target.value})}
                  className="w-full h-24 rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] outline-none focus:ring-4 focus:ring-[#003696]/15"
                />
              </div>
            </div>

            <div className="flex gap-3">
              <button 
                onClick={() => setShowEditModal(false)}
                className="flex-1 h-10 rounded-lg border border-[#E5E7EB] bg-white text-[13px] font-semibold text-slate-700 hover:bg-slate-50 transition"
              >
                Cancel
              </button>
              <button 
                className="flex-1 h-10 rounded-lg text-[13px] font-semibold text-white hover:opacity-90 transition"
                style={{ backgroundColor: NgoColors.navy }}
              >
                Update Alert
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
