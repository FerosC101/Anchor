import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
import { ROUTES } from "../core/config/routes";
import { USER_ROLE, type UserRole } from "@/types";

const MIN_PASSWORD_LENGTH = 6;

export default function RegisterPage() {
  const navigate = useNavigate();
  const { register: registerUser, error, clearError, isLoading } = useAuth();
  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [country, setCountry] = useState("");
  const [role, setRole] = useState<string>(USER_ROLE.OFW);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    clearError();

    if (password.length < MIN_PASSWORD_LENGTH) {
      return;
    }
    if (password !== confirmPassword) {
      return;
    }

    const success = await registerUser({
      email: email.trim(),
      password,
      fullName: fullName.trim() || email.trim(),
      role: role as UserRole,
      phoneNumber: phoneNumber.trim(),
      country: country.trim(),
    });
    if (success) {
      navigate(ROUTES.HOME, { replace: true });
    }
  }

  const passwordsMatch = password === confirmPassword;
  const passwordValid = password.length >= MIN_PASSWORD_LENGTH;
  const showPasswordError =
    (password.length > 0 && !passwordValid) ||
    (confirmPassword.length > 0 && !passwordsMatch);

  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-100 px-4 py-12">
      <div className="w-full max-w-md">
        <div className="bg-white rounded-2xl shadow-lg shadow-slate-200/50 p-8">
          <h1 className="text-2xl font-bold text-slate-800 text-center">
            Create your account
          </h1>
          <p className="mt-1 text-slate-500 text-center text-sm">
            Join Anchor — protection for Overseas Filipino Workers
          </p>

          <form onSubmit={handleSubmit} className="mt-8 space-y-5">
            {(error || showPasswordError) && (
              <div
                role="alert"
                className="rounded-lg bg-red-50 text-red-700 text-sm px-4 py-3"
              >
                {error ||
                  (password.length > 0 && !passwordValid
                    ? `Password must be at least ${MIN_PASSWORD_LENGTH} characters.`
                    : confirmPassword.length > 0 && !passwordsMatch
                      ? "Passwords do not match."
                      : null)}
              </div>
            )}

            <div>
              <label
                htmlFor="register-name"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                Full name
              </label>
              <input
                id="register-name"
                type="text"
                autoComplete="name"
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
                className="w-full rounded-lg border border-slate-300 px-4 py-2.5 text-slate-800 placeholder-slate-400 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
                placeholder="Your name"
              />
            </div>

            <div>
              <label
                htmlFor="register-email"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                Email
              </label>
              <input
                id="register-email"
                type="email"
                autoComplete="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full rounded-lg border border-slate-300 px-4 py-2.5 text-slate-800 placeholder-slate-400 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
                placeholder="you@example.com"
              />
            </div>

            <div>
              <label
                htmlFor="register-role"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                I am a
              </label>
              <select
                id="register-role"
                value={role}
                onChange={(e) => setRole(e.target.value)}
                className="w-full rounded-lg border border-slate-300 px-4 py-2.5 text-slate-800 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
              >
                <option value={USER_ROLE.OFW}>OFW (Worker)</option>
                <option value={USER_ROLE.AGENCY}>Agency</option>
                <option value={USER_ROLE.VERIFIER}>Verifier</option>
              </select>
            </div>

            <div>
              <label
                htmlFor="register-phone"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                Phone number
              </label>
              <input
                id="register-phone"
                type="tel"
                autoComplete="tel"
                value={phoneNumber}
                onChange={(e) => setPhoneNumber(e.target.value)}
                className="w-full rounded-lg border border-slate-300 px-4 py-2.5 text-slate-800 placeholder-slate-400 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
                placeholder="+63..."
              />
            </div>

            <div>
              <label
                htmlFor="register-country"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                Country
              </label>
              <input
                id="register-country"
                type="text"
                autoComplete="country-name"
                value={country}
                onChange={(e) => setCountry(e.target.value)}
                className="w-full rounded-lg border border-slate-300 px-4 py-2.5 text-slate-800 placeholder-slate-400 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
                placeholder="e.g. Philippines"
              />
            </div>

            <div>
              <label
                htmlFor="register-password"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                Password
              </label>
              <input
                id="register-password"
                type="password"
                autoComplete="new-password"
                required
                minLength={MIN_PASSWORD_LENGTH}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full rounded-lg border border-slate-300 px-4 py-2.5 text-slate-800 placeholder-slate-400 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
                placeholder="At least 6 characters"
              />
              <p className="mt-1 text-xs text-slate-500">
                Minimum {MIN_PASSWORD_LENGTH} characters
              </p>
            </div>

            <div>
              <label
                htmlFor="register-confirm"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                Confirm password
              </label>
              <input
                id="register-confirm"
                type="password"
                autoComplete="new-password"
                required
                minLength={MIN_PASSWORD_LENGTH}
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                className="w-full rounded-lg border border-slate-300 px-4 py-2.5 text-slate-800 placeholder-slate-400 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
                placeholder="••••••••"
              />
            </div>

            <button
              type="submit"
              disabled={
                isLoading ||
                !passwordValid ||
                password !== confirmPassword
              }
              className="w-full rounded-lg bg-blue-600 py-2.5 font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none"
            >
              {isLoading ? "Creating account…" : "Create account"}
            </button>
          </form>

          <p className="mt-6 text-center text-sm text-slate-600">
            Already have an account?{" "}
            <Link
              to={ROUTES.LOGIN}
              className="font-medium text-blue-600 hover:text-blue-700"
            >
              Sign in
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
