import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
import { ROUTES } from "../core/config/routes";

export default function LoginPage() {
  const navigate = useNavigate();
  const { signIn, error, clearError, isLoading } = useAuth();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    clearError();
    const success = await signIn(email.trim(), password);
    if (success) {
      navigate(ROUTES.HOME, { replace: true });
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-100 px-4">
      <div className="w-full max-w-md">
        <div className="bg-white rounded-2xl shadow-lg shadow-slate-200/50 p-8">
          <h1 className="text-2xl font-bold text-slate-800 text-center">
            Sign in to Anchor
          </h1>
          <p className="mt-1 text-slate-500 text-center text-sm">
            AI-powered protection for OFWs
          </p>

          <form onSubmit={handleSubmit} className="mt-8 space-y-5">
            {error && (
              <div
                role="alert"
                className="rounded-lg bg-red-50 text-red-700 text-sm px-4 py-3"
              >
                {error}
              </div>
            )}

            <div>
              <label
                htmlFor="login-email"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                Email
              </label>
              <input
                id="login-email"
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
                htmlFor="login-password"
                className="block text-sm font-medium text-slate-700 mb-1"
              >
                Password
              </label>
              <input
                id="login-password"
                type="password"
                autoComplete="current-password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full rounded-lg border border-slate-300 px-4 py-2.5 text-slate-800 placeholder-slate-400 focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20"
                placeholder="••••••••"
              />
            </div>

            <button
              type="submit"
              disabled={isLoading}
              className="w-full rounded-lg bg-blue-600 py-2.5 font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none"
            >
              {isLoading ? "Signing in…" : "Sign in"}
            </button>
          </form>

          <p className="mt-6 text-center text-sm text-slate-600">
            Don’t have an account?{" "}
            <Link
              to={ROUTES.REGISTER}
              className="font-medium text-blue-600 hover:text-blue-700"
            >
              Create one
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
