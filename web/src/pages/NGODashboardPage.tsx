import NGODashboard from "../features/dashboard/NGODashboard";
import GovernmentDashboard from "../features/dashboard/GovernmentDashboard";
import { useAuth } from "../core/context/AuthContext";
import { USER_ROLE } from "../types/user";

export default function NGODashboardPage() {
  const { user } = useAuth();
  if (user?.role === USER_ROLE.AGENCY) {
    return <GovernmentDashboard />;
  }
  return <NGODashboard />;
}
