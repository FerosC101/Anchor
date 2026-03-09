import { useState } from "react";

// ── Icons ────────────────────────────────────────────────────────────────────

function BellIcon() {
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

function SearchIcon() {
  return (
    <svg
      width="18"
      height="18"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <circle cx="11" cy="11" r="8" />
      <path strokeLinecap="round" d="M21 21l-4.35-4.35" />
    </svg>
  );
}

function ContractIcon() {
  return (
    <svg
      width="28"
      height="28"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.7}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414A1 1 0 0119 9.414V19a2 2 0 01-2 2z"
      />
      <path strokeLinecap="round" strokeLinejoin="round" d="M13 3v6h6" />
    </svg>
  );
}

function WagesIcon() {
  return (
    <svg
      width="28"
      height="28"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.7}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M16 8v8m-4-5v5m-4-2v2m-2 4h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
      />
    </svg>
  );
}

function HomeNavIcon({ active }: { active?: boolean }) {
  return (
    <svg
      width="22"
      height="22"
      fill={active ? "currentColor" : "none"}
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={1.8}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M3 12l2-2m0 0l7-7 7 7m-9 2v6a1 1 0 001 1h4a1 1 0 001-1v-6m-6 0h6"
      />
    </svg>
  );
}

function WagesNavIcon() {
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
        d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
      />
    </svg>
  );
}

function ContractNavIcon() {
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
        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414A1 1 0 0119 9.414V19a2 2 0 01-2 2z"
      />
    </svg>
  );
}

function CommunityNavIcon() {
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
        d="M17 20h5v-2a4 4 0 00-5.197-3.8M9 20H4v-2a4 4 0 015.197-3.8M15 8a4 4 0 11-8 0 4 4 0 018 0zm6 4a3 3 0 11-6 0 3 3 0 016 0zM3 12a3 3 0 110-6 3 3 0 010 6z"
      />
    </svg>
  );
}

function ShieldNavIcon() {
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
        d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
      />
    </svg>
  );
}

function LocationIcon() {
  return (
    <svg
      width="13"
      height="13"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"
      />
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"
      />
    </svg>
  );
}

function UpvoteIcon() {
  return (
    <svg width="15" height="15" fill="currentColor" viewBox="0 0 24 24">
      <path d="M12 4l8 8H4l8-8z" />
    </svg>
  );
}

function CommentIcon() {
  return (
    <svg
      width="15"
      height="15"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={2}
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"
      />
    </svg>
  );
}

function DotsIcon() {
  return (
    <svg width="18" height="18" fill="currentColor" viewBox="0 0 24 24">
      <circle cx="5" cy="12" r="2" />
      <circle cx="12" cy="12" r="2" />
      <circle cx="19" cy="12" r="2" />
    </svg>
  );
}

// ── Data ─────────────────────────────────────────────────────────────────────

const communityPosts = [
  {
    id: 1,
    company: "BuildRite Construction",
    description:
      "Salary delayed for 2 months. Dormitory has no clean water supply...",
    tags: ["#Delayed Salary", "#Unsafe Dorm"],
    time: "17 hours ago",
    location: "Location",
    upvotes: 45,
    comments: 12,
  },
  {
    id: 2,
    company: "BuildRite Construction",
    description:
      "Salary delayed for 2 months. Dormitory has no clean water supply...",
    tags: ["#Delayed Salary", "#Unsafe Dorm"],
    time: "17 hours ago",
    location: "Location",
    upvotes: 45,
    comments: 12,
  },
];

// ── Subcomponents ─────────────────────────────────────────────────────────────

function CommunityPostCard({
  company,
  description,
  tags,
  time,
  location,
  upvotes,
  comments,
}: (typeof communityPosts)[0]) {
  return (
    <div className="bg-white rounded-2xl p-4 shadow-sm border border-slate-100">
      <div className="flex items-start justify-between mb-1">
        <span className="font-semibold text-slate-800 text-[15px]">
          {company}
        </span>
        <button className="text-slate-400 hover:text-slate-600 mt-0.5">
          <DotsIcon />
        </button>
      </div>
      <p className="text-slate-500 text-sm leading-snug mb-3">
        {description}
        <span className="text-indigo-600 font-medium"> read more</span>
      </p>
      <div className="flex flex-wrap gap-2 mb-3">
        {tags.map((tag) => (
          <span
            key={tag}
            className="text-xs bg-slate-100 text-slate-600 rounded-full px-3 py-1"
          >
            {tag}
          </span>
        ))}
      </div>
      <div className="flex items-center justify-between text-xs text-slate-400">
        <div className="flex items-center gap-3">
          <span>{time}</span>
          <span className="flex items-center gap-1">
            <LocationIcon />
            {location}
          </span>
        </div>
        <div className="flex items-center gap-3">
          <span className="flex items-center gap-1 text-indigo-500">
            <UpvoteIcon />
            {upvotes}
          </span>
          <span className="flex items-center gap-1 text-slate-400">
            <CommentIcon />
            {comments}
          </span>
        </div>
      </div>
    </div>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function HomePage() {
  const [activeNav, setActiveNav] = useState("home");

  const navItems = [
    {
      key: "home",
      label: "Home",
      icon: (a: boolean) => <HomeNavIcon active={a} />,
    },
    { key: "wages", label: "Wages", icon: () => <WagesNavIcon /> },
    { key: "contracts", label: "Contracts", icon: () => <ContractNavIcon /> },
    { key: "community", label: "Community", icon: () => <CommunityNavIcon /> },
    { key: "shield", label: "Shield", icon: () => <ShieldNavIcon /> },
  ];

  return (
    <div className="min-h-screen bg-slate-100 flex items-start justify-center">
      {/* Mobile frame */}
      <div className="w-full max-w-[390px] min-h-screen bg-[#F4F5F9] flex flex-col relative">
        {/* ── Top Bar ── */}
        <header className="flex items-center justify-between px-5 pt-12 pb-4 bg-[#F4F5F9]">
          <div className="flex items-center gap-2">
            <div className="w-9 h-9 rounded-full bg-indigo-700 flex items-center justify-center">
              <div className="w-3.5 h-3.5 rounded-full bg-white" />
            </div>
            <span className="text-[17px] font-bold text-slate-800">Anchor</span>
          </div>
          <div className="flex items-center gap-4 text-slate-500">
            <button className="hover:text-slate-700 transition-colors">
              <BellIcon />
            </button>
            <button className="hover:text-slate-700 transition-colors">
              <MenuIcon />
            </button>
          </div>
        </header>

        {/* ── Scrollable Content ── */}
        <div className="flex-1 overflow-y-auto px-5 pb-28 space-y-4">
          {/* Search */}
          <div className="flex items-center gap-3 bg-white rounded-2xl px-4 py-3 shadow-sm">
            <span className="text-slate-400">
              <SearchIcon />
            </span>
            <input
              type="text"
              placeholder="Search"
              className="flex-1 bg-transparent text-sm text-slate-600 placeholder:text-slate-400 outline-none"
            />
          </div>

          {/* Safety Status Card */}
          <div
            className="rounded-2xl p-5"
            style={{
              background: "linear-gradient(145deg, #ddd8f8 0%, #bfb8ee 100%)",
            }}
          >
            <p className="text-[10px] font-semibold tracking-widest text-indigo-800/70 uppercase mb-1">
              Current Safety Status
            </p>
            <p className="text-4xl font-bold text-indigo-800 mb-4">Good</p>
            <div className="space-y-2">
              <div className="bg-white/60 backdrop-blur-sm rounded-xl px-4 py-2.5 text-sm font-medium text-indigo-700">
                Contract Verified (92% match)
              </div>
              <div className="bg-white/60 backdrop-blur-sm rounded-xl px-4 py-2.5 text-sm font-medium text-indigo-700">
                Wages trending normal
              </div>
            </div>
          </div>

          {/* Quick Actions */}
          <div className="grid grid-cols-2 gap-3">
            <button className="bg-white rounded-2xl p-4 shadow-sm border border-slate-100 flex flex-col items-center gap-2 hover:shadow-md transition-shadow">
              <div className="w-11 h-11 bg-indigo-50 rounded-xl flex items-center justify-center text-indigo-600">
                <ContractIcon />
              </div>
              <div className="text-center">
                <p className="text-sm font-semibold text-slate-800">
                  Check Contract
                </p>
                <p className="text-xs text-slate-400 mt-0.5 leading-tight">
                  Scan for hidden clauses
                </p>
              </div>
            </button>
            <button className="bg-white rounded-2xl p-4 shadow-sm border border-slate-100 flex flex-col items-center gap-2 hover:shadow-md transition-shadow">
              <div className="w-11 h-11 bg-indigo-50 rounded-xl flex items-center justify-center text-indigo-600">
                <WagesIcon />
              </div>
              <div className="text-center">
                <p className="text-sm font-semibold text-slate-800">
                  Log Wages
                </p>
                <p className="text-xs text-slate-400 mt-0.5 leading-tight">
                  Track earnings &amp; deductions
                </p>
              </div>
            </button>
          </div>

          {/* Financial Health */}
          <div className="bg-white rounded-2xl p-4 shadow-sm border border-slate-100">
            <div className="flex items-center justify-between mb-3">
              <span className="font-semibold text-slate-800 text-[15px]">
                Financial Health
              </span>
              <span className="text-xs text-slate-400">
                Last updated: Today
              </span>
            </div>
            <div className="mb-2">
              <div className="flex items-center justify-between mb-1.5">
                <span className="text-sm text-slate-500">
                  Savings Goal (Return Home)
                </span>
                <span className="text-sm font-semibold text-indigo-600">
                  45%
                </span>
              </div>
              <div className="w-full h-2 bg-slate-100 rounded-full overflow-hidden">
                <div
                  className="h-full bg-indigo-500 rounded-full transition-all"
                  style={{ width: "45%" }}
                />
              </div>
            </div>
            <div className="flex items-center justify-between mt-4">
              <div>
                <p className="text-xs text-slate-400 mb-0.5">
                  Next expected salary
                </p>
                <p className="text-base font-bold text-slate-800">$2,400 SGD</p>
              </div>
              <button className="text-sm font-medium text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-xl px-4 py-2 transition-colors">
                View Analysis
              </button>
            </div>
          </div>

          {/* Community Posts */}
          <div>
            <div className="flex items-center justify-between mb-3">
              <span className="font-bold text-slate-800 text-base">
                Community Posts
              </span>
              <button className="text-sm text-slate-400 hover:text-indigo-600 flex items-center gap-1 transition-colors">
                View more
                <svg
                  width="14"
                  height="14"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  strokeWidth={2.5}
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M9 5l7 7-7 7"
                  />
                </svg>
              </button>
            </div>
            <div className="space-y-3">
              {communityPosts.map((post) => (
                <CommunityPostCard key={post.id} {...post} />
              ))}
            </div>
          </div>
        </div>

        {/* ── Bottom Navigation ── */}
        <nav className="fixed bottom-0 left-1/2 -translate-x-1/2 w-full max-w-[390px] bg-white border-t border-slate-200 flex items-center justify-around px-2 py-2 pb-6 z-10">
          {navItems.map(({ key, label, icon }) => {
            const isActive = activeNav === key;
            return (
              <button
                key={key}
                onClick={() => setActiveNav(key)}
                className={`flex flex-col items-center gap-1 px-3 py-1 rounded-xl transition-colors ${
                  isActive
                    ? "text-indigo-600"
                    : "text-slate-400 hover:text-slate-600"
                }`}
              >
                {icon(isActive)}
                <span
                  className={`text-[10px] font-medium ${isActive ? "text-indigo-600" : ""}`}
                >
                  {label}
                </span>
              </button>
            );
          })}
        </nav>
      </div>
    </div>
  );
}
