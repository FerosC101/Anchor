import { Navigate, Route, Routes } from "react-router-dom";
import { ROUTES, getDefaultRouteForRole } from "./core/config/routes";
import { useAuth } from "./core/context/AuthContext";
import AdminDashboardPage from "./pages/AdminDashboardPage";
import AlertPage from "./pages/AlertPage";
import ContentsPageWrapper from "./pages/ContentsPage";
import HomePage from "./pages/HomePage";
import JobListsPageWrapper from "./pages/JobListsPage";
import LoginPage from "./pages/LoginPage";
import MonitoringPage from "./pages/MonitoringPage";
import NGODashboardPage from "./pages/NGODashboardPage";
import ProfilePage from "./pages/ProfilePage";
import RegisterPage from "./pages/RegisterPage";
import SystemPageWrapper from "./pages/SystemPage";
import UsersPageWrapper from "./pages/UsersPage";

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
    return <Navigate to={getDefaultRouteForRole(user.role)} replace />;
  }
  return <>{children}</>;
}

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<LoginPage />} />
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
      <Route
        path={ROUTES.DASHBOARD}
        element={
          <ProtectedRoute>
            <NGODashboardPage />
          </ProtectedRoute>
        }
      />
      <Route
        path={ROUTES.MONITORING}
        element={
          <ProtectedRoute>
            <MonitoringPage />
          </ProtectedRoute>
        }
      />
      <Route
        path={ROUTES.ALERT}
        element={
          <ProtectedRoute>
            <AlertPage />
          </ProtectedRoute>
        }
      />
      <Route
        path={ROUTES.PROFILE}
        element={
          <ProtectedRoute>
            <ProfilePage />
          </ProtectedRoute>
        }
      />
      <Route
        path={ROUTES.ADMIN}
        element={
          <ProtectedRoute>
            <AdminDashboardPage />
          </ProtectedRoute>
        }
      />
      <Route
        path={ROUTES.ADMIN_USERS}
        element={
          <ProtectedRoute>
            <UsersPageWrapper />
          </ProtectedRoute>
        }
      />
      <Route
        path={ROUTES.ADMIN_CONTENTS}
        element={
          <ProtectedRoute>
            <ContentsPageWrapper />
          </ProtectedRoute>
        }
      />
      <Route
        path={ROUTES.ADMIN_JOB_LISTS}
        element={
          <ProtectedRoute>
            <JobListsPageWrapper />
          </ProtectedRoute>
        }
      />
      <Route
        path={ROUTES.ADMIN_SYSTEM}
        element={
          <ProtectedRoute>
            <SystemPageWrapper />
          </ProtectedRoute>
        }
      />
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
