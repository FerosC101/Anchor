import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
import { ROUTES, getDefaultRouteForRole } from "../core/config/routes";
import { USER_ROLE, type UserRole } from "@/types";

const GRADIENT: React.CSSProperties = {
  background: "linear-gradient(135deg, #DFEDFF 0%, #003696 100%)",
};
const TOTAL = 3;
const MIN_PW = 6;
const STEP_TITLES = ["Basic Information", "Choose Your Role", "Role Details"];
const INFO_ITEMS = [
  "AI-powered contract analysis",
  "Real-time safety alerts",
  "Wage protection & tracking",
  "Government-linked support",
];

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

function Field({
  id,
  label,
  type = "text",
  value,
  onChange,
  placeholder,
  required,
  autoComplete,
  minLength,
  icon,
  right,
  hint,
  error,
}: {
  id: string;
  label: string;
  type?: string;
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  required?: boolean;
  autoComplete?: string;
  minLength?: number;
  icon?: React.ReactNode;
  right?: React.ReactNode;
  hint?: string;
  error?: string;
}) {
  const border = error
    ? "border-red-400 focus:border-red-500 focus:ring-red-500/20"
    : "border-[#E2E8F0] focus:border-[#003696] focus:ring-[#003696]/20";
  return (
    <div>
      <label htmlFor={id} className="block text-sm font-medium text-[#0F172A] mb-1.5">
        {label}
      </label>
      <div className="relative">
        {icon && (
          <span className="absolute left-3.5 top-1/2 -translate-y-1/2 text-[#94A3B8] pointer-events-none w-4 h-4 flex items-center">
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
          className={`w-full rounded-xl border py-3 text-sm text-[#0F172A] placeholder-[#94A3B8] focus:outline-none focus:ring-2 transition ${border} ${icon ? "pl-10" : "pl-4"} ${right ? "pr-12" : "pr-4"}`}
        />
        {right && <span className="absolute right-3.5 top-1/2 -translate-y-1/2">{right}</span>}
      </div>
      {(hint || error) && (
        <p className={`mt-1 text-xs ${error ? "text-red-500" : "text-[#94A3B8]"}`}>{error ?? hint}</p>
      )}
    </div>
  );
}

function RoleCard({
  value,
  current,
  onSelect,
  icon,
  label,
  desc,
  color,
}: {
  value: string;
  current: string;
  onSelect: () => void;
  icon: React.ReactNode;
  label: string;
  desc: string;
  color: string;
}) {
  const active = value === current;
  return (
    <button
      type="button"
      onClick={onSelect}
      className={`w-full text-left rounded-2xl border-2 p-4 sm:p-5 transition-all ${
        active
          ? "border-[#003696] bg-[#003696]/5 shadow-sm"
          : "border-[#E2E8F0] hover:border-[#003696]/40 hover:bg-slate-50"
      }`}
    >
      <div className="flex items-start gap-4">
        <div className="w-11 h-11 rounded-xl flex items-center justify-center shrink-0" style={{ backgroundColor: color + "22" }}>
          <span style={{ color }}>{icon}</span>
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between gap-2">
            <p className="font-semibold text-sm text-[#0F172A]">{label}</p>
            {active && (
              <span className="w-5 h-5 rounded-full bg-[#003696] flex items-center justify-center shrink-0">
                <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                  <polyline points="20 6 9 17 4 12" />
                </svg>
              </span>
            )}
          </div>
          <p className="text-[#64748B] text-xs mt-0.5 leading-relaxed">{desc}</p>
        </div>
      </div>
    </button>
  );
}

function SLabel({ children }: { children: React.ReactNode }) {
  return <p className="text-[10px] font-bold text-[#94A3B8] uppercase tracking-widest mb-3">{children}</p>;
}

export default function RegisterPageNew() {
  const navigate = useNavigate();
  const { register: registerUser, error, clearError, isLoading } = useAuth();
  const [step, setStep] = useState(0);

  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [country, setCountry] = useState("Philippines");
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [showPw, setShowPw] = useState(false);
  const [showCf, setShowCf] = useState(false);
  const [role, setRole] = useState<string>("");

  const [passport, setPassport] = useState("");
  const [dest, setDest] = useState("Saudi Arabia");
  const [jobTitle, setJobTitle] = useState("");
  const [expYrs, setExpYrs] = useState("");
  const [orgName, setOrgName] = useState("");
  const [roleTitle, setRoleTitle] = useState("");

  const pwOk = password.length >= MIN_PW;
  const pwMatch = password === confirm;
  const isOfw = role === USER_ROLE.OFW;

  function validate1() {
    if (!fullName.trim()) return "Full name is required.";
    if (!/^[^@]+@[^@]+\.[^@]+$/.test(email)) return "Enter a valid email address.";
    if (!phone.trim()) return "Phone number is required.";
    if (!pwOk) return `Password must be at least ${MIN_PW} characters.`;
    if (!pwMatch) return "Passwords do not match.";
    return null;
  }

  async function advance() {
    clearError();
    if (step === 0) {
      const err = validate1();
      if (err) {
        alert(err);
        return;
      }
      setStep(1);
      return;
    }
    if (step === 1) {
      if (!role) {
        alert("Please select a role.");
        return;
      }
      setStep(2);
      return;
    }

    const roleData = isOfw
      ? {
          passport_number: passport.trim() || undefined,
          destination_country: dest,
          job_title: jobTitle.trim() || undefined,
          experience_years: expYrs ? Number(expYrs) : undefined,
        }
      : {
          organization_name: orgName.trim(),
          role_title: roleTitle.trim(),
        };

    const ok = await registerUser({
      email: email.trim(),
      password,
      fullName: fullName.trim(),
      role: role as UserRole,
      phoneNumber: phone.trim(),
      country: country.trim(),
      roleData,
    });
    if (ok) navigate(getDefaultRouteForRole(role as UserRole), { replace: true });
  }

  function handleBack() {
    if (step === 0) {
      navigate(ROUTES.LOGIN);
      return;
    }
    setStep(step - 1);
  }

  return (
    <div className="min-h-screen bg-white lg:flex">
      <aside className="hidden lg:flex lg:w-1/2 flex-col justify-between px-12 py-14 text-white" style={GRADIENT}>
        <div>
          <p className="text-[26px] font-extrabold tracking-[0.3em] text-[#003696]">ANCHOR</p>
          <p className="mt-2 text-sm text-white/85">Protecting Filipino Workers Abroad</p>
        </div>

        <div className="mt-10 space-y-6">
          <h2 className="text-4xl font-bold leading-tight">Your safety, our mission.</h2>
          <p className="text-white/85 text-sm max-w-md">
            Anchor gives every OFW the legal protection, real-time alerts, and government support they deserve — wherever they are in the world.
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

        <p className="text-white/50 text-xs">&copy; {new Date().getFullYear()} Anchor · For OFWs, by OFWs</p>
      </aside>

      <div className="flex-1 relative lg:flex lg:items-center lg:justify-center">
        <div className="-mt-6 px-4 pb-28 lg:mt-0 lg:flex lg:min-h-screen lg:w-full lg:items-center lg:justify-center lg:px-12 lg:py-0 lg:pb-0">
          <div className="mx-auto flex w-full max-w-xl flex-col items-center">
            <div className="w-full overflow-hidden rounded-3xl bg-white shadow-[0_12px_32px_rgba(15,23,42,0.12)]">
              <div className="bg-white px-5 pt-5 pb-4 sm:px-7 sm:pt-6 sm:pb-5">
                <div className="flex items-start justify-between gap-4">
                  <div className="min-w-0 flex-1">
                    <p className="text-[10px] font-bold uppercase tracking-[0.26em] text-[#94A3B8]">
                      Registration
                    </p>
                    <h2 className="mt-2 text-[18px] sm:text-[22px] font-semibold leading-tight text-[#0F172A]">
                      {STEP_TITLES[step]}
                    </h2>
                    <p className="mt-1 text-xs text-[#94A3B8]">
                      Create your account and set up your profile.
                    </p>
                  </div>
                  <button
                    type="button"
                    onClick={handleBack}
                    className="h-9 w-9 rounded-full border border-[#E2E8F0] bg-white text-[#003696] shadow-sm flex items-center justify-center lg:hidden"
                    aria-label="Go back"
                  >
                    <svg className="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                      <polyline points="15 18 9 12 15 6" />
                    </svg>
                  </button>
                </div>

                <div className="mt-3 h-1 w-full overflow-hidden rounded-full bg-[#E2E8F0]">
                  <div
                    className="h-full rounded-full bg-[#003696] transition-all duration-300"
                    style={{ width: `${((step + 1) / TOTAL) * 100}%` }}
                  />
                </div>

                <p className="mt-2 text-center text-xs text-[#94A3B8]">
                  Step {step + 1} of {TOTAL}
                </p>
              </div>

              <div className="px-5 pb-6 pt-2 sm:px-7 sm:pb-7 sm:pt-3">
            {error && (
              <div role="alert" className="rounded-xl bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 flex gap-2 mb-5">
                <span className="shrink-0">⚠️</span>
                <span>{error}</span>
              </div>
            )}

            {step === 0 && (
              <div className="space-y-5">
                <SLabel>Personal Information</SLabel>
                <Field
                  id="reg-name"
                  label="Full Name"
                  value={fullName}
                  onChange={setFullName}
                  placeholder="Juan dela Cruz"
                  required
                  autoComplete="name"
                  icon={
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                      <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                      <circle cx="12" cy="7" r="4" />
                    </svg>
                  }
                />
                <Field
                  id="reg-email"
                  label="Email Address"
                  type="email"
                  value={email}
                  onChange={setEmail}
                  placeholder="juan@example.com"
                  required
                  autoComplete="email"
                  icon={
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                      <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                      <polyline points="22,6 12,13 2,6" />
                    </svg>
                  }
                />
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <Field
                    id="reg-phone"
                    label="Phone Number"
                    type="tel"
                    value={phone}
                    onChange={setPhone}
                    placeholder="+63 9XX XXX XXXX"
                    autoComplete="tel"
                    icon={
                      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 13a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z" />
                      </svg>
                    }
                  />
                  <Field
                    id="reg-country"
                    label="Current Country"
                    value={country}
                    onChange={setCountry}
                    placeholder="Philippines"
                    autoComplete="country-name"
                    icon={
                      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                        <circle cx="12" cy="12" r="10" />
                        <line x1="2" y1="12" x2="22" y2="12" />
                        <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                      </svg>
                    }
                  />
                </div>
                <SLabel>Security</SLabel>
                <Field
                  id="reg-pw"
                  label="Password"
                  type={showPw ? "text" : "password"}
                  value={password}
                  onChange={setPassword}
                  placeholder="At least 6 characters"
                  required
                  autoComplete="new-password"
                  minLength={MIN_PW}
                  hint={`Minimum ${MIN_PW} characters`}
                  error={password.length > 0 && !pwOk ? `Must be at least ${MIN_PW} characters` : undefined}
                  icon={
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                  }
                  right={
                    <button type="button" onClick={() => setShowPw((v) => !v)} className="text-[#94A3B8] hover:text-[#64748B] transition" aria-label="Toggle">
                      {showPw ? <EyeOffIcon className="w-4 h-4" /> : <EyeIcon className="w-4 h-4" />}
                    </button>
                  }
                />
                <Field
                  id="reg-cf"
                  label="Confirm Password"
                  type={showCf ? "text" : "password"}
                  value={confirm}
                  onChange={setConfirm}
                  placeholder="Repeat your password"
                  required
                  autoComplete="new-password"
                  error={confirm.length > 0 && !pwMatch ? "Passwords do not match" : undefined}
                  icon={
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                  }
                  right={
                    <button type="button" onClick={() => setShowCf((v) => !v)} className="text-[#94A3B8] hover:text-[#64748B] transition" aria-label="Toggle">
                      {showCf ? <EyeOffIcon className="w-4 h-4" /> : <EyeIcon className="w-4 h-4" />}
                    </button>
                  }
                />
              </div>
            )}

            {step === 1 && (
              <div className="space-y-4">
                <p className="text-[#64748B] text-sm mb-1">Select the role that best describes you.</p>
                <RoleCard
                  value={USER_ROLE.OFW}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.OFW)}
                  color="#0EA5E9"
                  label="OFW Worker"
                  desc="I am an Overseas Filipino Worker seeking contract protection and employment support."
                  icon={
                    <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                      <circle cx="12" cy="12" r="10" />
                      <polyline points="12 6 12 12 16 14" />
                    </svg>
                  }
                />
                <RoleCard
                  value={USER_ROLE.AGENCY}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.AGENCY)}
                  color="#8B5CF6"
                  label="Government / Agency"
                  desc="I work for a government agency, embassy, or consulate supporting and protecting OFWs."
                  icon={
                    <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                      <rect x="2" y="7" width="20" height="14" rx="2" ry="2" />
                      <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                    </svg>
                  }
                />
                <RoleCard
                  value={USER_ROLE.VERIFIER}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.VERIFIER)}
                  color="#10B981"
                  label="NGO / Verifier"
                  desc="I represent a non-governmental organization providing assistance and advocacy for OFWs."
                  icon={
                    <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                      <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                    </svg>
                  }
                />
              </div>
            )}

            {step === 2 && (
              <div className="space-y-5">
                <div
                  className="rounded-2xl border p-4 flex items-start gap-3"
                  style={{
                    backgroundColor: (isOfw ? "#0EA5E9" : role === USER_ROLE.AGENCY ? "#8B5CF6" : "#10B981") + "11",
                    borderColor: (isOfw ? "#0EA5E9" : role === USER_ROLE.AGENCY ? "#8B5CF6" : "#10B981") + "44",
                  }}
                >
                  <div
                    className="w-9 h-9 rounded-xl flex items-center justify-center shrink-0"
                    style={{ backgroundColor: (isOfw ? "#0EA5E9" : role === USER_ROLE.AGENCY ? "#8B5CF6" : "#10B981") + "22" }}
                  >
                    <svg
                      className="w-5 h-5"
                      style={{ color: isOfw ? "#0EA5E9" : role === USER_ROLE.AGENCY ? "#8B5CF6" : "#10B981" }}
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <circle cx="12" cy="12" r="10" />
                      <line x1="12" y1="8" x2="12" y2="12" />
                      <line x1="12" y1="16" x2="12.01" y2="16" />
                    </svg>
                  </div>
                  <div>
                    <p className="font-semibold text-sm text-[#0F172A]">
                      {isOfw ? "OFW Worker" : role === USER_ROLE.AGENCY ? "Government / Agency" : "NGO / Verifier"}
                    </p>
                    <p className="text-[#64748B] text-xs mt-0.5">
                      {isOfw
                        ? "This info helps protect your rights abroad. You can update it in your profile later."
                        : "You will have access to OFW support tools and case management features."}
                    </p>
                  </div>
                </div>

                {isOfw ? (
                  <>
                    <SLabel>Work Information</SLabel>
                    <Field
                      id="reg-passport"
                      label="Passport Number (optional)"
                      value={passport}
                      onChange={setPassport}
                      placeholder="A1234567"
                      icon={
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                          <rect x="2" y="3" width="20" height="18" rx="2" ry="2" />
                          <line x1="8" y1="12" x2="16" y2="12" />
                          <line x1="8" y1="8" x2="16" y2="8" />
                          <line x1="8" y1="16" x2="12" y2="16" />
                        </svg>
                      }
                    />
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                      <Field
                        id="reg-dest"
                        label="Destination Country"
                        value={dest}
                        onChange={setDest}
                        placeholder="Saudi Arabia"
                        icon={
                          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                            <circle cx="12" cy="12" r="10" />
                            <line x1="2" y1="12" x2="22" y2="12" />
                            <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                          </svg>
                        }
                      />
                      <Field
                        id="reg-job"
                        label="Job Title (optional)"
                        value={jobTitle}
                        onChange={setJobTitle}
                        placeholder="Domestic Worker"
                        icon={
                          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                            <rect x="2" y="7" width="20" height="14" rx="2" ry="2" />
                            <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                          </svg>
                        }
                      />
                    </div>
                    <Field
                      id="reg-exp"
                      label="Years of Experience (optional)"
                      type="number"
                      value={expYrs}
                      onChange={setExpYrs}
                      placeholder="0"
                      icon={
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                          <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
                        </svg>
                      }
                    />
                  </>
                ) : (
                  <>
                    <SLabel>Organization Details</SLabel>
                    <Field
                      id="reg-org"
                      label="Organization Name"
                      value={orgName}
                      onChange={setOrgName}
                      required
                      placeholder="e.g. OWWA, Philippine Embassy, Migrante International"
                      icon={
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                          <line x1="3" y1="22" x2="21" y2="22" />
                          <rect x="2" y="9" width="20" height="13" />
                          <path d="M12 2L2 9h20z" />
                        </svg>
                      }
                    />
                    <Field
                      id="reg-roletitle"
                      label="Your Role / Title"
                      value={roleTitle}
                      onChange={setRoleTitle}
                      required
                      placeholder="e.g. Labor Attache, Program Officer, Case Worker"
                      icon={
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                          <rect x="2" y="3" width="20" height="18" rx="2" ry="2" />
                          <line x1="8" y1="12" x2="16" y2="12" />
                          <line x1="8" y1="8" x2="16" y2="8" />
                          <line x1="8" y1="16" x2="12" y2="16" />
                        </svg>
                      }
                    />
                  </>
                )}
              </div>
            )}

            <button
              type="button"
              onClick={advance}
              disabled={isLoading}
              className="hidden lg:flex w-full mt-8 h-[52px] items-center justify-center rounded-xl text-white text-sm font-semibold shadow-lg shadow-[#003696]/25 hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#003696] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all"
              style={{ backgroundColor: "#003696" }}
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <svg className="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                  </svg>
                  Creating account…
                </span>
              ) : step < TOTAL - 1 ? (
                "Continue"
              ) : (
                "Create Account"
              )}
            </button>
              </div>
            </div>

            <div className="mt-6 text-center text-sm text-[#64748B]">
              Already have an account?{" "}
              <button
                type="button"
                onClick={() => navigate(ROUTES.LOGIN)}
                className="text-[#003696] font-semibold hover:text-[#002060]"
              >
                Login
              </button>
            </div>
          </div>
        </div>

        <div className="fixed bottom-0 left-0 right-0 border-t border-[#E2E8F0] bg-white lg:hidden">
          <div className="mx-auto w-full max-w-xl px-4 py-4">
            <button
              type="button"
              onClick={advance}
              disabled={isLoading}
              className="w-full h-[52px] rounded-xl text-white text-sm font-semibold shadow-lg shadow-[#003696]/25 hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#003696] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all"
              style={{ backgroundColor: "#003696" }}
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <svg className="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                  </svg>
                  Creating account…
                </span>
              ) : step < TOTAL - 1 ? (
                "Continue"
              ) : (
                "Create Account"
              )}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
