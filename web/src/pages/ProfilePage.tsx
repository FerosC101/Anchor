import { useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
import { ROUTES } from "../core/config/routes";
import { AppHeader } from "../components/layout/AppHeader";

export default function ProfilePage() {
  const navigate = useNavigate();
  const { signOut } = useAuth();

  const handleLogout = async () => {
    await signOut();
    navigate(ROUTES.LOGIN);
  };

  // Mock data for government officer
  const profileData = {
    fullName: "Maria Elena Rodriguez",
    title: "Embassy Officer",
    officerId: "EMB-PH-2024-0847",
    embassy: "Philippine Embassy, Abu Dhabi",
    department: "Labour Affairs Section",
    jurisdiction: "United Arab Emirates",
    email: "me.rodriguez@philembassy.ae",
  };

  return (
    <div className="min-h-screen bg-[#F6F6F8]">
      <AppHeader />

      {/* Main Content */}
      <main className="mx-auto w-full px-4 py-8 sm:px-6 lg:px-8">
        {/* Page Header */}
        <div className="mb-8">
          <h1 className="text-[28px] font-bold text-slate-900">Government Profile</h1>
          <p className="mt-1 text-[14px] text-slate-500">Manage your account details and preferences</p>
        </div>

        {/* Profile Card */}
        <div className="mb-8 rounded-2xl bg-gradient-to-r from-[#003696] to-[#0052CC] p-8 text-white shadow-lg w-full\">
          <div className="flex items-center gap-6">
            {/* Avatar */}
            <div className="flex h-[80px] w-[80px] shrink-0 items-center justify-center rounded-full bg-white/20 border-2 border-white">
              <svg width="44" height="44" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2">
                <path strokeLinecap="round" strokeLinejoin="round" d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2M12 3a4 4 0 1 0 0 8 4 4 0 0 0 0-8z" />
              </svg>
            </div>

            {/* User Info */}
            <div>
              <h2 className="text-[24px] font-bold">{profileData.fullName}</h2>
              <p className="mt-1 text-[14px] text-white/80">{profileData.title}</p>
              <p className="mt-0.5 text-[12px] text-white/70">Officer ID: {profileData.officerId}</p>
            </div>
          </div>
        </div>

        {/* Profile Information Section */}
        <div className="rounded-2xl bg-white p-8 shadow-sm border border-[#E5E7EB] w-full">
          <h3 className="mb-6 text-[18px] font-bold text-slate-900">Profile Information</h3>

          {/* Two Column Grid */}
          <div className="grid w-full grid-cols-1 sm:grid-cols-2 gap-6">
            {/* Full Name */}
            <div>
              <label className="mb-2 block text-[12px] font-bold text-slate-600 uppercase tracking-wide">Full Name</label>
              <input
                type="text"
                value={profileData.fullName}
                readOnly
                className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] text-slate-900 outline-none"
              />
            </div>

            {/* Embassy / Consulate */}
            <div>
              <label className="mb-2 block text-[12px] font-bold text-slate-600 uppercase tracking-wide">Embassy / Consulate</label>
              <input
                type="text"
                value={profileData.embassy}
                readOnly
                className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] text-slate-900 outline-none"
              />
            </div>

            {/* Officer ID */}
            <div>
              <label className="mb-2 block text-[12px] font-bold text-slate-600 uppercase tracking-wide">Officer ID</label>
              <input
                type="text"
                value={profileData.officerId}
                readOnly
                className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] text-slate-900 outline-none"
              />
            </div>

            {/* Department */}
            <div>
              <label className="mb-2 block text-[12px] font-bold text-slate-600 uppercase tracking-wide">Department</label>
              <input
                type="text"
                value={profileData.department}
                readOnly
                className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] text-slate-900 outline-none"
              />
            </div>

            {/* Assigned Jurisdiction */}
            <div>
              <label className="mb-2 block text-[12px] font-bold text-slate-600 uppercase tracking-wide">Assigned Jurisdiction</label>
              <input
                type="text"
                value={profileData.jurisdiction}
                readOnly
                className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] text-slate-900 outline-none"
              />
            </div>

            {/* Contact Email */}
            <div>
              <label className="mb-2 block text-[12px] font-bold text-slate-600 uppercase tracking-wide">Contact Email</label>
              <input
                type="email"
                value={profileData.email}
                readOnly
                className="w-full rounded-lg border border-[#E5E7EB] bg-[#F9FAFB] px-4 py-2.5 text-[13px] text-slate-900 outline-none"
              />
            </div>
          </div>

          {/* Action Buttons */}
          <div className="mt-8 flex gap-4">
            <button className="flex-1 h-[44px] rounded-lg bg-[#001F3F] text-[13px] font-bold text-white hover:bg-[#001a33] transition">
              Edit Profile
            </button>
            <button
              onClick={handleLogout}
              className="flex-1 h-[44px] rounded-lg bg-red-600 text-[13px] font-bold text-white hover:bg-red-700 transition"
            >
              Logout
            </button>
          </div>
        </div>
      </main>
    </div>
  );
}
