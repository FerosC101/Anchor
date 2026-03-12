#!/usr/bin/env python3
"""Write the new LoginPage.tsx and RegisterPage.tsx for Anchor web."""

import os

BASE = "/Users/vince/Codes/Anchor/web/src/pages"

# ─── LoginPage.tsx ────────────────────────────────────────────────────────────
LOGIN = r"""import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
import { ROUTES } from "../core/config/routes";

// ── Icons ─────────────────────────────────────────────────────────────────────
function AnchorIcon({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" fill="currentColor" className={className}>
      <path d="M17 14.5A5.5 5.5 0 0 1 7.072 16H9a1 1 0 0 0 0-2H5a1 1 0 0 0-1 1v4a1 1 0 0 0 2 0v-1.43A7.5 7.5 0 0 0 19.5 14.5a1 1 0 0 0-2 0zM12 2a3 3 0 0 0-1 5.83V10H9a1 1 0 0 0 0 2h2v.17A3.001 3.001 0 0 0 12 18a3 3 0 0 0 1-5.83V12h2a1 1 0 0 0 0-2h-2V7.83A3 3 0 0 0 12 2zm0 2a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm0 12a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
    </svg>
  );
}

function EyeIcon({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className={className}>
      <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
      <circle cx="12" cy="12" r="3" />
    </svg>
  );
}

function EyeOffIcon({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className={className}>
      <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" />
      <line x1="1" y1="1" x2="23" y2="23" />
    </svg>
  );
}

const GRADIENT = { background: "linear-gradient(135deg, #0A2463 0%, #1E3A8A 100%)" };

const FEATURES = [
  { icon: "🛡️", text: "AI-powered contract analysis" },
  { icon: "⚡", text: "Real-time safety alerts" },
  { icon: "💸", text: "Wage protection & tracking" },
  { icon: "🌐", text: "Government-linked support" },
];

export default function LoginPage() {
  const navigate = useNavigate();
  const { signIn, error, clearError, isLoading } = useAuth();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    clearError();
    const success = await signIn(email.trim(), password);
    if (success) navigate(ROUTES.HOME, { replace: true });
  }

  return (
    <div className="min-h-screen flex flex-col lg:flex-row bg-[#F8FAFC]">

      {/* ── Left branding panel (desktop) ───────────────────────────────── */}
      <div
        className="hidden lg:flex lg:w-5/12 xl:w-1/2 flex-col justify-between p-12 relative overflow-hidden"
        style={GRADIENT}
      >
        {/* Decorative circles */}
        <div className="absolute -top-20 -left-20 w-80 h-80 rounded-full bg-white/5 pointer-events-none" />
        <div className="absolute -bottom-24 -right-16 w-96 h-96 rounded-full bg-white/5 pointer-events-none" />
        <div className="absolute top-1/3 -right-10 w-48 h-48 rounded-full bg-white/5 pointer-events-none" />

        {/* Logo */}
        <div className="relative z-10">
          <div className="flex items-center gap-3 mb-1">
            <div className="w-12 h-12 rounded-full bg-white/15 border-2 border-white/30 flex items-center justify-center flex-shrink-0">
              <AnchorIcon className="w-7 h-7 text-white" />
            </div>
            <span className="text-white text-2xl font-extrabold tracking-[0.2em]">ANCHOR</span>
          </div>
          <p className="text-white/60 text-sm pl-[60px]">Protecting Filipino Workers Abroad</p>
        </div>

        {/* Hero text */}
        <div className="relative z-10 space-y-5">
          <h2 className="text-white text-4xl xl:text-5xl font-bold leading-tight">
            Your safety,{" "}
            <span className="text-[#F4A261]">our mission.</span>
          </h2>
          <p className="text-white/70 text-base max-w-sm leading-relaxed">
            Anchor gives every OFW the legal protection, real-time alerts, and
            government support they deserve — wherever they are in the world.
          </p>
          <div className="pt-2 space-y-3">
            {FEATURES.map((f) => (
              <div key={f.text} className="flex items-center gap-3">
                <span className="text-lg leading-none">{f.icon}</span>
                <span className="text-white/80 text-sm">{f.text}</span>
              </div>
            ))}
          </div>
        </div>

        <p className="relative z-10 text-white/35 text-xs">
          © {new Date().getFullYear()} Anchor · For OFWs, by OFWs
        </p>
      </div>

      {/* ── Right panel / full on mobile ──────────────────────────────────── */}
      <div className="flex-1 flex flex-col min-h-screen lg:min-h-0">

        {/* Mobile-only gradient header */}
        <div
          className="lg:hidden px-6 pt-12 pb-16 flex flex-col items-center gap-3"
          style={GRADIENT}
        >
          <div className="w-16 h-16 rounded-full bg-white/15 border-2 border-white/30 flex items-center justify-center">
            <AnchorIcon className="w-9 h-9 text-white" />
          </div>
          <p className="text-white text-2xl font-extrabold tracking-[0.2em]">ANCHOR</p>
          <p className="text-white/65 text-xs">Protecting Filipino Workers Abroad</p>
        </div>

        {/* Form area */}
        <div className="flex-1 flex items-start lg:items-center justify-center px-4 sm:px-8 lg:px-12 xl:px-20 -mt-6 lg:mt-0 pb-12">
          <div className="w-full max-w-md">
            <div className="bg-white rounded-3xl shadow-xl shadow-slate-200/60 p-8 sm:p-10">

              <h1 className="text-[22px] font-bold text-[#0F172A]">Welcome back!</h1>
              <p className="mt-1 text-[#64748B] text-sm">Sign in to your account to continue</p>

              <form onSubmit={handleSubmit} className="mt-7 space-y-5">
                {error && (
                  <div role="alert" className="rounded-xl bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 flex items-start gap-2">
                    <span className="mt-0.5 flex-shrink-0">⚠️</span>
                    <span>{error}</span>
                  </div>
                )}

                {/* Email */}
                <div>
                  <label htmlFor="login-email" className="block text-sm font-medium text-[#0F172A] mb-1.5">
                    Email Address
                  </label>
                  <div className="relative">
                    <svg className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#94A3B8]" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
                      <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                      <polyline points="22,6 12,13 2,6" />
                    </svg>
                    <input
                      id="login-email"
                      type="email"
                      autoComplete="email"
                      required
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      className="w-full rounded-xl border border-[#E2E8F0] pl-10 pr-4 py-3 text-[#0F172A] placeholder-[#94A3B8] text-sm focus:border-[#0A2463] focus:outline-none focus:ring-2 focus:ring-[#0A2463]/20 transition"
                      placeholder="you@example.com"
                    />
                  </div>
                </div>

                {/* Password */}
                <div>
                  <div className="flex items-center justify-between mb-1.5">
                    <label htmlFor="login-password" className="block text-sm font-medium text-[#0F172A]">Password</label>
                    <button type="button" className="text-xs font-medium text-[#0A2463] hover:text-[#1E3A8A] transition">
                      Forgot Password?
                    </button>
                  </div>
                  <div className="relative">
                    <svg className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-[#94A3B8]" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
                      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                    <input
                      id="login-password"
                      type={showPassword ? "text" : "password"}
                      autoComplete="current-password"
                      required
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      className="w-full rounded-xl border border-[#E2E8F0] pl-10 pr-12 py-3 text-[#0F172A] placeholder-[#94A3B8] text-sm focus:border-[#0A2463] focus:outline-none focus:ring-2 focus:ring-[#0A2463]/20 transition"
                      placeholder="••••••••"
                    />
                    <button
                      type="button"
                      onClick={() => setShowPassword((v) => !v)}
                      className="absolute right-3.5 top-1/2 -translate-y-1/2 text-[#94A3B8] hover:text-[#64748B] transition"
                      aria-label={showPassword ? "Hide password" : "Show password"}
                    >
                      {showPassword ? <EyeOffIcon className="w-4 h-4" /> : <EyeIcon className="w-4 h-4" />}
                    </button>
                  </div>
                </div>

                {/* Submit */}
                <button
                  type="submit"
                  disabled={isLoading}
                  style={GRADIENT}
                  className="w-full rounded-xl py-3.5 font-semibold text-white text-sm hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#0A2463] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all shadow-lg shadow-[#0A2463]/25 mt-2"
                >
                  {isLoading ? (
                    <span className="flex items-center justify-center gap-2">
                      <svg className="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                      </svg>
                      Signing in…
                    </span>
                  ) : "Sign In"}
                </button>
              </form>

              <p className="mt-6 text-center text-sm text-[#64748B]">
                Don't have an account?{" "}
                <Link to={ROUTES.REGISTER} className="font-semibold text-[#0A2463] hover:text-[#1E3A8A] transition">
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
"""

# ─── RegisterPage.tsx ─────────────────────────────────────────────────────────
REGISTER = r"""import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
import { ROUTES } from "../core/config/routes";
import { USER_ROLE, type UserRole } from "@/types";

const MIN_PW = 6;
const GRADIENT = { background: "linear-gradient(135deg, #0A2463 0%, #1E3A8A 100%)" };
const TOTAL_STEPS = 3;

// ── Icons ─────────────────────────────────────────────────────────────────────
function AnchorIcon({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" fill="currentColor" className={className}>
      <path d="M17 14.5A5.5 5.5 0 0 1 7.072 16H9a1 1 0 0 0 0-2H5a1 1 0 0 0-1 1v4a1 1 0 0 0 2 0v-1.43A7.5 7.5 0 0 0 19.5 14.5a1 1 0 0 0-2 0zM12 2a3 3 0 0 0-1 5.83V10H9a1 1 0 0 0 0 2h2v.17A3.001 3.001 0 0 0 12 18a3 3 0 0 0 1-5.83V12h2a1 1 0 0 0 0-2h-2V7.83A3 3 0 0 0 12 2zm0 2a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm0 12a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
    </svg>
  );
}

function EyeIcon({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className={className}>
      <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
      <circle cx="12" cy="12" r="3" />
    </svg>
  );
}

function EyeOffIcon({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className={className}>
      <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" />
      <line x1="1" y1="1" x2="23" y2="23" />
    </svg>
  );
}

// ── Input field helper ────────────────────────────────────────────────────────
function Field({
  id, label, type = "text", value, onChange, placeholder, required, autoComplete, minLength,
  icon, rightSlot, hint, error,
}: {
  id: string; label: string; type?: string; value: string;
  onChange: (v: string) => void; placeholder?: string; required?: boolean;
  autoComplete?: string; minLength?: number; icon?: React.ReactNode;
  rightSlot?: React.ReactNode; hint?: string; error?: string;
}) {
  return (
    <div>
      <label htmlFor={id} className="block text-sm font-medium text-[#0F172A] mb-1.5">{label}</label>
      <div className="relative">
        {icon && (
          <span className="absolute left-3.5 top-1/2 -translate-y-1/2 text-[#94A3B8] pointer-events-none">
            {icon}
          </span>
        )}
        <input
          id={id}
          type={type}
          value={value}
          onChange={(e) => onChange(e.target.value)}
          placeholder={placeholder}
          required={required}
          autoComplete={autoComplete}
          minLength={minLength}
          className={`w-full rounded-xl border py-3 text-[#0F172A] placeholder-[#94A3B8] text-sm focus:outline-none focus:ring-2 transition
            ${icon ? "pl-10" : "pl-4"}
            ${rightSlot ? "pr-12" : "pr-4"}
            ${error ? "border-red-400 focus:border-red-500 focus:ring-red-500/20" : "border-[#E2E8F0] focus:border-[#0A2463] focus:ring-[#0A2463]/20"}`}
        />
        {rightSlot && (
          <span className="absolute right-3.5 top-1/2 -translate-y-1/2">{rightSlot}</span>
        )}
      </div>
      {(hint || error) && (
        <p className={`mt-1 text-xs ${error ? "text-red-500" : "text-[#94A3B8]"}`}>
          {error ?? hint}
        </p>
      )}
    </div>
  );
}

// ── Role card ─────────────────────────────────────────────────────────────────
function RoleCard({
  value, current, onSelect, icon, title, description, accentColor,
}: {
  value: string; current: string; onSelect: () => void;
  icon: React.ReactNode; title: string; description: string; accentColor: string;
}) {
  const selected = value === current;
  return (
    <button
      type="button"
      onClick={onSelect}
      className={`w-full text-left rounded-2xl border-2 p-4 sm:p-5 transition-all ${
        selected ? "border-[#0A2463] bg-[#0A2463]/5 shadow-sm" : "border-[#E2E8F0] hover:border-[#0A2463]/40 hover:bg-slate-50"
      }`}
    >
      <div className="flex items-start gap-4">
        <div
          className="w-11 h-11 rounded-xl flex items-center justify-center flex-shrink-0"
          style={{ backgroundColor: accentColor + "22" }}
        >
          <span style={{ color: accentColor }}>{icon}</span>
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between gap-2">
            <p className="font-semibold text-[#0F172A] text-sm">{title}</p>
            {selected && (
              <span className="w-5 h-5 rounded-full flex items-center justify-center flex-shrink-0" style={{ backgroundColor: "#0A2463" }}>
                <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                  <polyline points="20 6 9 17 4 12" />
                </svg>
              </span>
            )}
          </div>
          <p className="text-[#64748B] text-xs mt-0.5 leading-relaxed">{description}</p>
        </div>
      </div>
    </button>
  );
}

// ── Section label ─────────────────────────────────────────────────────────────
function SectionLabel({ children }: { children: React.ReactNode }) {
  return (
    <p className="text-[10px] font-bold text-[#94A3B8] uppercase tracking-widest mb-3">{children}</p>
  );
}

// ── Step indicator ────────────────────────────────────────────────────────────
function StepIndicator({ step, total }: { step: number; total: number }) {
  return (
    <div className="flex flex-col items-center gap-2 w-full">
      <div className="flex items-center gap-1.5">
        {Array.from({ length: total }, (_, i) => {
          const done = i < step;
          const active = i === step;
          return (
            <div
              key={i}
              className={`rounded-full transition-all duration-300 ${
                active ? "w-7 h-2.5 bg-white" : done ? "w-2.5 h-2.5 bg-white/70" : "w-2.5 h-2.5 bg-white/30"
              }`}
            />
          );
        })}
      </div>
      <div className="w-full bg-white/25 rounded-full h-1 overflow-hidden">
        <div
          className="h-full bg-white rounded-full transition-all duration-500"
          style={{ width: `${((step + 1) / total) * 100}%` }}
        />
      </div>
      <p className="text-white/70 text-xs">Step {step + 1} of {total}</p>
    </div>
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// RegisterPage
// ═══════════════════════════════════════════════════════════════════════════════
export default function RegisterPage() {
  const navigate = useNavigate();
  const { register: registerUser, error, clearError, isLoading } = useAuth();

  const [step, setStep] = useState(0);

  // Step 1 – Basic info
  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [country, setCountry] = useState("Philippines");
  const [password, setPassword] = useState("");
  const [confirmPw, setConfirmPw] = useState("");
  const [showPw, setShowPw] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);

  // Step 2 – Role
  const [role, setRole] = useState<string>("");

  // Step 3 – Role details
  const [passportNum, setPassportNum] = useState("");
  const [destCountry, setDestCountry] = useState("Saudi Arabia");
  const [jobTitle, setJobTitle] = useState("");
  const [expYears, setExpYears] = useState("");
  const [orgName, setOrgName] = useState("");
  const [roleTitle, setRoleTitle] = useState("");

  // Validation helpers
  const pwValid = password.length >= MIN_PW;
  const pwMatch = password === confirmPw;
  const showPwError = (password.length > 0 && !pwValid) || (confirmPw.length > 0 && !pwMatch);

  function step1Error() {
    if (!fullName.trim()) return "Full name is required.";
    if (!email.trim() || !/^[^@]+@[^@]+\.[^@]+/.test(email)) return "Enter a valid email.";
    if (!phone.trim()) return "Phone number is required.";
    if (!pwValid) return `Password must be at least ${MIN_PW} characters.`;
    if (!pwMatch) return "Passwords do not match.";
    return null;
  }

  function goNext() {
    clearError();
    if (step === 0) {
      const err = step1Error();
      if (err) { alert(err); return; }
      setStep(1);
    } else if (step === 1) {
      if (!role) { alert("Please select a role."); return; }
      setStep(2);
    } else {
      handleSubmit();
    }
  }

  async function handleSubmit() {
    clearError();
    const success = await registerUser({
      email: email.trim(),
      password,
      fullName: fullName.trim(),
      role: role as UserRole,
      phoneNumber: phone.trim(),
      country: country.trim(),
    });
    if (success) navigate(ROUTES.HOME, { replace: true });
  }

  const STEP_TITLES = ["Basic Information", "Choose Your Role", role === USER_ROLE.OFW ? "OFW Details" : "Organization Details"];

  return (
    <div className="min-h-screen flex flex-col lg:flex-row bg-[#F8FAFC]">

      {/* ── Left branding panel (desktop) ───────────────────────────────── */}
      <div
        className="hidden lg:flex lg:w-5/12 xl:w-2/5 flex-col p-12 relative overflow-hidden"
        style={GRADIENT}
      >
        <div className="absolute -top-20 -left-20 w-80 h-80 rounded-full bg-white/5 pointer-events-none" />
        <div className="absolute -bottom-24 -right-16 w-96 h-96 rounded-full bg-white/5 pointer-events-none" />

        {/* Logo */}
        <div className="relative z-10 mb-10">
          <div className="flex items-center gap-3 mb-1">
            <div className="w-12 h-12 rounded-full bg-white/15 border-2 border-white/30 flex items-center justify-center flex-shrink-0">
              <AnchorIcon className="w-7 h-7 text-white" />
            </div>
            <span className="text-white text-2xl font-extrabold tracking-[0.2em]">ANCHOR</span>
          </div>
          <p className="text-white/60 text-sm pl-[60px]">Protecting Filipino Workers Abroad</p>
        </div>

        {/* Step info */}
        <div className="relative z-10 flex-1 flex flex-col justify-center space-y-8">
          <div>
            <p className="text-white/50 text-xs font-semibold uppercase tracking-widest mb-2">Registration</p>
            <h2 className="text-white text-3xl xl:text-4xl font-bold leading-tight">
              {STEP_TITLES[step]}
            </h2>
          </div>
          <StepIndicator step={step} total={TOTAL_STEPS} />

          {/* Step descriptions */}
          <div className="space-y-3">
            {[
              { title: "Basic Information", desc: "Your name, email, and password" },
              { title: "Your Role", desc: "OFW, Government, or NGO" },
              { title: "Role Details", desc: "Tailored information for your role" },
            ].map((s, i) => (
              <div key={i} className={`flex items-center gap-3 transition-opacity ${i === step ? "opacity-100" : i < step ? "opacity-60" : "opacity-30"}`}>
                <div className={`w-6 h-6 rounded-full flex items-center justify-center flex-shrink-0 text-xs font-bold ${
                  i < step ? "bg-[#F4A261] text-white" : i === step ? "bg-white text-[#0A2463]" : "bg-white/20 text-white"
                }`}>
                  {i < step ? "✓" : i + 1}
                </div>
                <div>
                  <p className="text-white text-sm font-medium">{s.title}</p>
                  <p className="text-white/50 text-xs">{s.desc}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        <p className="relative z-10 text-white/35 text-xs mt-8">
          © {new Date().getFullYear()} Anchor · For OFWs, by OFWs
        </p>
      </div>

      {/* ── Right / full on mobile ─────────────────────────────────────────── */}
      <div className="flex-1 flex flex-col min-h-screen lg:min-h-0">

        {/* Mobile header */}
        <div className="lg:hidden flex flex-col" style={GRADIENT}>
          <div className="px-6 pt-10 pb-4 flex items-center gap-3">
            {step > 0 ? (
              <button type="button" onClick={() => setStep(step - 1)} className="w-9 h-9 rounded-full bg-white/15 flex items-center justify-center mr-1">
                <svg className="w-4 h-4 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <polyline points="15 18 9 12 15 6" />
                </svg>
              </button>
            ) : (
              <div className="w-10 h-10 rounded-full bg-white/15 border-2 border-white/30 flex items-center justify-center flex-shrink-0">
                <AnchorIcon className="w-6 h-6 text-white" />
              </div>
            )}
            <div className="flex-1">
              <p className="text-white font-bold text-base">{STEP_TITLES[step]}</p>
              <p className="text-white/60 text-xs">ANCHOR · Step {step + 1} of {TOTAL_STEPS}</p>
            </div>
          </div>
          <div className="px-6 pb-5">
            <StepIndicator step={step} total={TOTAL_STEPS} />
          </div>
        </div>

        {/* Scrollable form area */}
        <div className="flex-1 overflow-y-auto">
          <div className="max-w-xl mx-auto px-4 sm:px-8 lg:px-12 py-8">

            {/* Desktop back + step title */}
            <div className="hidden lg:flex items-center gap-3 mb-6">
              {step > 0 && (
                <button type="button" onClick={() => setStep(step - 1)}
                  className="w-9 h-9 rounded-full border-2 border-[#E2E8F0] hover:border-[#0A2463] flex items-center justify-center transition">
                  <svg className="w-4 h-4 text-[#64748B]" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                    <polyline points="15 18 9 12 15 6" />
                  </svg>
                </button>
              )}
              <div>
                <h2 className="text-xl font-bold text-[#0F172A]">{STEP_TITLES[step]}</h2>
                <p className="text-[#64748B] text-sm">Step {step + 1} of {TOTAL_STEPS}</p>
              </div>
            </div>

            {/* Error banner */}
            {(error || showPwError) && step === 0 && (
              <div role="alert" className="rounded-xl bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 flex items-start gap-2 mb-5">
                <span className="flex-shrink-0">⚠️</span>
                <span>{error || (password.length > 0 && !pwValid ? `Password must be at least ${MIN_PW} characters.` : "Passwords do not match.")}</span>
              </div>
            )}
            {error && step > 0 && (
              <div role="alert" className="rounded-xl bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 flex items-start gap-2 mb-5">
                <span className="flex-shrink-0">⚠️</span>
                <span>{error}</span>
              </div>
            )}

            {/* ── STEP 1: Basic Info ─────────────────────────────────────── */}
            {step === 0 && (
              <div className="space-y-5">
                <SectionLabel>Personal Information</SectionLabel>
                <Field
                  id="reg-name" label="Full Name" value={fullName} onChange={setFullName}
                  placeholder="Juan dela Cruz" required autoComplete="name"
                  icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" /></svg>}
                />
                <Field
                  id="reg-email" label="Email Address" type="email" value={email} onChange={setEmail}
                  placeholder="juan@example.com" required autoComplete="email"
                  icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" /><polyline points="22,6 12,13 2,6" /></svg>}
                />
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <Field
                    id="reg-phone" label="Phone Number" type="tel" value={phone} onChange={setPhone}
                    placeholder="+63 9XX XXX XXXX" autoComplete="tel"
                    icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 13a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z" /></svg>}
                  />
                  <Field
                    id="reg-country" label="Current Country" value={country} onChange={setCountry}
                    placeholder="Philippines" autoComplete="country-name"
                    icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><circle cx="12" cy="12" r="10" /><line x1="2" y1="12" x2="22" y2="12" /><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" /></svg>}
                  />
                </div>

                <SectionLabel>Security</SectionLabel>
                <Field
                  id="reg-password" label="Password" type={showPw ? "text" : "password"} value={password}
                  onChange={setPassword} placeholder="At least 6 characters" required
                  autoComplete="new-password" minLength={MIN_PW}
                  hint={`Minimum ${MIN_PW} characters`}
                  error={password.length > 0 && !pwValid ? `Must be at least ${MIN_PW} characters` : undefined}
                  icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><rect x="3" y="11" width="18" height="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" /></svg>}
                  rightSlot={
                    <button type="button" onClick={() => setShowPw((v) => !v)} className="text-[#94A3B8] hover:text-[#64748B] transition" aria-label={showPw ? "Hide" : "Show"}>
                      {showPw ? <EyeOffIcon className="w-4 h-4" /> : <EyeIcon className="w-4 h-4" />}
                    </button>
                  }
                />
                <Field
                  id="reg-confirm" label="Confirm Password" type={showConfirm ? "text" : "password"} value={confirmPw}
                  onChange={setConfirmPw} placeholder="••••••••" required
                  autoComplete="new-password" minLength={MIN_PW}
                  error={confirmPw.length > 0 && !pwMatch ? "Passwords do not match" : undefined}
                  icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><rect x="3" y="11" width="18" height="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" /></svg>}
                  rightSlot={
                    <button type="button" onClick={() => setShowConfirm((v) => !v)} className="text-[#94A3B8] hover:text-[#64748B] transition" aria-label={showConfirm ? "Hide" : "Show"}>
                      {showConfirm ? <EyeOffIcon className="w-4 h-4" /> : <EyeIcon className="w-4 h-4" />}
                    </button>
                  }
                />

                <p className="text-center text-sm text-[#64748B] pt-1">
                  Already have an account?{" "}
                  <Link to={ROUTES.LOGIN} className="font-semibold text-[#0A2463] hover:text-[#1E3A8A] transition">Sign In</Link>
                </p>
              </div>
            )}

            {/* ── STEP 2: Role Selection ─────────────────────────────────── */}
            {step === 1 && (
              <div className="space-y-4">
                <p className="text-[#64748B] text-sm">Select the role that best describes you.</p>
                <RoleCard
                  value={USER_ROLE.OFW} current={role} onSelect={() => setRole(USER_ROLE.OFW)}
                  accentColor="#0EA5E9"
                  icon={<svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><path d="M5 17H3a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11a2 2 0 0 1 2 2v3m4 9l-4-4m0 0l4-4m-4 4H10" /></svg>}
                  title="OFW Worker"
                  description="I am an Overseas Filipino Worker seeking contract protection and employment support."
                />
                <RoleCard
                  value={USER_ROLE.AGENCY ?? "agency"} current={role} onSelect={() => setRole(USER_ROLE.AGENCY ?? "agency")}
                  accentColor="#8B5CF6"
                  icon={<svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><rect x="2" y="7" width="20" height="14" rx="2" ry="2" /><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" /></svg>}
                  title="Government / Agency"
                  description="I work for a government agency, embassy, or consulate that supports and protects OFWs."
                />
                <RoleCard
                  value={USER_ROLE.VERIFIER ?? "verifier"} current={role} onSelect={() => setRole(USER_ROLE.VERIFIER ?? "verifier")}
                  accentColor="#10B981"
                  icon={<svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" /></svg>}
                  title="NGO / Verifier"
                  description="I represent a non-governmental organization providing assistance and advocacy for OFWs."
                />
              </div>
            )}

            {/* ── STEP 3: Role Details ───────────────────────────────────── */}
            {step === 2 && (
              <div className="space-y-5">
                {/* Role banner */}
                <div className="rounded-2xl border p-4 flex items-start gap-3"
                  style={{
                    backgroundColor: role === USER_ROLE.OFW ? "#0EA5E911" : role === (USER_ROLE.AGENCY ?? "agency") ? "#8B5CF611" : "#10B98111",
                    borderColor: role === USER_ROLE.OFW ? "#0EA5E944" : role === (USER_ROLE.AGENCY ?? "agency") ? "#8B5CF644" : "#10B98144",
                  }}>
                  <div className="w-9 h-9 rounded-xl flex items-center justify-center flex-shrink-0"
                    style={{ backgroundColor: role === USER_ROLE.OFW ? "#0EA5E922" : role === (USER_ROLE.AGENCY ?? "agency") ? "#8B5CF622" : "#10B98122" }}>
                    <svg className="w-5 h-5" style={{ color: role === USER_ROLE.OFW ? "#0EA5E9" : role === (USER_ROLE.AGENCY ?? "agency") ? "#8B5CF6" : "#10B981" }}
                      fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                      <circle cx="12" cy="12" r="10" /><line x1="12" y1="8" x2="12" y2="12" /><line x1="12" y1="16" x2="12.01" y2="16" />
                    </svg>
                  </div>
                  <div>
                    <p className="font-semibold text-[#0F172A] text-sm">{role === USER_ROLE.OFW ? "OFW Worker" : role === (USER_ROLE.AGENCY ?? "agency") ? "Government / Agency" : "NGO / Verifier"}</p>
                    <p className="text-[#64748B] text-xs mt-0.5">
                      {role === USER_ROLE.OFW
                        ? "This info helps protect your rights abroad. You can update it in your profile later."
                        : "You'll have access to OFW support tools and case management features."}
                    </p>
                  </div>
                </div>

                {role === USER_ROLE.OFW ? (
                  <>
                    <SectionLabel>Work Information</SectionLabel>
                    <Field
                      id="reg-passport" label="Passport Number (optional)" value={passportNum} onChange={setPassportNum}
                      placeholder="A1234567"
                      icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><rect x="2" y="3" width="20" height="18" rx="2" ry="2" /><line x1="8" y1="12" x2="16" y2="12" /><line x1="8" y1="8" x2="16" y2="8" /><line x1="8" y1="16" x2="12" y2="16" /></svg>}
                    />
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                      <Field
                        id="reg-dest" label="Destination Country" value={destCountry} onChange={setDestCountry}
                        placeholder="Saudi Arabia"
                        icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><circle cx="12" cy="12" r="10" /><line x1="2" y1="12" x2="22" y2="12" /><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" /></svg>}
                      />
                      <Field
                        id="reg-jobtitle" label="Job Title (optional)" value={jobTitle} onChange={setJobTitle}
                        placeholder="Domestic Worker"
                        icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><rect x="2" y="7" width="20" height="14" rx="2" ry="2" /><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" /></svg>}
                      />
                    </div>
                    <Field
                      id="reg-exp" label="Years of Experience (optional)" type="number" value={expYears} onChange={setExpYears}
                      placeholder="0"
                      icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" /></svg>}
                    />
                  </>
                ) : (
                  <>
                    <SectionLabel>Organization Details</SectionLabel>
                    <Field
                      id="reg-org" label="Organization Name" value={orgName} onChange={setOrgName}
                      placeholder="e.g. OWWA, Philippine Embassy, Migrante International" required
                      icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><line x1="3" y1="22" x2="21" y2="22" /><rect x="2" y="9" width="20" height="13" /><path d="M12 2L2 9h20z" /></svg>}
                    />
                    <Field
                      id="reg-roletitle" label="Your Role / Title" value={roleTitle} onChange={setRoleTitle}
                      placeholder="e.g. Labor Attaché, Program Officer, Case Worker" required
                      icon={<svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}><rect x="2" y="3" width="20" height="18" rx="2" ry="2" /><line x1="8" y1="12" x2="16" y2="12" /><line x1="8" y1="8" x2="16" y2="8" /><line x1="8" y1="16" x2="12" y2="16" /></svg>}
                    />
                  </>
                )}
              </div>
            )}

            {/* ── Continue / Create account button ──────────────────────── */}
            <button
              type="button"
              onClick={goNext}
              disabled={isLoading}
              style={GRADIENT}
              className="w-full mt-8 rounded-xl py-3.5 font-semibold text-white text-sm hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#0A2463] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all shadow-lg shadow-[#0A2463]/25"
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <svg className="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                  </svg>
                  Creating account…
                </span>
              ) : step < TOTAL_STEPS - 1 ? "Continue" : "Create Account"}
            </button>

            {step === 0 && (
              <p className="mt-4 text-center text-sm text-[#64748B] lg:hidden">
                Already have an account?{" "}
                <Link to={ROUTES.LOGIN} className="font-semibold text-[#0A2463] hover:text-[#1E3A8A] transition">Sign In</Link>
              </p>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
"""

with open(os.path.join(BASE, "LoginPage.tsx"), "w") as f:
    f.write(LOGIN)
print("LoginPage.tsx written")

with open(os.path.join(BASE, "RegisterPage.tsx"), "w") as f:
    f.write(REGISTER)
print("RegisterPage.tsx written")
