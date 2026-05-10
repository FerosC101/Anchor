import { useMemo, useState } from "react";
import { WorkerLayout } from "../components/layout/WorkerLayout";

interface ShieldProfile {
  savings: number;
  debt: number;
  monthlyRemittance: number;
  emergencyFundMonths: number;
}

const DEFAULT_PROFILE: ShieldProfile = {
  savings: 2450,
  debt: 980,
  monthlyRemittance: 420,
  emergencyFundMonths: 2,
};

const EXIT_STEPS = [
  { title: "Emergency contacts saved", done: true },
  { title: "3 months savings ready", done: false },
  { title: "Passport copy stored", done: true },
  { title: "Safe housing identified", done: false },
];

export default function ShieldPage() {
  const [profile] = useState(DEFAULT_PROFILE);
  const [showSimulator, setShowSimulator] = useState(false);
  const [simulator, setSimulator] = useState({
    monthlyCost: "650",
    months: "3",
    savings: profile.savings.toString(),
  });

  const progress = useMemo(() => {
    const completed = EXIT_STEPS.filter((step) => step.done).length;
    return Math.round((completed / EXIT_STEPS.length) * 100);
  }, []);

  const required =
    Number(simulator.monthlyCost || 0) * Number(simulator.months || 0);
  const gap = required - Number(simulator.savings || 0);

  return (
    <WorkerLayout>
      <main className="mx-auto w-full max-w-6xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="flex flex-col gap-6">
          <div>
            <p className="text-[12px] font-semibold uppercase tracking-[0.2em] text-slate-400">Financial Shield</p>
            <h1 className="mt-2 text-[26px] font-extrabold text-slate-900">Plan your safety net</h1>
            <p className="text-[14px] text-slate-600">Monitor savings, debt, and your exit readiness.</p>
          </div>

          <section className="grid gap-4 md:grid-cols-4">
            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">Savings</p>
              <p className="mt-3 text-[22px] font-extrabold text-slate-900">${profile.savings.toLocaleString()}</p>
            </div>
            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">Debt</p>
              <p className="mt-3 text-[22px] font-extrabold text-[#8E0012]">${profile.debt.toLocaleString()}</p>
            </div>
            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">Remittance</p>
              <p className="mt-3 text-[22px] font-extrabold text-slate-900">${profile.monthlyRemittance}/mo</p>
            </div>
            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">Emergency Fund</p>
              <p className="mt-3 text-[22px] font-extrabold text-slate-900">{profile.emergencyFundMonths} months</p>
            </div>
          </section>

          <section className="grid gap-6 lg:grid-cols-[1fr_1fr]">
            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-[14px] font-semibold text-slate-900">Exit Readiness</p>
                  <p className="text-[12px] text-slate-500">{progress}% completed</p>
                </div>
                <button
                  onClick={() => setShowSimulator(true)}
                  className="rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white"
                >
                  Run Simulator
                </button>
              </div>

              <div className="mt-4">
                <div className="h-2 w-full rounded-full bg-slate-100">
                  <div
                    className="h-2 rounded-full bg-[#003696]"
                    style={{ width: `${progress}%` }}
                  />
                </div>
                <div className="mt-4 grid gap-3">
                  {EXIT_STEPS.map((step) => (
                    <div key={step.title} className="flex items-center justify-between rounded-2xl bg-slate-50/70 px-4 py-3">
                      <p className="text-[12px] font-semibold text-slate-700">{step.title}</p>
                      <span
                        className={`rounded-full px-3 py-1 text-[11px] font-semibold ${
                          step.done ? "bg-emerald-50 text-[#00AA28]" : "bg-amber-50 text-[#AD4B00]"
                        }`}
                      >
                        {step.done ? "Completed" : "Pending"}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <p className="text-[14px] font-semibold text-slate-900">Safety Checklist</p>
              <p className="mt-1 text-[12px] text-slate-500">Key reminders before travel or contract changes</p>
              <ul className="mt-4 list-disc space-y-2 pl-5 text-[12px] text-slate-600">
                <li>Keep digital copies of passport, visa, and contract.</li>
                <li>Share your location and employer details with family.</li>
                <li>Know your nearest embassy and labor attaché contacts.</li>
                <li>Track wage payments monthly and report delays early.</li>
              </ul>
            </div>
          </section>
        </div>
      </main>

      {showSimulator ? (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/30 px-4">
          <div className="w-full max-w-lg rounded-3xl bg-white p-6 shadow-lg">
            <div className="flex items-center justify-between">
              <p className="text-[16px] font-semibold text-slate-900">Emergency Exit Simulator</p>
              <button onClick={() => setShowSimulator(false)} className="rounded-full p-2 text-slate-400 hover:bg-slate-100">✕</button>
            </div>

            <div className="mt-4 grid gap-3">
              <label className="text-[12px] font-semibold text-slate-600">
                Monthly living cost
                <input
                  type="number"
                  value={simulator.monthlyCost}
                  onChange={(e) => setSimulator((prev) => ({ ...prev, monthlyCost: e.target.value }))}
                  className="mt-2 w-full rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
                />
              </label>
              <label className="text-[12px] font-semibold text-slate-600">
                Months to cover
                <input
                  type="number"
                  value={simulator.months}
                  onChange={(e) => setSimulator((prev) => ({ ...prev, months: e.target.value }))}
                  className="mt-2 w-full rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
                />
              </label>
              <label className="text-[12px] font-semibold text-slate-600">
                Current savings
                <input
                  type="number"
                  value={simulator.savings}
                  onChange={(e) => setSimulator((prev) => ({ ...prev, savings: e.target.value }))}
                  className="mt-2 w-full rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
                />
              </label>
            </div>

            <div className="mt-6 rounded-2xl bg-slate-50 px-4 py-3">
              <p className="text-[12px] font-semibold text-slate-500">Estimated requirement</p>
              <p className="mt-1 text-[18px] font-extrabold text-slate-900">${required.toLocaleString()}</p>
              <p className={`mt-2 text-[12px] font-semibold ${gap > 0 ? "text-[#8E0012]" : "text-[#00AA28]"}`}>
                {gap > 0 ? `Gap: $${gap.toLocaleString()}` : "You are covered."}
              </p>
            </div>

            <div className="mt-6 flex items-center justify-end">
              <button
                onClick={() => setShowSimulator(false)}
                className="rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white"
              >
                Done
              </button>
            </div>
          </div>
        </div>
      ) : null}
    </WorkerLayout>
  );
}
