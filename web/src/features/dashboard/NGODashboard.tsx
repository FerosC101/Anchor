import { useMemo, useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { ROUTES } from "../../core/config/routes";
import { useNotifications } from "../../core/context/NotificationContext";
import { useAuth } from "../../core/context/AuthContext";
import OperationalDashboard, {
  type DashboardBadgeTone,
  type DashboardPrimaryCard,
  type DashboardSecondaryRow,
  type DashboardSummaryCard,
} from "../../components/layout/OperationalDashboard";

type ReportStatus = "In Review" | "Pending" | "Verified" | "Resolved";

interface ReportItem {
  id: number;
  initials: string;
  workerName: string;
  country: string;
  employer: string;
  issue: string;
  reportId: string;
  status: ReportStatus;
}

interface EmployerItem {
  id: number;
  initials: string;
  employer: string;
  category: string;
  location: string;
  riskLevel: "High" | "Critical";
  reports: number;
}

const REPORTS: ReportItem[] = [
  {
    id: 1,
    initials: "MS",
    workerName: "Maria Santos",
    country: "Saudi Arabia",
    employer: "Al-Rashid Household Services",
    issue: "Wage Theft",
    reportId: "RPT-001",
    status: "In Review",
  },
  {
    id: 2,
    initials: "JR",
    workerName: "John Reyes",
    country: "Singapore",
    employer: "BuildRight Construction Pte. Ltd",
    issue: "Contract Substitution",
    reportId: "RPT-002",
    status: "Pending",
  },
  {
    id: 3,
    initials: "AD",
    workerName: "Anna Dela Cruz",
    country: "Hong Kong",
    employer: "Chen Family Residence",
    issue: "Physical Abuse",
    reportId: "RPT-003",
    status: "Verified",
  },
  {
    id: 4,
    initials: "RC",
    workerName: "Roberto Cruz",
    country: "UAE",
    employer: "Dubai Hospitality Group",
    issue: "Document Confiscation",
    reportId: "RPT-004",
    status: "In Review",
  },
  {
    id: 5,
    initials: "LT",
    workerName: "Lisa Tan",
    country: "Kuwait",
    employer: "Al-Sabah Trading Company",
    issue: "Unpaid Overtime",
    reportId: "RPT-005",
    status: "Pending",
  },
  {
    id: 6,
    initials: "CM",
    workerName: "Carlos Martinez",
    country: "Saudi Arabia",
    employer: "Al-Rashid Household Services",
    issue: "Poor Living Conditions",
    reportId: "RPT-006",
    status: "Resolved",
  },
];

const EMPLOYERS: EmployerItem[] = [
  {
    id: 1,
    initials: "AH",
    employer: "Al-Rashid Household Services",
    category: "Domestic Work",
    location: "Saudi Arabia",
    riskLevel: "High",
    reports: 12,
  },
  {
    id: 2,
    initials: "DH",
    employer: "Dubai Hospitality Group",
    category: "Hotel Staff",
    location: "UAE",
    riskLevel: "High",
    reports: 8,
  },
  {
    id: 3,
    initials: "ME",
    employer: "MegaConstruct Engineering",
    category: "Construction Worker",
    location: "Singapore",
    riskLevel: "High",
    reports: 15,
  },
  {
    id: 4,
    initials: "CF",
    employer: "Chen Family Residence",
    category: "Domestic Worker",
    location: "Hong Kong",
    riskLevel: "Critical",
    reports: 1,
  },
];

const mapStatusToNgoStatus = (status: ReportStatus): DashboardBadgeTone => {
  switch (status) {
    case "In Review":
      return "sky";
    case "Pending":
      return "amber";
    case "Verified":
      return "emerald";
    case "Resolved":
      return "slate";
    default:
      return "sky";
  }
};

const SUMMARY_CARDS: DashboardSummaryCard[] = [
  {
    value: "8",
    label: "Total Reports",
    sub: "vs last month",
    trend: "+ 12%",
    icon: "alert",
  },
  {
    value: "5",
    label: "Active Cases",
    sub: "vs last month",
    trend: "+ 8%",
    icon: "trend",
  },
  {
    value: "4",
    label: "High Risk Employers",
    sub: "new this week",
    trend: "+ 3",
    icon: "people",
  },
  {
    value: "10",
    label: "Countries Monitored",
    sub: "no change",
    trend: "Stable",
    icon: "pin",
  },
];

const COUNTRY_OPTIONS = [
  "All Countries",
  "Saudi Arabia",
  "Singapore",
  "Hong Kong",
  "UAE",
  "Kuwait",
];

const ISSUE_OPTIONS = [
  "All Issues",
  "Wage Theft",
  "Contract Substitution",
  "Physical Abuse",
  "Document Confiscation",
  "Unpaid Overtime",
  "Poor Living Conditions",
];

const STATUS_OPTIONS = [
  "All Status",
  "In Review",
  "Pending",
  "Verified",
  "Resolved",
];

export default function NGODashboard() {
  const navigate = useNavigate();
  const location = useLocation();
  const { unreadCount } = useNotifications();
  const { signOut } = useAuth();
  const [search, setSearch] = useState("");
  const [country, setCountry] = useState(COUNTRY_OPTIONS[0]);
  const [issue, setIssue] = useState(ISSUE_OPTIONS[0]);
  const [status, setStatus] = useState(STATUS_OPTIONS[0]);
  const [drawerOpen, setDrawerOpen] = useState(false);

  const handleLogout = async () => {
    await signOut();
    navigate(ROUTES.LOGIN);
  };

  const handlePrivacy = () => {
    navigate(ROUTES.PRIVACY);
  };

  const primaryCards: DashboardPrimaryCard[] = useMemo(
    () =>
      REPORTS.filter((item) => {
        const query = search.trim().toLowerCase();
        const matchesSearch =
          query.length === 0 ||
          item.workerName.toLowerCase().includes(query) ||
          item.reportId.toLowerCase().includes(query);
        const matchesCountry =
          country === COUNTRY_OPTIONS[0] || item.country === country;
        const matchesIssue = issue === ISSUE_OPTIONS[0] || item.issue === issue;
        const matchesStatus =
          status === STATUS_OPTIONS[0] || item.status === status;

        return matchesSearch && matchesCountry && matchesIssue && matchesStatus;
      }).map((item) => ({
        id: item.id,
        initials: item.initials,
        title: item.workerName,
        subtitle: item.country,
        badgeLabel: item.status,
        badgeTone: mapStatusToNgoStatus(item.status),
        fields: [
          { label: "Employer", value: item.employer },
          { label: "Issue", value: item.issue },
          { label: "Report ID", value: item.reportId, accent: true },
        ],
        actionLabel: "View Case",
      })),
    [country, issue, search, status],
  );

  const secondaryRows: DashboardSecondaryRow[] = useMemo(
    () =>
      EMPLOYERS.map((item) => ({
        id: item.id,
        initials: item.initials,
        title: item.employer,
        subtitle: item.category,
        secondaryText: item.location,
        secondaryIcon: "pin",
        badgeLabel: item.riskLevel,
        badgeTone: item.riskLevel === "Critical" ? "rose" : "orange",
        metric: String(item.reports),
      })),
    [],
  );

  return (
    <OperationalDashboard
      pageTitle="Dashboard Overview"
      navItems={[
        { label: "Home", active: location.pathname === ROUTES.DASHBOARD, onClick: () => navigate(ROUTES.DASHBOARD) },
        { label: "Monitoring", active: location.pathname === ROUTES.MONITORING, onClick: () => navigate(ROUTES.MONITORING) },
        { label: "Alert", active: location.pathname === ROUTES.ALERT, onClick: () => navigate(ROUTES.ALERT) },
      ]}
      summaryCards={SUMMARY_CARDS}
      searchPlaceholder="Search worker by name or case ID"
      searchValue={search}
      onSearchChange={setSearch}
      filters={[
        {
          value: country,
          onChange: setCountry,
          options: COUNTRY_OPTIONS,
        },
        {
          value: issue,
          onChange: setIssue,
          options: ISSUE_OPTIONS,
        },
        {
          value: status,
          onChange: setStatus,
          options: STATUS_OPTIONS,
        },
      ]}
      primarySection={{
        title: "Recent Incident Reports",
        buttonLabel: "View All Reports",
        hideButton: true,
      }}
      primaryCards={primaryCards}
      primaryEmptyMessage="No reports found for the current filters."
      secondarySection={{
        title: "High Risk Employers",
        buttonLabel: "View All Reports",
        hideButton: true,
        columns: ["Employer", "Location", "Risk Level", "Reports"],
      }}
      secondaryRows={secondaryRows}
      unreadNotificationCount={unreadCount}
      showDrawer={drawerOpen}
      onDrawerOpen={() => setDrawerOpen(true)}
      onDrawerClose={() => setDrawerOpen(false)}
      onProfileClick={() => navigate(ROUTES.PROFILE)}
      onNotificationsClick={() => navigate(ROUTES.NOTIFICATIONS)}
      onPrivacyClick={handlePrivacy}
      onLogoutClick={handleLogout}
    />
  );
}