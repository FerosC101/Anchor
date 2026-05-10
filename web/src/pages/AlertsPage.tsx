import { useEffect, useMemo, useState } from "react";
import { WorkerLayout } from "../components/layout/WorkerLayout";

interface SafetyAlert {
	id: string;
	title: string;
	message: string;
	severity: "Critical" | "High" | "Medium" | "Low";
	date: string;
	read: boolean;
}

const STORAGE_KEY = "anchor_worker_alerts";

const DEFAULT_ALERTS: SafetyAlert[] = [
	{
		id: "alert-1",
		title: "Critical wage theft report",
		message: "Multiple OFWs in Riyadh report unpaid wages for 3 months.",
		severity: "Critical",
		date: "2026-05-08",
		read: false,
	},
	{
		id: "alert-2",
		title: "High-risk employer warning",
		message: "Al-Rashid Household Services flagged for contract substitution.",
		severity: "High",
		date: "2026-05-06",
		read: false,
	},
	{
		id: "alert-3",
		title: "Safety inspection scheduled",
		message: "Dubai construction sites will undergo safety inspections next week.",
		severity: "Medium",
		date: "2026-05-03",
		read: true,
	},
	{
		id: "alert-4",
		title: "Community advisory",
		message: "Report any passport confiscation incidents immediately.",
		severity: "Low",
		date: "2026-04-29",
		read: true,
	},
];

function loadAlerts(): SafetyAlert[] {
	try {
		const raw = localStorage.getItem(STORAGE_KEY);
		if (raw) return JSON.parse(raw) as SafetyAlert[];
	} catch {
		return DEFAULT_ALERTS;
	}
	return DEFAULT_ALERTS;
}

function severityStyles(severity: SafetyAlert["severity"]) {
	switch (severity) {
		case "Critical":
			return "bg-red-50 text-[#8E0012]";
		case "High":
			return "bg-amber-50 text-[#AD4B00]";
		case "Medium":
			return "bg-blue-50 text-[#003696]";
		default:
			return "bg-emerald-50 text-[#00AA28]";
	}
}

export default function AlertsPage() {
	const [alerts, setAlerts] = useState<SafetyAlert[]>(() => loadAlerts());
	const [severityFilter, setSeverityFilter] = useState("All");
	const [search, setSearch] = useState("");

	useEffect(() => {
		localStorage.setItem(STORAGE_KEY, JSON.stringify(alerts));
	}, [alerts]);

	const filteredAlerts = useMemo(() => {
		return alerts.filter((alert) => {
			const matchesSeverity = severityFilter === "All" || alert.severity === severityFilter;
			const matchesSearch =
				alert.title.toLowerCase().includes(search.toLowerCase()) ||
				alert.message.toLowerCase().includes(search.toLowerCase());
			return matchesSeverity && matchesSearch;
		});
	}, [alerts, search, severityFilter]);

	const markAsRead = (id: string) => {
		setAlerts((prev) => prev.map((alert) => (alert.id === id ? { ...alert, read: true } : alert)));
	};

	const archiveAlert = (id: string) => {
		setAlerts((prev) => prev.filter((alert) => alert.id !== id));
	};

	return (
		<WorkerLayout>
			<main className="mx-auto w-full max-w-6xl px-4 py-6 sm:px-6 lg:px-8">
				<div className="flex flex-col gap-6">
					<div>
						<p className="text-[12px] font-semibold uppercase tracking-[0.2em] text-slate-400">Safety Alerts</p>
						<h1 className="mt-2 text-[26px] font-extrabold text-slate-900">Stay ahead of risks</h1>
						<p className="text-[14px] text-slate-600">Critical advisories from community and government partners.</p>
					</div>

					<section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
						<div className="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
							<label className="flex-1">
								<input
									value={search}
									onChange={(e) => setSearch(e.target.value)}
									placeholder="Search alerts"
									className="w-full rounded-full border border-slate-200 px-4 py-2 text-[12px]"
								/>
							</label>
							<div className="flex flex-wrap gap-2">
								{[
									"All",
									"Critical",
									"High",
									"Medium",
									"Low",
								].map((severity) => (
									<button
										key={severity}
										onClick={() => setSeverityFilter(severity)}
										className={`rounded-full px-4 py-2 text-[11px] font-semibold ${
											severityFilter === severity
												? "bg-[#003696] text-white"
												: "bg-slate-100 text-slate-600"
										}`}
									>
										{severity}
									</button>
								))}
							</div>
						</div>

						<div className="mt-6 grid gap-4">
							{filteredAlerts.length === 0 ? (
								<div className="rounded-2xl border border-dashed border-slate-200 p-6 text-center text-[12px] text-slate-400">
									No alerts match your filters.
								</div>
							) : (
								filteredAlerts.map((alert) => (
									<div
										key={alert.id}
										className={`rounded-2xl border px-4 py-4 ${
											alert.read ? "border-slate-100 bg-slate-50/70" : "border-blue-100 bg-white"
										}`}
									>
										<div className="flex items-start justify-between gap-4">
											<div>
												<p className="text-[13px] font-semibold text-slate-900">{alert.title}</p>
												<p className="mt-2 text-[12px] text-slate-600">{alert.message}</p>
											</div>
											<span className={`rounded-full px-3 py-1 text-[11px] font-semibold ${severityStyles(alert.severity)}`}>
												{alert.severity}
											</span>
										</div>
										<div className="mt-4 flex items-center justify-between text-[11px] text-slate-500">
											<span>{alert.date}</span>
											<div className="flex items-center gap-2">
												{!alert.read && (
													<button
														onClick={() => markAsRead(alert.id)}
														className="rounded-full border border-slate-200 px-3 py-1 text-[11px] font-semibold text-slate-600"
													>
														Mark as read
													</button>
												)}
												<button
													onClick={() => archiveAlert(alert.id)}
													className="rounded-full border border-slate-200 px-3 py-1 text-[11px] font-semibold text-slate-600"
												>
													Archive
												</button>
											</div>
										</div>
									</div>
								))
							)}
						</div>
					</section>
				</div>
			</main>
		</WorkerLayout>
	);
}
