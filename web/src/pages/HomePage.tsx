import { useMemo } from "react";
import { useNavigate } from "react-router-dom";
import { WorkerLayout } from "../components/layout/WorkerLayout";
import { ROUTES } from "../core/config/routes";
import { useAuth } from "../core/context/AuthContext";

function StatIcon({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white/70 text-[#003696]">
      {children}
    </div>
  );
}

function ActionIcon({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-blue-50 text-[#003696]">
      {children}
    </div>
  );
}

function ShieldIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path d="M12 3l7 4v5c0 5-3.5 9-7 10-3.5-1-7-5-7-10V7l7-4z" />
      <path d="M9 12l2 2 4-4" />
    </svg>
  );
}

function ChartIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path d="M4 19h16" />
      <path d="M8 16v-6" />
      <path d="M12 16v-9" />
      <path d="M16 16v-4" />
    </svg>
  );
}

function ContractIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path d="M9 12h6m-6 4h6m2 5H7a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5.586a1 1 0 0 1 .707.293l5.414 5.414A1 1 0 0 1 19 9.414V19a2 2 0 0 1-2 2z" />
    </svg>
  );
}

function CommunityIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path d="M17 20h5v-2a4 4 0 0 0-5.197-3.8M9 20H4v-2a4 4 0 0 1 5.197-3.8M15 8a4 4 0 1 1-8 0 4 4 0 0 1 8 0zm6 4a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
    </svg>
  );
}

const COMMUNITY_POSTS = [
  {
    id: "1",
    company: "BuildRite Construction",
    location: "Riyadh, Saudi Arabia",
    description:
      "Employer delayed wages for 2 months and withheld passports. Reported to embassy; investigation ongoing.",
    tags: ["Wage Theft", "Document Confiscation"],
    upvotes: 48,
    comments: 12,
    time: "2 hours ago",
  },
  {
    id: "2",
    company: "BrightStar Domestic Services",
    location: "Dubai, UAE",
    description:
      "Workers report excessive overtime without pay. Agency asked for contract review.",
    tags: ["Unpaid Overtime"],
    upvotes: 31,
    comments: 7,
    time: "Yesterday",
  },
  {
    id: "3",
    company: "MegaConstruct Ltd",
    location: "Singapore",
    description:
      "Safety violations at site; workers lack protective gear. Multiple incidents this week.",
    tags: ["Unsafe Conditions"],
    upvotes: 58,
    comments: 19,
    time: "2 days ago",
  },
];

export default function HomePage() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const firstName = useMemo(() => user?.fullName?.split(" ")[0] ?? "Worker", [user]);

  return (
    <WorkerLayout>
      <main className="mx-auto w-full max-w-6xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="flex flex-col gap-6">
          <section className="flex flex-col gap-3">
            <p className="text-[12px] font-semibold uppercase tracking-[0.2em] text-slate-400">Overview</p>
            <h1 className="text-[26px] font-extrabold text-slate-900">Welcome back, {firstName}!</h1>
            <p className="text-[14px] text-slate-600">
              Stay protected with real-time alerts, contract checks, and wage tracking.
            </p>
          </section>

          <section className="grid gap-6 lg:grid-cols-[1.2fr_0.8fr]">
            <div className="rounded-3xl border border-white/60 bg-gradient-to-br from-[#DFEDFF] to-white p-6 shadow-sm">
              <div className="flex items-start justify-between">
                <div>
                  <p className="text-[11px] font-semibold uppercase tracking-[0.2em] text-[#5B4FCF]">
                    Current Safety Status
                  </p>
                  <p className="mt-2 text-[32px] font-extrabold text-[#003696]">Good</p>
                </div>
                <StatIcon>
                  <ShieldIcon />
                </StatIcon>
              </div>
              <div className="mt-5 flex flex-wrap gap-3">
                <span className="rounded-full bg-white/70 px-4 py-2 text-[12px] font-semibold text-[#003696]">
                  Contract Verified (92% match)
                </span>
                <span className="rounded-full bg-white/70 px-4 py-2 text-[12px] font-semibold text-[#003696]">
                  Wages trending normal
                </span>
              </div>
            </div>

            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <p className="text-[14px] font-semibold text-slate-700">Financial Health</p>
              <div className="mt-5 grid grid-cols-2 gap-4">
                <div className="rounded-2xl bg-blue-50 px-4 py-3">
                  <p className="text-[11px] font-semibold uppercase tracking-wide text-slate-500">Savings</p>
                  <p className="mt-2 text-[18px] font-bold text-slate-900">$2,450</p>
                </div>
                <div className="rounded-2xl bg-blue-50 px-4 py-3">
                  <p className="text-[11px] font-semibold uppercase tracking-wide text-slate-500">Debt</p>
                  <p className="mt-2 text-[18px] font-bold text-slate-900">$980</p>
                </div>
                <div className="rounded-2xl bg-blue-50 px-4 py-3">
                  <p className="text-[11px] font-semibold uppercase tracking-wide text-slate-500">Remittance</p>
                  <p className="mt-2 text-[18px] font-bold text-slate-900">$420/mo</p>
                </div>
                <div className="rounded-2xl bg-blue-50 px-4 py-3">
                  <p className="text-[11px] font-semibold uppercase tracking-wide text-slate-500">Exit Plan</p>
                  <p className="mt-2 text-[18px] font-bold text-slate-900">63% ready</p>
                </div>
              </div>
              <button
                className="mt-6 w-full rounded-full border border-[#003696] px-4 py-2.5 text-[13px] font-semibold text-[#003696] hover:bg-blue-50"
                onClick={() => navigate(ROUTES.SHIELD)}
              >
                View Financial Shield
              </button>
            </div>
          </section>

          <section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-[14px] font-semibold text-slate-900">Quick Actions</p>
                <p className="text-[12px] text-slate-500">Jump to your most used tools</p>
              </div>
              <span className="text-[12px] text-slate-400">Updated today</span>
            </div>
            <div className="mt-5 grid gap-4 md:grid-cols-4">
              <button
                className="flex flex-col items-center gap-3 rounded-2xl border border-slate-100 bg-white px-4 py-4 text-center shadow-sm transition hover:shadow-md"
                onClick={() => navigate(ROUTES.CONTRACTS)}
              >
                <ActionIcon>
                  <ContractIcon />
                </ActionIcon>
                <div>
                  <p className="text-[13px] font-semibold text-slate-900">Check Contract</p>
                  <p className="text-[11px] text-slate-500">Scan for hidden clauses</p>
                </div>
              </button>
              <button
                className="flex flex-col items-center gap-3 rounded-2xl border border-slate-100 bg-white px-4 py-4 text-center shadow-sm transition hover:shadow-md"
                onClick={() => navigate(ROUTES.WAGES)}
              >
                <ActionIcon>
                  <ChartIcon />
                </ActionIcon>
                <div>
                  <p className="text-[13px] font-semibold text-slate-900">Log Wages</p>
                  <p className="text-[11px] text-slate-500">Track earnings & deductions</p>
                </div>
              </button>
              <button
                className="flex flex-col items-center gap-3 rounded-2xl border border-slate-100 bg-white px-4 py-4 text-center shadow-sm transition hover:shadow-md"
                onClick={() => navigate(ROUTES.COMMUNITY)}
              >
                <ActionIcon>
                  <CommunityIcon />
                </ActionIcon>
                <div>
                  <p className="text-[13px] font-semibold text-slate-900">Community</p>
                  <p className="text-[11px] text-slate-500">Share safety reports</p>
                </div>
              </button>
              <button
                className="flex flex-col items-center gap-3 rounded-2xl border border-slate-100 bg-white px-4 py-4 text-center shadow-sm transition hover:shadow-md"
                onClick={() => navigate(ROUTES.SHIELD)}
              >
                <ActionIcon>
                  <ShieldIcon />
                </ActionIcon>
                <div>
                  <p className="text-[13px] font-semibold text-slate-900">Financial Shield</p>
                  <p className="text-[11px] text-slate-500">Plan your safety net</p>
                </div>
              </button>
            </div>
          </section>

          <section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-[14px] font-semibold text-slate-900">Community Safety Updates</p>
                <p className="text-[12px] text-slate-500">Latest reports from fellow workers</p>
              </div>
              <button
                onClick={() => navigate(ROUTES.COMMUNITY)}
                className="rounded-full border border-slate-200 px-4 py-1.5 text-[12px] font-semibold text-slate-600 hover:bg-slate-50"
              >
                View all
              </button>
            </div>

            <div className="mt-5 grid gap-4 lg:grid-cols-3">
              {COMMUNITY_POSTS.map((post) => (
                <div key={post.id} className="rounded-2xl border border-slate-100 bg-slate-50/70 p-4">
                  <p className="text-[12px] font-semibold text-slate-500">{post.location}</p>
                  <p className="mt-1 text-[15px] font-semibold text-slate-900">{post.company}</p>
                  <p className="mt-3 text-[12px] text-slate-600">{post.description}</p>
                  <div className="mt-3 flex flex-wrap gap-2">
                    {post.tags.map((tag) => (
                      <span key={tag} className="rounded-full bg-white px-3 py-1 text-[11px] font-semibold text-slate-600">
                        {tag}
                      </span>
                    ))}
                  </div>
                  <div className="mt-4 flex items-center justify-between text-[11px] text-slate-500">
                    <span>{post.time}</span>
                    <span>
                      {post.upvotes} upvotes · {post.comments} comments
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </section>

          <section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
            <div className="flex items-start justify-between gap-6">
              <div>
                <p className="text-[14px] font-semibold text-slate-900">Need help right now?</p>
                <p className="mt-1 text-[12px] text-slate-500">
                  Access emergency contacts and safety resources tailored for OFWs.
                </p>
              </div>
              <button
                className="rounded-full border border-[#003696] px-4 py-2 text-[12px] font-semibold text-[#003696] hover:bg-blue-50"
                onClick={() => navigate(ROUTES.SAFETY_RESOURCES)}
              >
                Safety Resources
              </button>
            </div>
          </section>
        </div>
      </main>
    </WorkerLayout>
  );
}
