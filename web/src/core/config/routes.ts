import { USER_ROLE, type UserRole } from "../../types/user";

export const ROUTES = {
  LOGIN: "/login",
  REGISTER: "/register",
  HOME: "/home",
  DASHBOARD: "/dashboard",
  MONITORING: "/dashboard/monitoring",
  ALERT: "/dashboard/alert",
  PROFILE: "/dashboard/profile",
  NOTIFICATIONS: "/dashboard/notifications",
  PRIVACY: "/dashboard/privacy",
  ADMIN: "/admin",
  ADMIN_USERS: "/admin/users",
} as const;

export function getDefaultRouteForRole(role: UserRole): string {
  switch (role) {
    case USER_ROLE.ADMIN:
      return ROUTES.ADMIN;
    case USER_ROLE.VERIFIER:
      return ROUTES.DASHBOARD;
    default:
      return ROUTES.HOME;
  }
}
