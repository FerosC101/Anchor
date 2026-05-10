import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
import { ROUTES, getDefaultRouteForRole } from "../core/config/routes";

const GRADIENT: React.CSSProperties = {
  background: "linear-gradient(135deg, #DFEDFF 0%, #003696 100%)",
};

const INFO_ITEMS = [
  "AI-powered contract analysis",
  "Real-time safety alerts",
  "Wage protection & tracking",
  "Government-linked support",
];

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

  function handleRegisterClick() {
    navigate(ROUTES.REGISTER);
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    clearError();
    const loggedInUser = await signIn(email.trim(), password);
    if (loggedInUser) {
      navigate(getDefaultRouteForRole(loggedInUser.role), { replace: true });
    }
  }

  return (
    <div className="min-h-screen bg-[#F4F4F8] lg:flex">
      <aside
        className="hidden lg:flex lg:w-1/2 flex-col justify-between px-12 py-14 text-white"
        style={GRADIENT}
      >
        <div>
          <p className="text-[26px] font-extrabold tracking-[0.3em] text-[#003696]">
            ANCHOR
          </p>
          <p className="mt-2 text-sm text-white/85">
            Protecting Filipino Workers Abroad
          </p>
        </div>

        <div className="mt-10 space-y-6">
          <h2 className="text-4xl font-bold leading-tight">
            Your safety, our mission.
          </h2>
          <p className="text-white/85 text-sm max-w-md">
            Anchor gives every OFW the legal protection, real-time alerts, and
            government support they deserve — wherever they are in the world.
          </p>
          <ul className="space-y-3 text-sm text-white/85">
            {INFO_ITEMS.map((item) => (
              <li key={item} className="flex items-start gap-3">
                <span className="mt-2 h-2 w-2 rounded-full bg-white" />
                <span>{item}</span>
              </li>
            ))}
          </ul>
        </div>

        <p className="text-white/50 text-xs">
          &copy; {new Date().getFullYear()} Anchor · For OFWs, by OFWs
        </p>
      </aside>

      <div className="flex-1 lg:flex lg:items-center lg:justify-center">
        <div className="relative w-full">
          <div className="h-[280px] rounded-b-[32px] lg:hidden" style={GRADIENT}>
            <div className="mx-auto w-full max-w-xl px-6 pt-10 text-center">
              <p className="text-[26px] font-extrabold tracking-[0.3em] text-[#003696]">
                ANCHOR
              </p>
              <p className="mt-2 text-[13px] text-white/80">
                Protecting Filipino Workers Abroad
              </p>
            </div>
          </div>

          <div className="-mt-12 px-4 pb-10 lg:mt-0 lg:flex lg:min-h-screen lg:w-full lg:items-center lg:justify-center lg:px-12 lg:py-0">
            <div className="mx-auto flex w-full max-w-md flex-col items-center">
              <div className="w-full rounded-3xl bg-white p-8 shadow-[0_12px_32px_rgba(15,23,42,0.12)]">
              <h1 className="text-[22px] font-bold text-[#0F172A]">Welcome back!</h1>
              <p className="mt-1 text-[#64748B] text-sm">Sign in to your account to continue</p>

              <form onSubmit={handleSubmit} className="mt-7 space-y-5" noValidate>
                {error && (
                  <div
                    role="alert"
                    className="rounded-xl bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 flex gap-2"
                  >
                    <span className="shrink-0">⚠️</span>
                    <span>{error}</span>
                  </div>
                )}

                <div>
                  <label htmlFor="email" className="block text-sm font-medium text-[#0F172A] mb-1.5">
                    Email Address
                  </label>
                  <div className="relative">
                    <svg
                      className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#003696] pointer-events-none"
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
                      className="w-full rounded-xl border border-[#E2E8F0] pl-10 pr-4 py-3 text-sm text-[#0F172A] placeholder-[#94A3B8] focus:border-[#003696] focus:outline-none focus:ring-2 focus:ring-[#003696]/20 transition"
                    />
                  </div>
                </div>

                <div>
                  <div className="flex items-center justify-between mb-1.5">
                    <label htmlFor="password" className="text-sm font-medium text-[#0F172A]">
                      Password
                    </label>
                    <button type="button" className="text-xs font-medium text-[#003696] hover:text-[#002060] transition">
                      Forgot Password?
                    </button>
                  </div>
                  <div className="relative">
                    <svg
                      className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#003696] pointer-events-none"
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
                      className="w-full rounded-xl border border-[#E2E8F0] pl-10 pr-12 py-3 text-sm text-[#0F172A] placeholder-[#94A3B8] focus:border-[#003696] focus:outline-none focus:ring-2 focus:ring-[#003696]/20 transition"
                    />
                    <button
                      type="button"
                      aria-label={showPw ? "Hide password" : "Show password"}
                      onClick={() => setShowPw((v) => !v)}
                      className="absolute right-3.5 top-1/2 -translate-y-1/2 text-[#003696] hover:text-[#002060] transition"
                    >
                      {showPw ? <EyeOffIcon className="w-4 h-4" /> : <EyeIcon className="w-4 h-4" />}
                    </button>
                  </div>
                </div>

                <button
                  type="submit"
                  disabled={isLoading}
                  className="w-full mt-2 rounded-xl py-3.5 text-white text-sm font-semibold shadow-lg shadow-[#003696]/25 hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#003696] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all"
                  style={{ backgroundColor: "#003696" }}
                >
                  {isLoading ? (
                    <span className="flex items-center justify-center gap-2">
                      <span className="h-4 w-4 rounded-full border-2 border-white/60 border-t-white animate-spin" />
                      Signing in…
                    </span>
                  ) : (
                    "Sign In"
                  )}
                </button>
              </form>
              </div>

              <div className="mt-6 text-center text-sm text-[#64748B]">
                Don&apos;t have an account?{" "}
                <button
                  type="button"
                  onClick={handleRegisterClick}
                  className="text-[#003696] font-semibold hover:text-[#002060]"
                >
                  Create one
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
