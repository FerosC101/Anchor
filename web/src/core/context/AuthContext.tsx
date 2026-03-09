import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useReducer,
  type ReactNode,
} from "react";
import { onIdTokenChanged } from "firebase/auth";
import { auth } from "../config/firebase";
import * as authService from "../services/auth.service";
import { getUserDocument } from "../services/user.service";
import type { UserModel } from "@/types";

// ─── Auth state (mirrors mobile AuthState) ────────────────────────────────────

export interface AuthState {
  user: UserModel | null;
  isLoading: boolean;
  error: string | null;
}

const initialState: AuthState = {
  user: null,
  isLoading: true,
  error: null,
};

type AuthAction =
  | { type: "SET_LOADING"; payload: boolean }
  | { type: "SET_USER"; payload: UserModel | null }
  | { type: "SET_ERROR"; payload: string | null }
  | { type: "CLEAR_ERROR" }
  | { type: "SIGN_OUT" };

function authReducer(state: AuthState, action: AuthAction): AuthState {
  switch (action.type) {
    case "SET_LOADING":
      return { ...state, isLoading: action.payload };
    case "SET_USER":
      return { ...state, user: action.payload, isLoading: false };
    case "SET_ERROR":
      return { ...state, error: action.payload, isLoading: false };
    case "CLEAR_ERROR":
      return { ...state, error: null };
    case "SIGN_OUT":
      return { ...initialState, isLoading: false };
    default:
      return state;
  }
}

// ─── Context value ───────────────────────────────────────────────────────────

type AuthContextValue = AuthState & {
  signIn: (email: string, password: string) => Promise<boolean>;
  register: (params: {
    email: string;
    password: string;
    fullName: string;
    role: import("@/types").UserRole;
    phoneNumber: string;
    country: string;
    roleData?: authService.RegisterRoleData;
  }) => Promise<boolean>;
  signOut: () => Promise<void>;
  clearError: () => void;
};

const AuthContext = createContext<AuthContextValue | null>(null);

// ─── Provider ─────────────────────────────────────────────────────────────────

export function AuthProvider({ children }: { children: ReactNode }) {
  const [state, dispatch] = useReducer(authReducer, initialState);

  // Sync with Firebase auth state: when user logs in elsewhere or on load, fetch UserModel
  useEffect(() => {
    const unsubscribe = onIdTokenChanged(auth, async (firebaseUser) => {
      if (!firebaseUser) {
        dispatch({ type: "SET_USER", payload: null });
        return;
      }
      // Only fetch user data if authenticated and user exists
      try {
        const userModel = await getUserDocument(firebaseUser.uid);
        if (!userModel) {
          dispatch({
            type: "SET_ERROR",
            payload: "Account data not found. Please contact support.",
          });
          return;
        }
        dispatch({ type: "SET_USER", payload: userModel });
      } catch (e) {
        // Handle permission-denied and other errors
        const errorMsg =
          e &&
          typeof e === "object" &&
          "code" in e &&
          e.code === "permission-denied"
            ? "You don't have permission to access your account data. Please contact support."
            : "Failed to load your account data. Please try again.";
        dispatch({
          type: "SET_ERROR",
          payload: errorMsg,
        });
      }
    });
    return () => unsubscribe();
  }, []);

  const signIn = useCallback(
    async (email: string, password: string): Promise<boolean> => {
      dispatch({ type: "SET_LOADING", payload: true });
      dispatch({ type: "CLEAR_ERROR" });
      try {
        const user = await authService.signIn(email, password);
        dispatch({ type: "SET_USER", payload: user });
        return true;
      } catch (e) {
        const message =
          e instanceof authService.AuthException
            ? e.message
            : "Sign in failed.";
        dispatch({ type: "SET_ERROR", payload: message });
        return false;
      }
    },
    [],
  );

  const register = useCallback(
    async (params: {
      email: string;
      password: string;
      fullName: string;
      role: import("@/types").UserRole;
      phoneNumber: string;
      country: string;
      roleData?: authService.RegisterRoleData;
    }): Promise<boolean> => {
      dispatch({ type: "SET_LOADING", payload: true });
      dispatch({ type: "CLEAR_ERROR" });
      try {
        const user = await authService.register(
          params.email,
          params.password,
          params.fullName,
          params.role,
          params.phoneNumber,
          params.country,
          params.roleData,
        );
        dispatch({ type: "SET_USER", payload: user });
        return true;
      } catch (e) {
        const message =
          e instanceof authService.AuthException
            ? e.message
            : "Registration failed.";
        dispatch({ type: "SET_ERROR", payload: message });
        return false;
      }
    },
    [],
  );

  const signOut = useCallback(async () => {
    await authService.signOut();
    dispatch({ type: "SIGN_OUT" });
  }, []);

  const clearError = useCallback(() => {
    dispatch({ type: "CLEAR_ERROR" });
  }, []);

  const value: AuthContextValue = {
    ...state,
    signIn,
    register,
    signOut,
    clearError,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth(): AuthContextValue {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth must be used within AuthProvider");
  return ctx;
}
