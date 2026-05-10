import { useEffect, useMemo, useState } from "react";
import { WorkerLayout } from "../components/layout/WorkerLayout";

interface WageLog {
  id: string;
  amount: number;
  expectedAmount?: number;
  currency: string;
  date: string;
  notes?: string;
}

const STORAGE_KEY = "anchor_wage_logs";

const DEFAULT_LOGS: WageLog[] = [
  {
    id: "log-1",
    amount: 450,
    expectedAmount: 480,
    currency: "USD",
    date: "2026-04-28",
    notes: "Delayed by 3 days",
  },
  {
    id: "log-2",
    amount: 480,
    expectedAmount: 480,
    currency: "USD",
    date: "2026-03-28",
  },
  {
    id: "log-3",
    amount: 470,
    expectedAmount: 480,
    currency: "USD",
    date: "2026-02-28",
    notes: "Deduction for accommodation",
  },
  {
    id: "log-4",
    amount: 480,
    expectedAmount: 480,
    currency: "USD",
    date: "2026-01-28",
  },
];

function loadLogs(): WageLog[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) return JSON.parse(raw) as WageLog[];
  } catch {
    return DEFAULT_LOGS;
  }
  return DEFAULT_LOGS;
}

function formatAmount(amount: number, currency: string) {
  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency,
    maximumFractionDigits: 2,
  }).format(amount);
}

export default function WagesPage() {
  const [logs, setLogs] = useState<WageLog[]>(() => loadLogs());
  const [showModal, setShowModal] = useState(false);
  const [form, setForm] = useState({
    amount: "",
    expectedAmount: "",
    currency: "USD",
    date: new Date().toISOString().slice(0, 10),
    notes: "",
  });

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(logs));
  }, [logs]);

  const latestLog = logs[0];
  const gap = latestLog?.expectedAmount
    ? latestLog.amount - latestLog.expectedAmount
    : null;

  const chartLogs = useMemo(() => logs.slice(0, 6).reverse(), [logs]);
  const maxAmount = useMemo(() => {
    if (chartLogs.length === 0) return 1;
    return Math.max(...chartLogs.map((log) => log.amount)) * 1.1;
  }, [chartLogs]);

  const handleSubmit = () => {
    const amount = Number(form.amount);
    if (!amount || amount <= 0) return;
    const expectedAmount = Number(form.expectedAmount);
    const newLog: WageLog = {
      id: `log-${Date.now()}`,
      amount,
      expectedAmount: expectedAmount > 0 ? expectedAmount : undefined,
      currency: form.currency,
      date: form.date,
      notes: form.notes.trim() || undefined,
    };
    setLogs((prev) => [newLog, ...prev]);
    setForm({
      amount: "",
      expectedAmount: "",
      currency: form.currency,
      date: new Date().toISOString().slice(0, 10),
      notes: "",
    });
    setShowModal(false);
  };

  return (
    <WorkerLayout>
      <main className="mx-auto w-full max-w-6xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="flex flex-col gap-6">
          <div>
            <p className="text-[12px] font-semibold uppercase tracking-[0.2em] text-slate-400">Wage Monitor</p>
            <h1 className="mt-2 text-[26px] font-extrabold text-slate-900">Track your salary and deductions</h1>
            <p className="text-[14px] text-slate-600">
              Log every payout to detect delays and unexpected deductions.
            </p>
          </div>

          <section className="grid gap-4 md:grid-cols-2">
            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">Last Received</p>
              <p className="mt-3 text-[22px] font-extrabold text-slate-900">
                {latestLog ? formatAmount(latestLog.amount, latestLog.currency) : "No logs yet"}
              </p>
              <p className="mt-2 text-[12px] text-slate-500">{latestLog?.date ?? "—"}</p>
            </div>
            <div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
              <p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">Wage Gap</p>
              <p
                className={`mt-3 text-[22px] font-extrabold ${
                  gap === null
                    ? "text-slate-900"
                    : gap < 0
                      ? "text-[#8E0012]"
                      : "text-[#00AA28]"
                }`}
              >
                {gap === null
                  ? "N/A"
                  : `${gap < 0 ? "-" : "+"}${formatAmount(Math.abs(gap), latestLog.currency)}`}
              </p>
              <p className="mt-2 text-[12px] text-slate-500">
                Compared to expected salary
              </p>
            </div>
          </section>

          <section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-[14px] font-semibold text-slate-900">Wage History</p>
                <p className="text-[12px] text-slate-500">Last 6 payouts</p>
              </div>
              <button
                onClick={() => setShowModal(true)}
                className="rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white"
              >
                Log Salary
              </button>
            </div>

            <div className="mt-6 flex h-48 items-end gap-3">
              {chartLogs.length === 0 ? (
                <div className="flex h-full w-full items-center justify-center text-[12px] text-slate-400">
                  Log your first salary to see trends.
                </div>
              ) : (
                chartLogs.map((log) => {
                  const height = Math.max((log.amount / maxAmount) * 100, 8);
                  return (
                    <div key={log.id} className="flex flex-1 flex-col items-center gap-2">
                      <div
                        className="w-8 rounded-full"
                        style={{
                          height: `${height}%`,
                          background: "linear-gradient(180deg, #003696 0%, #6EA8FF 100%)",
                        }}
                      />
                      <p className="text-[10px] text-slate-500">{log.date.slice(5)}</p>
                    </div>
                  );
                })
              )}
            </div>
          </section>

          <section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
            <div className="flex items-center justify-between">
              <p className="text-[14px] font-semibold text-slate-900">Recent Logs</p>
              <p className="text-[12px] text-slate-500">{logs.length} entries</p>
            </div>
            <div className="mt-4 flex flex-col gap-3">
              {logs.length === 0 ? (
                <div className="rounded-2xl border border-dashed border-slate-200 p-6 text-center text-[12px] text-slate-400">
                  No wage logs yet.
                </div>
              ) : (
                logs.map((log) => {
                  const gapValue = log.expectedAmount ? log.amount - log.expectedAmount : null;
                  return (
                    <div key={log.id} className="rounded-2xl border border-slate-100 bg-slate-50/70 p-4">
                      <div className="flex items-center justify-between">
                        <div>
                          <p className="text-[13px] font-semibold text-slate-900">
                            {formatAmount(log.amount, log.currency)}
                          </p>
                          <p className="text-[11px] text-slate-500">{log.date}</p>
                        </div>
                        {gapValue !== null && (
                          <span
                            className={`rounded-full px-3 py-1 text-[11px] font-semibold ${
                              gapValue < 0
                                ? "bg-red-50 text-[#8E0012]"
                                : "bg-emerald-50 text-[#00AA28]"
                            }`}
                          >
                            {gapValue < 0 ? "Underpaid" : "On track"}
                          </span>
                        )}
                      </div>
                      {log.notes ? (
                        <p className="mt-2 text-[12px] text-slate-600">{log.notes}</p>
                      ) : null}
                    </div>
                  );
                })
              )}
            </div>
          </section>
        </div>
      </main>

      {showModal ? (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/30 px-4">
          <div className="w-full max-w-lg rounded-3xl bg-white p-6 shadow-lg">
            <div className="flex items-center justify-between">
              <p className="text-[16px] font-semibold text-slate-900">Log Salary</p>
              <button
                onClick={() => setShowModal(false)}
                className="rounded-full p-2 text-slate-400 hover:bg-slate-100"
              >
                ✕
              </button>
            </div>

            <div className="mt-4 grid gap-4 md:grid-cols-2">
              <label className="text-[12px] font-semibold text-slate-600">
                Amount Received
                <input
                  type="number"
                  value={form.amount}
                  onChange={(e) => setForm((prev) => ({ ...prev, amount: e.target.value }))}
                  className="mt-2 w-full rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
                />
              </label>
              <label className="text-[12px] font-semibold text-slate-600">
                Expected Amount
                <input
                  type="number"
                  value={form.expectedAmount}
                  onChange={(e) => setForm((prev) => ({ ...prev, expectedAmount: e.target.value }))}
                  className="mt-2 w-full rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
                />
              </label>
              <label className="text-[12px] font-semibold text-slate-600">
                Currency
                <select
                  value={form.currency}
                  onChange={(e) => setForm((prev) => ({ ...prev, currency: e.target.value }))}
                  className="mt-2 w-full rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
                >
                  {[
                    "USD",
                    "SGD",
                    "HKD",
                    "AED",
                    "QAR",
                    "MYR",
                    "PHP",
                  ].map((currency) => (
                    <option key={currency} value={currency}>
                      {currency}
                    </option>
                  ))}
                </select>
              </label>
              <label className="text-[12px] font-semibold text-slate-600">
                Date
                <input
                  type="date"
                  value={form.date}
                  onChange={(e) => setForm((prev) => ({ ...prev, date: e.target.value }))}
                  className="mt-2 w-full rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
                />
              </label>
            </div>

            <label className="mt-4 block text-[12px] font-semibold text-slate-600">
              Notes (optional)
              <textarea
                value={form.notes}
                onChange={(e) => setForm((prev) => ({ ...prev, notes: e.target.value }))}
                className="mt-2 h-24 w-full rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
              />
            </label>

            <div className="mt-6 flex items-center justify-end gap-2">
              <button
                onClick={() => setShowModal(false)}
                className="rounded-full border border-slate-200 px-4 py-2 text-[12px] font-semibold text-slate-600"
              >
                Cancel
              </button>
              <button
                onClick={handleSubmit}
                className="rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white"
              >
                Save Log
              </button>
            </div>
          </div>
        </div>
      ) : null}
    </WorkerLayout>
  );
}
