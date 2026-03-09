import { useAuth } from "../core/context/AuthContext";

export default function HomePage() {
  const { user, signOut } = useAuth();

  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-50">
      <div className="text-center space-y-4">
        <h1 className="text-2xl font-semibold text-slate-800">
          Welcome to Anchor
        </h1>

        <p className="text-slate-600">
          {user
            ? `Signed in as ${user.fullName || user.email}`
            : "You are signed in."}
        </p>

        <button
          onClick={signOut}
          className="mt-4 px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600 transition"
        >
          Sign Out
        </button>
      </div>
    </div>
  );
}
