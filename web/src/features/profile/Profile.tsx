import { NgoLayout } from "../../components/layout/NgoLayout";
import { NgoColors } from "../../core/theme/ngo-colors";


interface ProfileUser {
  name: string;
  email: string;
  role: string;
  phone: string;
  dateOfBirth: string;
  contracts: number;
  wageLogs: number;
  reports: number;
}

const PROFILE_DATA: ProfileUser = {
  name: "Guest User",
  email: "migrant@gmail.com",
  role: "Migrant Worker",
  phone: "+63 912 345 6789",
  dateOfBirth: "January 15, 1990",
  contracts: 5,
  wageLogs: 12,
  reports: 4,
};

export function Profile() {
  const navigate = useNavigate();
  const { unreadCount } = useNotifications();
  return (
    <NgoLayout>
      {/* Profile Header */}
      <div style={{ backgroundColor: NgoColors.blueLight }} className="px-4 sm:px-6 lg:px-8 py-8">
        <div className="mx-auto max-w-2xl text-center">
          <div className="flex justify-center mb-4">
            <div className="flex h-20 w-20 items-center justify-center rounded-full border-4 border-white/30 bg-white/20 backdrop-blur">
              <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke={NgoColors.navy} strokeWidth="1.5">
                <path strokeLinecap="round" strokeLinejoin="round" d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8z" />
              </svg>
            </div>
          </div>
          <h1 className="text-[28px] font-extrabold text-slate-900 tracking-[-0.01em]">{PROFILE_DATA.name}</h1>
          <p className="mt-2 text-[14px] text-slate-600">{PROFILE_DATA.email}</p>
          <p className="mt-1 text-[12px] font-semibold" style={{ color: NgoColors.navy }}>{PROFILE_DATA.role}</p>

          <button 
            className="mt-6 rounded-full border-2 px-6 py-2.5 text-[13px] font-semibold transition hover:bg-white/30"
            style={{ borderColor: NgoColors.navy, color: NgoColors.navy }}
          >
            ✎ Edit Profile
          </button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="mx-auto max-w-2xl px-4 sm:px-6 lg:px-8 py-6">
        <div className="grid grid-cols-3 gap-4">
          <div
            className="rounded-[16px] p-6 text-center"
            style={{ backgroundColor: NgoColors.blueLight }}
          >
            <p className="text-[26px] font-extrabold text-slate-900">{PROFILE_DATA.contracts}</p>
            <p className="mt-2 text-[12px] font-semibold text-slate-600">Contracts</p>
          </div>
          <div
            className="rounded-[16px] p-6 text-center"
            style={{ backgroundColor: NgoColors.blueLight }}
          >
            <p className="text-[26px] font-extrabold text-slate-900">{PROFILE_DATA.wageLogs}</p>
            <p className="mt-2 text-[12px] font-semibold text-slate-600">Wage Logs</p>
          </div>
          <div
            className="rounded-[16px] p-6 text-center"
            style={{ backgroundColor: NgoColors.blueLight }}
          >
            <p className="text-[26px] font-extrabold text-slate-900">{PROFILE_DATA.reports}</p>
            <p className="mt-2 text-[12px] font-semibold text-slate-600">Reports</p>
          </div>
        </div>
      </div>

      {/* Personal Information */}
      <div className="mx-auto max-w-2xl px-4 sm:px-6 lg:px-8 py-6">
        <h2 className="text-[16px] font-extrabold text-slate-900 mb-4">Personal Information</h2>

        <div className="space-y-4">
          {/* Full Name */}
          <div className="rounded-[14px] border border-[#E5E7EB] bg-white p-4">
            <div className="flex items-start gap-4">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-blue-100">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={NgoColors.navy} strokeWidth="1.5">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8z" />
                </svg>
              </div>
              <div>
                <p className="text-[12px] font-semibold text-slate-500">Full Name</p>
                <p className="mt-1 text-[14px] font-semibold text-slate-900">{PROFILE_DATA.name}</p>
              </div>
            </div>
          </div>

          {/* Email */}
          <div className="rounded-[14px] border border-[#E5E7EB] bg-white p-4">
            <div className="flex items-start gap-4">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-blue-100">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={NgoColors.navy} strokeWidth="1.5">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
              </div>
              <div>
                <p className="text-[12px] font-semibold text-slate-500">Email</p>
                <p className="mt-1 text-[14px] font-semibold text-slate-900">{PROFILE_DATA.email}</p>
              </div>
            </div>
          </div>

          {/* Phone */}
          <div className="rounded-[14px] border border-[#E5E7EB] bg-white p-4">
            <div className="flex items-start gap-4">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-blue-100">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={NgoColors.navy} strokeWidth="1.5">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                </svg>
              </div>
              <div>
                <p className="text-[12px] font-semibold text-slate-500">Phone Number</p>
                <p className="mt-1 text-[14px] font-semibold text-slate-900">{PROFILE_DATA.phone}</p>
              </div>
            </div>
          </div>

          {/* Date of Birth */}
          <div className="rounded-[14px] border border-[#E5E7EB] bg-white p-4">
            <div className="flex items-start gap-4">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-blue-100">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={NgoColors.navy} strokeWidth="1.5">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                </svg>
              </div>
              <div>
                <p className="text-[12px] font-semibold text-slate-500">Date of Birth</p>
                <p className="mt-1 text-[14px] font-semibold text-slate-900">{PROFILE_DATA.dateOfBirth}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Action Buttons */}
      <div className="mx-auto max-w-2xl px-4 sm:px-6 lg:px-8 py-6 space-y-3">
        <button
          className="w-full rounded-lg py-3 text-[14px] font-semibold text-white hover:opacity-90 transition"
          style={{ backgroundColor: NgoColors.navy }}
        >
          Save Changes
        </button>
        <button className="w-full rounded-lg border-2 py-3 text-[14px] font-semibold text-slate-600 hover:bg-slate-50 transition" style={{ borderColor: "#E5E7EB" }}>
          Cancel
        </button>
      </div>
    </NgoLayout>
  );
}
