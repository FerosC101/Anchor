import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { NgoColors } from "../../core/theme/ngo-colors";
import { NgoStatCardGrid } from "./NgoStatCard";
import { NgoSearchBar } from "./NgoSearchBar";
import { NgoFilterChips } from "./NgoFilterChips";
import { NgoIncidentCard } from "./NgoIncidentCard";
import { NgoEmployerCard } from "./NgoEmployerCard";
import { NgoDrawer } from "../layout/NgoDrawer";

export interface NgoLayoutReport {
  id: number;
  initials: string;
  workerName: string;
  country: string;
  employer: string;
  issue: string;
  reportId: string;
  status: "in-review" | "escalated" | "pending" | "resolved";
}

export interface NgoLayoutEmployer {
  id: number;
  initials: string;
  employer: string;
  type: string;
  country: string;
  riskLevel: "high" | "critical";
  reports: number;
}

interface NgoDashboardLayoutProps {
  reports: NgoLayoutReport[];
  employers: NgoLayoutEmployer[];
}

export function NgoDashboardLayout({ reports, employers }: NgoDashboardLayoutProps) {
  const navigate = useNavigate();
  const [search, setSearch] = useState("");
  const [country, setCountry] = useState("All Countries");
  const [issue, setIssue] = useState("All Issues");
  const [status, setStatus] = useState("All Status");
  const [drawerOpen, setDrawerOpen] = useState(false);

  const filteredReports = reports.filter((r) => {
    const query = search.trim().toLowerCase();
    const matchesSearch =
      query.length === 0 ||
      r.workerName.toLowerCase().includes(query) ||
      r.reportId.toLowerCase().includes(query);
    const matchesCountry = country === "All Countries" || r.country === country;
    const matchesIssue = issue === "All Issues" || r.issue === issue;
    const matchesStatus = status === "All Status" || 
      (status === "In Review" && r.status === "in-review") ||
      (status === "Escalated" && r.status === "escalated") ||
      (status === "Pending" && r.status === "pending") ||
      (status === "Resolved" && r.status === "resolved");

    return matchesSearch && matchesCountry && matchesIssue && matchesStatus;
  });

  return (
    <>
      <div style={{ backgroundColor: NgoColors.bg }} className="min-h-screen">
        {/* Header */}
        <header className="sticky top-0 z-20 border-b bg-white/95 backdrop-blur" style={{ borderColor: NgoColors.border }}>
          <div className="mx-auto flex h-14 w-full items-center justify-between px-4 sm:px-6 lg:px-8">
            <div className="flex items-center gap-3">
              <div className="h-6 w-6 rounded-full" style={{ backgroundColor: NgoColors.navy }} />
              <p className="text-lg font-bold" style={{ color: NgoColors.navy }}>
                Anchor
              </p>
            </div>

            <div className="flex items-center gap-3">
              <button
                className="rounded-lg p-2 transition hover:bg-slate-100"
                onClick={() => {}}
              >
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke={NgoColors.textSecondary} strokeWidth="2">
                  <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" />
                  <path d="M13.73 21a2 2 0 0 1-3.46 0" />
                </svg>
              </button>
              <button
                className="rounded-lg p-2 transition hover:bg-slate-100"
                onClick={() => setDrawerOpen(true)}
              >
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke={NgoColors.textSecondary} strokeWidth="2">
                  <path d="M4 6h16M4 12h16M4 18h16" />
                </svg>
              </button>
            </div>
          </div>
        </header>

        {/* Main Content */}
        <main className="mx-auto w-full max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
          {/* Title */}
          <h1 className="text-xl font-bold" style={{ color: NgoColors.textPrimary }}>
            Dashboard Overview
          </h1>

          {/* Stat Cards */}
          <div className="mt-6">
            <NgoStatCardGrid />
          </div>

          {/* Recent Incident Reports Section */}
          <div className="mt-8">
            <h2 className="text-base font-bold" style={{ color: NgoColors.textPrimary }}>
              Recent Incident Reports
            </h2>

            {/* Search and Filters */}
            <div className="mt-4 space-y-3">
              <NgoSearchBar value={search} onChange={setSearch} />
              <NgoFilterChips
                country={country}
                issue={issue}
                status={status}
                onCountryChange={setCountry}
                onIssueChange={setIssue}
                onStatusChange={setStatus}
              />
            </div>

            {/* Reports Grid */}
            <div className="mt-4">
              {filteredReports.length > 0 ? (
                <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-2">
                  {filteredReports.map((report) => (
                    <NgoIncidentCard
                      key={report.id}
                      workerName={report.workerName}
                      country={report.country}
                      employer={report.employer}
                      issue={report.issue}
                      reportId={report.reportId}
                      status={report.status}
                      onViewCase={() => {
                        console.log("View case:", report.id);
                      }}
                    />
                  ))}
                </div>
              ) : (
                <div
                  className="rounded-2xl border-2 border-dashed px-6 py-10 text-center"
                  style={{ borderColor: NgoColors.border }}
                >
                  <p style={{ color: NgoColors.textSecondary }}>
                    No reports found for the current filters.
                  </p>
                </div>
              )}
            </div>
          </div>

          {/* High Risk Employers Section */}
          <div className="mt-8 pb-8">
            <h2 className="text-base font-bold" style={{ color: NgoColors.textPrimary }}>
              High Risk Employers
            </h2>

            <div className="mt-4 space-y-3">
              {employers.map((employer) => (
                <NgoEmployerCard
                  key={employer.id}
                  employer={employer.employer}
                  type={employer.type}
                  country={employer.country}
                  riskLevel={employer.riskLevel}
                  reports={employer.reports}
                  onViewDetails={() => {
                    console.log("View employer:", employer.id);
                  }}
                />
              ))}
            </div>
          </div>
        </main>
      </div>

      {/* Drawer */}
      <NgoDrawer
        isOpen={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        onProfileClick={() => navigate("/profile")}
        onNotificationsClick={() => navigate("/notifications")}
        onPrivacyClick={() => navigate("/privacy")}
        onLogoutClick={() => {
          console.log("Logout");
        }}
      />
    </>
  );
}
