import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../core/context/AuthContext";
                  }}
                >
                  <div
                    className="w-9 h-9 rounded-xl flex items-center justify-center shrink-0"
                    style={{ backgroundColor: (isOfw ? "#0EA5E9" : role === USER_ROLE.AGENCY ? "#8B5CF6" : "#10B981") + "22" }}
                  >
                    <svg
                      className="w-5 h-5"
                      style={{ color: isOfw ? "#0EA5E9" : role === USER_ROLE.AGENCY ? "#8B5CF6" : "#10B981" }}
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <circle cx="12" cy="12" r="10" />
                      <line x1="12" y1="8" x2="12" y2="12" />
                      <line x1="12" y1="16" x2="12.01" y2="16" />
                    </svg>
                  </div>
                  <div>
                    <p className="font-semibold text-sm text-[#0F172A]">
                      {isOfw ? "OFW Worker" : role === USER_ROLE.AGENCY ? "Government / Agency" : "NGO / Verifier"}
                    </p>
                    <p className="text-[#64748B] text-xs mt-0.5">
                      {isOfw
                        ? "This info helps protect your rights abroad. You can update it in your profile later."
                        : "You will have access to OFW support tools and case management features."}
                    </p>
                  </div>
                </div>

                {isOfw ? (
                  <>
                    <SLabel>Work Information</SLabel>
                    <Field
                      id="reg-passport"
                      label="Passport Number (optional)"
                      value={passport}
                      onChange={setPassport}
                      placeholder="A1234567"
                      icon={
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                          <rect x="2" y="3" width="20" height="18" rx="2" ry="2" />
                          <line x1="8" y1="12" x2="16" y2="12" />
                          <line x1="8" y1="8" x2="16" y2="8" />
                          <line x1="8" y1="16" x2="12" y2="16" />
                        </svg>
                      }
                    />
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                      <Field
                        id="reg-dest"
                        label="Destination Country"
                        value={dest}
                        onChange={setDest}
                        placeholder="Saudi Arabia"
                        icon={
                          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                            <circle cx="12" cy="12" r="10" />
                            <line x1="2" y1="12" x2="22" y2="12" />
                            <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                          </svg>
                        }
                      />
                      <Field
                        id="reg-job"
                        label="Job Title (optional)"
                        value={jobTitle}
                        onChange={setJobTitle}
                        placeholder="Domestic Worker"
                        icon={
                          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                            <rect x="2" y="7" width="20" height="14" rx="2" ry="2" />
                            <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                          </svg>
                        }
                      />
                    </div>
                    <Field
                      id="reg-exp"
                      label="Years of Experience (optional)"
                      type="number"
                      value={expYrs}
                      onChange={setExpYrs}
                      placeholder="0"
                      icon={
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                          <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
                        </svg>
                      }
                    />
                  </>
                ) : (
                  <>
                    <SLabel>Organization Details</SLabel>
                    <Field
                      id="reg-org"
                      label="Organization Name"
                      value={orgName}
                      onChange={setOrgName}
                      required
                      placeholder="e.g. OWWA, Philippine Embassy, Migrante International"
                      icon={
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                          <line x1="3" y1="22" x2="21" y2="22" />
                          <rect x="2" y="9" width="20" height="13" />
                          <path d="M12 2L2 9h20z" />
                        </svg>
                      }
                    />
                    <Field
                      id="reg-roletitle"
                      label="Your Role / Title"
                      value={roleTitle}
                      onChange={setRoleTitle}
                      required
                      placeholder="e.g. Labor Attache, Program Officer, Case Worker"
                      icon={
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} className="w-4 h-4">
                          <rect x="2" y="3" width="20" height="18" rx="2" ry="2" />
                          <line x1="8" y1="12" x2="16" y2="12" />
                          <line x1="8" y1="8" x2="16" y2="8" />
                          <line x1="8" y1="16" x2="12" y2="16" />
                        </svg>
                      }
                    />
                  </>
                )}
              </div>
            )}

            <button
              type="button"
              onClick={advance}
              disabled={isLoading}
              className="hidden lg:flex w-full mt-8 h-[52px] items-center justify-center rounded-xl text-white text-sm font-semibold shadow-lg shadow-[#003696]/25 hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#003696] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all"
              style={{ backgroundColor: "#003696" }}
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <svg className="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                  </svg>
                  Creating account…
                </span>
              ) : step < TOTAL - 1 ? (
                "Continue"
              ) : (
                "Create Account"
              )}
            </button>
          </div>
        </div>

        <div className="fixed bottom-0 left-0 right-0 border-t border-[#E2E8F0] bg-white lg:hidden">
          <div className="mx-auto w-full max-w-xl px-4 py-4">
            <button
              type="button"
              onClick={advance}
              disabled={isLoading}
              className="w-full h-[52px] rounded-xl text-white text-sm font-semibold shadow-lg shadow-[#003696]/25 hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#003696] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all"
              style={{ backgroundColor: "#003696" }}
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <svg className="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                  </svg>
                  Creating account…
                </span>
              ) : step < TOTAL - 1 ? (
                "Continue"
              ) : (
                "Create Account"
              )}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
                  <Field
                    id="reg-country"
                    label="Current Country"
                    value={country}
                    onChange={setCountry}
                    placeholder="Philippines"
                    autoComplete="country-name"
                    icon={
                      <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth={2}
                        className="w-4 h-4"
                      >
                        <circle cx="12" cy="12" r="10" />
                        <line x1="2" y1="12" x2="22" y2="12" />
                        <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                      </svg>
                    }
                  />
                </div>

                <SLabel>Security</SLabel>

                <Field
                  id="reg-pw"
                  label="Password"
                  type={showPw ? "text" : "password"}
                  value={password}
                  onChange={setPassword}
                  placeholder="At least 6 characters"
                  required
                  autoComplete="new-password"
                  minLength={MIN_PW}
                  hint={`Minimum ${MIN_PW} characters`}
                  error={
                    password.length > 0 && !pwOk
                      ? `Must be at least ${MIN_PW} characters`
                      : undefined
                  }
                  icon={
                    <svg
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth={2}
                      className="w-4 h-4"
                    >
                      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                  }
                  right={
                    <button
                      type="button"
                      onClick={() => setShowPw((v) => !v)}
                      className="text-[#94A3B8] hover:text-[#64748B] transition"
                      aria-label="Toggle"
                    >
                      {showPw ? (
                        <EyeOffIcon className="w-4 h-4" />
                      ) : (
                        <EyeIcon className="w-4 h-4" />
                      )}
                    </button>
                  }
                />

                <Field
                  id="reg-cf"
                  label="Confirm Password"
                  type={showCf ? "text" : "password"}
                  value={confirm}
                  onChange={setConfirm}
                  placeholder="Repeat your password"
                  required
                  autoComplete="new-password"
                  error={
                    confirm.length > 0 && !pwMatch
                      ? "Passwords do not match"
                      : undefined
                  }
                  icon={
                    <svg
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth={2}
                      className="w-4 h-4"
                    >
                      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                  }
                  right={
                    <button
                      type="button"
                      onClick={() => setShowCf((v) => !v)}
                      className="text-[#94A3B8] hover:text-[#64748B] transition"
                      aria-label="Toggle"
                    >
                      {showCf ? (
                        <EyeOffIcon className="w-4 h-4" />
                      ) : (
                        <EyeIcon className="w-4 h-4" />
                      )}
                    </button>
                  }
                />
              </div>
            )}

            {/* ── STEP 2: Role ─────────────────────────────────────────── */}
            {step === 1 && (
              <div className="space-y-4">
                <p className="text-[#64748B] text-sm mb-1">
                  Select the role that best describes you.
                </p>

                <RoleCard
                  value={USER_ROLE.OFW}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.OFW)}
                  color="#0EA5E9"
                  label="OFW Worker"
                  desc="I am an Overseas Filipino Worker seeking contract protection and employment support."
                  icon={
                    <svg
                      className="w-5 h-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <circle cx="12" cy="12" r="10" />
                      <polyline points="12 6 12 12 16 14" />
                    </svg>
                  }
                />

                <RoleCard
                  value={USER_ROLE.AGENCY}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.AGENCY)}
                  color="#8B5CF6"
                  label="Government / Agency"
                  desc="I work for a government agency, embassy, or consulate supporting and protecting OFWs."
                  icon={
                    <svg
                      className="w-5 h-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <rect x="2" y="7" width="20" height="14" rx="2" ry="2" />
                      <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                    </svg>
                  }
                />

                <RoleCard
                  value={USER_ROLE.VERIFIER}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.VERIFIER)}
                  color="#10B981"
                  label="NGO / Verifier"
                  desc="I represent a non-governmental organization providing assistance and advocacy for OFWs."
                  icon={
                    <svg
                      className="w-5 h-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                    </svg>
                  }
                />
              </div>
            )}

            {/* ── STEP 3: Role details ─────────────────────────────────── */}
            {step === 2 && (
              <div className="space-y-5">
                {/* Role banner */}
                <div
                  className="rounded-2xl border p-4 flex items-start gap-3"
                  style={{
                    backgroundColor:
                      (isOfw
                        ? "#0EA5E9"
                        : role === USER_ROLE.AGENCY
                          ? "#8B5CF6"
                          : "#10B981") + "11",
                    borderColor:
                      (isOfw
                        ? "#0EA5E9"
                        : role === USER_ROLE.AGENCY
                          ? "#8B5CF6"
                          : "#10B981") + "44",
                  }}
                >
                  <div
                    className="w-9 h-9 rounded-xl flex items-center justify-center shrink-0"
                    style={{
                      backgroundColor:
                        (isOfw
                          ? "#0EA5E9"
                          : role === USER_ROLE.AGENCY
                            ? "#8B5CF6"
                            : "#10B981") + "22",
                    }}
                  >
                    <svg
                      className="w-5 h-5"
                      style={{
                        color: isOfw
                          ? "#0EA5E9"
                          : role === USER_ROLE.AGENCY
                            ? "#8B5CF6"
                            : "#10B981",
                      }}
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <circle cx="12" cy="12" r="10" />
                      <line x1="12" y1="8" x2="12" y2="12" />
                      <line x1="12" y1="16" x2="12.01" y2="16" />
                    </svg>
                  </div>
                  <div>
                    <p className="font-semibold text-sm text-[#0F172A]">
                      {isOfw
                        ? "OFW Worker"
                        : role === USER_ROLE.AGENCY
                          ? "Government / Agency"
                          : "NGO / Verifier"}
                    </p>
                    <p className="text-[#64748B] text-xs mt-0.5">
                      {isOfw
                        ? "This info helps protect your rights abroad. You can update it in your profile later."
                        : "You will have access to OFW support tools and case management features."}
                    </p>
                  </div>
                </div>

                {isOfw ? (
                  <>
                    <SLabel>Work Information</SLabel>
                    <Field
                      id="reg-passport"
                      label="Passport Number (optional)"
                      value={passport}
                      onChange={setPassport}
                      placeholder="A1234567"
                      icon={
                        <svg
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth={2}
                          className="w-4 h-4"
                        >
                          <rect
                            x="2"
                            y="3"
                            width="20"
                            height="18"
                            rx="2"
                            ry="2"
                          />
                          <line x1="8" y1="12" x2="16" y2="12" />
                          <line x1="8" y1="8" x2="16" y2="8" />
                          <line x1="8" y1="16" x2="12" y2="16" />
                        </svg>
                      }
                    />
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                      <Field
                        id="reg-dest"
                        label="Destination Country"
                        value={dest}
                        onChange={setDest}
                        placeholder="Saudi Arabia"
                        icon={
                          <svg
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            strokeWidth={2}
                            className="w-4 h-4"
                          >
                            <circle cx="12" cy="12" r="10" />
                            <line x1="2" y1="12" x2="22" y2="12" />
                            <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                          </svg>
                        }
                      />
                      <Field
                        id="reg-job"
                        label="Job Title (optional)"
                        value={jobTitle}
                        onChange={setJobTitle}
                        placeholder="Domestic Worker"
                        icon={
                          <svg
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            strokeWidth={2}
                            className="w-4 h-4"
                          >
                            <rect
                              x="2"
                              y="7"
                              width="20"
                              height="14"
                              rx="2"
                              ry="2"
                            />
                            <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                          </svg>
                        }
                      />
                    </div>
                    <Field
                      id="reg-exp"
                      label="Years of Experience (optional)"
                      type="number"
                      value={expYrs}
                      onChange={setExpYrs}
                      placeholder="0"
                      icon={
                        <svg
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth={2}
                          className="w-4 h-4"
                        >
                          <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
                        </svg>
                      }
                    />
                  </>
                ) : (
                  <>
                    <SLabel>Organization Details</SLabel>
                    <Field
                      id="reg-org"
                      label="Organization Name"
                      value={orgName}
                      onChange={setOrgName}
                      required
                      placeholder="e.g. OWWA, Philippine Embassy, Migrante International"
                      icon={
                        <svg
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth={2}
                          className="w-4 h-4"
                        >
                          <line x1="3" y1="22" x2="21" y2="22" />
                          <rect x="2" y="9" width="20" height="13" />
                          <path d="M12 2L2 9h20z" />
                        </svg>
                      }
                    />
                    <Field
                      id="reg-roletitle"
                      label="Your Role / Title"
                      value={roleTitle}
                      onChange={setRoleTitle}
                      required
                      placeholder="e.g. Labor Attache, Program Officer, Case Worker"
                      icon={
                        <svg
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth={2}
                          className="w-4 h-4"
                        >
                          <rect
                            x="2"
                            y="3"
                            width="20"
                            height="18"
                            rx="2"
                            ry="2"
                          />
                          <line x1="8" y1="12" x2="16" y2="12" />
                          <line x1="8" y1="8" x2="16" y2="8" />
                          <line x1="8" y1="16" x2="12" y2="16" />
                        </svg>
                      }
                    />
                  </>
                )}
              </div>
            )}

            <button
              type="button"
              onClick={advance}
              disabled={isLoading}
              className="hidden lg:flex w-full mt-8 h-[52px] items-center justify-center rounded-xl text-white text-sm font-semibold shadow-lg shadow-[#003696]/25 hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#003696] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all"
              style={{ backgroundColor: "#003696" }}
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <svg
                    className="animate-spin h-4 w-4"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      className="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      strokeWidth="4"
                    />
                    <path
                      className="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8v8z"
                    />
                  </svg>
                  Creating account…
                </span>
              ) : step < TOTAL - 1 ? (
                "Continue"
              ) : (
                "Create Account"
              )}
            </button>
          </div>
            {/* ── STEP 2: Role ─────────────────────────────────────────── */}
            {step === 1 && (
              <div className="space-y-4">
                <p className="text-[#64748B] text-sm mb-1">
                  Select the role that best describes you.
                </p>

                <RoleCard
                  value={USER_ROLE.OFW}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.OFW)}
                  color="#0EA5E9"
                  label="OFW Worker"
                  desc="I am an Overseas Filipino Worker seeking contract protection and employment support."
                  icon={
                    <svg
                      className="w-5 h-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <circle cx="12" cy="12" r="10" />
                      <polyline points="12 6 12 12 16 14" />
                    </svg>
                  }
                />

                <RoleCard
                  value={USER_ROLE.AGENCY}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.AGENCY)}
                  color="#8B5CF6"
                  label="Government / Agency"
                  desc="I work for a government agency, embassy, or consulate supporting and protecting OFWs."
                  icon={
                    <svg
                      className="w-5 h-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <rect x="2" y="7" width="20" height="14" rx="2" ry="2" />
                      <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                    </svg>
                  }
                />

                <RoleCard
                  value={USER_ROLE.VERIFIER}
                  current={role}
                  onSelect={() => setRole(USER_ROLE.VERIFIER)}
                  color="#10B981"
                  label="NGO / Verifier"
                  desc="I represent a non-governmental organization providing assistance and advocacy for OFWs."
                  icon={
                    <svg
                      className="w-5 h-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                    </svg>
                  }
                />
              </div>
            )}

            {/* ── STEP 3: Role details ─────────────────────────────────── */}
            {step === 2 && (
              <div className="space-y-5">
                {/* Role banner */}
                <div
                  className="rounded-2xl border p-4 flex items-start gap-3"
                  style={{
                    backgroundColor:
                      (isOfw
                        ? "#0EA5E9"
                        : role === USER_ROLE.AGENCY
                          ? "#8B5CF6"
                          : "#10B981") + "11",
                    borderColor:
                      (isOfw
                        ? "#0EA5E9"
                        : role === USER_ROLE.AGENCY
                          ? "#8B5CF6"
                          : "#10B981") + "44",
                  }}
                >
                  <div
                    className="w-9 h-9 rounded-xl flex items-center justify-center shrink-0"
                    style={{
                      backgroundColor:
                        (isOfw
                          ? "#0EA5E9"
                          : role === USER_ROLE.AGENCY
                            ? "#8B5CF6"
                            : "#10B981") + "22",
                    }}
                  >
                    <svg
                      className="w-5 h-5"
                      style={{
                        color: isOfw
                          ? "#0EA5E9"
                          : role === USER_ROLE.AGENCY
                            ? "#8B5CF6"
                            : "#10B981",
                      }}
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <circle cx="12" cy="12" r="10" />
                      <line x1="12" y1="8" x2="12" y2="12" />
                      <line x1="12" y1="16" x2="12.01" y2="16" />
                    </svg>
                  </div>
                  <div>
                    <p className="font-semibold text-sm text-[#0F172A]">
                      {isOfw
                        ? "OFW Worker"
                        : role === USER_ROLE.AGENCY
                          ? "Government / Agency"
                          : "NGO / Verifier"}
                    </p>
                    <p className="text-[#64748B] text-xs mt-0.5">
                      {isOfw
                        ? "This info helps protect your rights abroad. You can update it in your profile later."
                        : "You will have access to OFW support tools and case management features."}
                    </p>
                  </div>
                </div>

                {isOfw ? (
                  <>
                    <SLabel>Work Information</SLabel>
                    <Field
                      id="reg-passport"
                      label="Passport Number (optional)"
                      value={passport}
                      onChange={setPassport}
                      placeholder="A1234567"
                      icon={
                        <svg
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth={2}
                          className="w-4 h-4"
                        >
                          <rect
                            x="2"
                            y="3"
                            width="20"
                            height="18"
                            rx="2"
                            ry="2"
                          />
                          <line x1="8" y1="12" x2="16" y2="12" />
                          <line x1="8" y1="8" x2="16" y2="8" />
                          <line x1="8" y1="16" x2="12" y2="16" />
                        </svg>
                      }
                    />
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                      <Field
                        id="reg-dest"
                        label="Destination Country"
                        value={dest}
                        onChange={setDest}
                        placeholder="Saudi Arabia"
                        icon={
                          <svg
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            strokeWidth={2}
                            className="w-4 h-4"
                          >
                            <circle cx="12" cy="12" r="10" />
                            <line x1="2" y1="12" x2="22" y2="12" />
                            <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                          </svg>
                        }
                      />
                      <Field
                        id="reg-job"
                        label="Job Title (optional)"
                        value={jobTitle}
                        onChange={setJobTitle}
                        placeholder="Domestic Worker"
                        icon={
                          <svg
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            strokeWidth={2}
                            className="w-4 h-4"
                          >
                            <rect
                              x="2"
                              y="7"
                              width="20"
                              height="14"
                              rx="2"
                              ry="2"
                            />
                            <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                          </svg>
                        }
                      />
                    </div>
                    <Field
                      id="reg-exp"
                      label="Years of Experience (optional)"
                      type="number"
                      value={expYrs}
                      onChange={setExpYrs}
                      placeholder="0"
                      icon={
                        <svg
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth={2}
                          className="w-4 h-4"
                        >
                          <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
                        </svg>
                      }
                    />
                  </>
                ) : (
                  <>
                    <SLabel>Organization Details</SLabel>
                    <Field
                      id="reg-org"
                      label="Organization Name"
                      value={orgName}
                      onChange={setOrgName}
                      required
                      placeholder="e.g. OWWA, Philippine Embassy, Migrante International"
                      icon={
                        <svg
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth={2}
                          className="w-4 h-4"
                        >
                          <line x1="3" y1="22" x2="21" y2="22" />
                          <rect x="2" y="9" width="20" height="13" />
                          <path d="M12 2L2 9h20z" />
                        </svg>
                      }
                    />
                    <Field
                      id="reg-roletitle"
                      label="Your Role / Title"
                      value={roleTitle}
                      onChange={setRoleTitle}
                      required
                      placeholder="e.g. Labor Attache, Program Officer, Case Worker"
                      icon={
                        <svg
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth={2}
                          className="w-4 h-4"
                        >
                          <rect
                            x="2"
                            y="3"
                            width="20"
                            height="18"
                            rx="2"
                            ry="2"
                          />
                          <line x1="8" y1="12" x2="16" y2="12" />
                          <line x1="8" y1="8" x2="16" y2="8" />
                          <line x1="8" y1="16" x2="12" y2="16" />
                        </svg>
                      }
                    />
                  </>
                )}
              </div>
            )}

          </div>
        </div>

        <div className="fixed bottom-0 left-0 right-0 border-t border-[#E2E8F0] bg-white">
          <div className="mx-auto w-full max-w-xl px-4 py-4">
            <button
              type="button"
              onClick={advance}
              disabled={isLoading}
              className="w-full h-[52px] rounded-xl text-white text-sm font-semibold shadow-lg shadow-[#003696]/25 hover:opacity-90 active:scale-[0.99] focus:outline-none focus:ring-2 focus:ring-[#003696] focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none transition-all"
              style={{ backgroundColor: "#003696" }}
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <svg
                    className="animate-spin h-4 w-4"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      className="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      strokeWidth="4"
                    />
                    <path
                      className="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8v8z"
                    />
                  </svg>
                  Creating account…
                </span>
              ) : step < TOTAL - 1 ? (
                "Continue"
              ) : (
                "Create Account"
              )}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
