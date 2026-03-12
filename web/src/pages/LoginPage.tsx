import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
import { ROUTES } from "../core/config/routes";
import { USER_ROLE } from "../types/user";

const GRADIENT: React.CSSProperties = {
  background: "linear-gradient(135deg, #0A2463 0%, #1E3A8A 100%)",
};

const FEATURES = [
  { icon: "🛡️", text: "AI-powered contract analysis" },
  { icon: "⚡", text: "Real-time safety alerts" },
  { icon: "💸", text: "Wage protection & tracking" },
  { icon: "🌐", text: "Government-linked support" },
];

function AnchorIcon({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" fill="currentColor" className={className}>
      <path d="M17 14.5A5.5 5.5 0 0 1 7.072 16H9a1 1 0 0 0 0-2H5a1 1 0 0 0-1 1v4a1 1 0 0 0 2 0v-1.43A7.5 7.5 0 0 0 19.5 14.5a1 1 0 0 0-2 0zM12 2a3 3 0 0 0-1 5.83V10H9a1 1 0 0 0 0 2h2v.17A3.001 3.001 0 0 0 12 18a3 3 0 0 0 1-5.83V12h2a1 1 0 0 0 0-2h-2V7.83A3 3 0 0 0 12 2zm0 2a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm0 12a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
    </svg>
  );
}

function EyeIcon({ className }: { className?: string }) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth={2}
      className={className}
    >
      <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
      <circle cx="12" cy="12" r="3" />
    </svg>
  );
}

function EyeOffIcon({ className }: { className?: string }) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth={2}
      className={className}
    >
      <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" />
      <line x1="1" y1="1" x2="23" y2="23" />
    </svg>
  );
}

export default function LoginPage() {
  const navigate = useNavigate();
  const { signIn, error, clearError, isLoading } = useAuth();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPw, setShowPw] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    clearError();
    const loggedInUser = await signIn(email.trim(), password);
    if (loggedInUser) {
      const dest =
        loggedInUser.role === USER_ROLE.ADMIN ? ROUTES.ADMIN : ROUTES.HOME;
      navigate(dest, { replace: true });
    }
  }

  return (
    <div className="min-h-screen flex flex-col lg:flex-row bg-[#F8FAFC]">
      {/* LEFT — branding panel, desktop only */}
      <aside
        className="hidden lg:flex lg:w-5/12 xl:w-1/2 flex-col justify-between p-12 relative overflow-hidden shrink-0"
        style={GRADIENT}
      >
        <div className="absolute -top-24 -left-24 w-80 h-80 rounded-full bg-white/5 pointer-events-none" />
        <div className="absolute -bottom-28 -right-20 w-96 h-96 rounded-full bg-white/5 pointer-events-none" />
        <div className="absolute top-1/3 -right-12 w-52 h-52 rounded-full bg-white/5 pointer-events-none" />

        {/* Logo */}
        <div className="relative z-10">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 rounded-full bg-white/15 border-2 border-white/30 flex items-center justify-center shrink-0">
              <AnchorIcon className="w-7 h-7 text-white" />
            </div>
            <span className="text-white text-2xl font-extrabold tracking-[0.2em]">
              ANCHOR
            </span>
          </div>
          <p className="text-white/55 text-sm mt-1 pl-[60px]">
            Protecting Filipino Workers Abroad
          </p>
        </div>

        {/* Hero */}
        <div className="relative z-10 space-y-6">
          <h2 className="text-white text-4xl xl:text-5xl font-bold leading-tight">
            Your safety, <span style={{ color: "#F4A261" }}>our mission.</span>
          </h2>
          <p className="text-white/70 text-base max-w-sm leading-relaxed">
            Anchor gives every OFW the legal protection, real-time alerts, and
            government support they deserve — wherever they are in the world.
          </p>
          <ul className="space-y-3 pt-1">
            {FEATURES.map((f) => (
              <li key={f.text} className="flex items-center gap-3">
                <span className="text-lg leading-none">{f.icon}</span>
                <span className="text-white/80 text-sm">{f.text}</span>
              </li>
            ))}
          </ul>
        </div>

        <p className="relative z-10 text-white/30 text-xs">
          &copy; {new Date().getFullYear()} Anchor &middot; For OFWs, by OFWs
        </p>
      </aside>

      {/* RIGHT — form panel */}
      <div className="flex-1 flex flex-col">
        {/* Mobile header */}
        <header
          className="lg:hidden flex flex-col items-center gap-2 px-6 pt-12 pb-16"
          style={GRADIENT}
        >
          <div className="w-16 h-16 rounded-full bg-white/15 border-2 border-white/30 flex items-center justify-center">
            <AnchorIcon className="w-9 h-9 text-white" />
          </div>
          <p className="text-white text-2xl font-extrabold tracking-[0.2em]">
            ANCHOR
          </p>
          <p className="text-white/60 text-xs">
            Protecting Filipino Workers Abroad
          </p>
        </header>

        {/* Card */}
        <div className="flex-1 flex items-start lg:items-center justify-center px-4 sm:px-8 lg:px-14 xl:px-20 -mt-6 lg:mt-0 pb-12">
          <div className="w-full max-w-md">
            <div className="bg-white rounded-3xl shadow-xl shadow-slate-200/60 p-8 sm:p-10">
              <h1 className="text-[22px] font-bold text-[#0F172A]">
                Welcome back!
              </h1>
              <p className="mt-1 text-[#64748B] text-sm">
                Sign in to your Anchor account
              </p>

              <form
                onSubmit={handleSubmit}
                className="mt-7 space-y-5"
                noValidate
              >
                {error && (
                  <div
                    role="alert"
                    className="rounded-xl bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 flex gap-2"
                  >
                    <span className="shrink-0">⚠️</span>
                    <span>{error}</span>
                  </div>
                )}

                {/* Email */}
                <div>
                  <label
                    htmlFor="email"
                    className="block text-sm font-medium text-[#0F172A] mb-1.5"
                  >
                    Email Address
                  </label>
                  <div className="relative">
                    <svg
                      className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#94A3B8] pointer-events-none"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                      <polyline points="22,6 12,13 2,6" />
                    </svg>
                    <input
                      id="email"
                      type="email"
                      autoComplete="email"
                      required
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      placeholder="you@example.com"
                      className="w-full rounded-xl border border-[#E2E8F0] pl-10 pr-4 py-3 text-sm text-[#0F172A] placeholder-[#94A3B8] focus:border-[#0A2463] focus:outline-none focus:ring-2 focus:ring-[#0A2463]/20 transition"
                    />
                  </div>
                </div>

                {/* Password */}
                <div>
                  <div className="flex items-center justify-between mb-1.5">
                    <label
                      htmlFor="password"
                      className="text-sm font-medium text-[#0F172A]"
                    >
                      Password
                    </label>
                    <button
                      type="button"
                      className="text-xs font-medium text-[#0A2463] hover:text-[#1E3A8A] transition"
                    >
                      Forgot Password?
                    </button>
                  </div>
                  <div className="relative">
                    <svg
                      className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#94A3B8] pointer-events-none"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                    <input
                      id="password"
                      type={showPw ? "text" : "password"}
                      autoComplete="current-password"
                      required
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      placeholder="••••••••"
                      className="w-full rounded-xl border border-[#E2E8F0] pl-10 pr-12 py-3 text-sm text-[#0F172A] placeholder-[#94A3B8] focus:border-[#0A2463] focus:outline-none focus:ring-2 focus:ring-[#0A2463]/20 transition"
                    />
                    <button
                      type="button"
                      aria-label={showPw ? "Hide password" : "Show password"}
                      onClick={() => setShowPw((v) => !v)}
                      className="absolute right-3.5 top-1/2 -translate-y-1/2 text-[#94A3B8] hover:text-[#64748B] transition"
                    >
                      {showPw ? (
                        <EyeOffIcon className="w-4 h-4" />
                      ) : (
                        <EyeIcon className="w-4 h-4" />
                      )}
                    </button>
                  </div>
                </div>

                {/* Submit */}
                <button
                  type="submit"
                  disabled={isLoading}
                  style={GRADIENT}
                  className="w-full mt-2 rounded-xl py-3.5 text-white text-sm font-semibold shadow-lg shadow-[#0A2463]/25 hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#0A2463] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all"
                >
                  {isLoading ? (
                    <span className="flex items-center justify-center gap-2">
                      <svg
                        className="animate-spin h-4 w-4"
                        fill="none"
                        viewBox="0 0 24 24"
                      >
                        <circle
                          className="opacity-25"
                          cx="12"
                          cy="12"
                          r="10"
                          stroke="currentColor"
                          strokeWidth="4"
                        />
                        <path
                          className="opacity-75"
                          fill="currentColor"
                          d="M4 12a8 8 0 018-8v8z"
                        />
                      </svg>
                      Signing in…
                    </span>
                  ) : (
                    "Sign In"
                  )}
                </button>
              </form>

              <p className="mt-6 text-center text-sm text-[#64748B]">
                Don&apos;t have an account?{" "}
                <Link
                  to={ROUTES.REGISTER}
                  className="font-semibold text-[#0A2463] hover:text-[#1E3A8A] transition"
                >
                  Create one
                </Link>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
