import { Routes, Route, Navigate } from "react-router-dom";
import { useAuth } from "./core/context/AuthContext";
import { ROUTES } from "./core/config/routes";
import LoginPage from "./pages/LoginPage";
import RegisterPage from "./pages/RegisterPage";
import HomePage from "./pages/HomePage";

function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { user, isLoading } = useAuth();
  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-slate-50">
        <p className="text-slate-600">Loading…</p>
      </div>
    );
  }
  if (!user) {
    return <Navigate to={ROUTES.LOGIN} replace />;
  }
  return <>{children}</>;
}

function PublicRoute({ children }: { children: React.ReactNode }) {
  const { user, isLoading } = useAuth();
  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-slate-50">
        <p className="text-slate-600">Loading…</p>
      </div>
    );
  }
  if (user) {
    return <Navigate to={ROUTES.HOME} replace />;
  }
  return <>{children}</>;
}

export default function App() {
  return (
    <Routes>
      <Route
        path={ROUTES.LOGIN}
        element={
          <PublicRoute>
            <LoginPage />
          </PublicRoute>
        }
      />
      <Route
        path={ROUTES.REGISTER}
        element={
          <PublicRoute>
            <RegisterPage />
          </PublicRoute>
        }
      />
      <Route
        path={ROUTES.HOME}
        element={
          <ProtectedRoute>
            <HomePage />
          </ProtectedRoute>
        }
      />
      <Route path="*" element={<Navigate to={ROUTES.HOME} replace />} />
    </Routes>
  );
}
