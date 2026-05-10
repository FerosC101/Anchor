import { useEffect, useMemo, useState } from "react";
import { WorkerLayout } from "../components/layout/WorkerLayout";

interface ContractScan {
	id: string;
	name: string;
	date: string;
	score: number;
	issueCount: number;
	criticalCount: number;
	status: "Low" | "Medium" | "High";
}

const STORAGE_KEY = "anchor_contract_scans";

const DEFAULT_SCANS: ContractScan[] = [
	{
		id: "scan-1001",
		name: "Employment_Agreement.pdf",
		date: "2026-03-10",
		score: 58,
		issueCount: 3,
		criticalCount: 1,
		status: "Medium",
	},
	{
		id: "scan-1002",
		name: "Work_Contract_Final.pdf",
		date: "2026-02-18",
		score: 22,
		issueCount: 1,
		criticalCount: 0,
		status: "Low",
	},
	{
		id: "scan-1003",
		name: "Recruitment_Offer.pdf",
		date: "2026-01-12",
		score: 76,
		issueCount: 5,
		criticalCount: 2,
		status: "High",
	},
];

function loadScans(): ContractScan[] {
	try {
		const raw = localStorage.getItem(STORAGE_KEY);
		if (raw) return JSON.parse(raw) as ContractScan[];
	} catch {
		return DEFAULT_SCANS;
	}
	return DEFAULT_SCANS;
}

function scoreToStatus(score: number): ContractScan["status"] {
	if (score >= 70) return "High";
	if (score >= 40) return "Medium";
	return "Low";
}

function statusStyles(status: ContractScan["status"]) {
	switch (status) {
		case "High":
			return { bg: "bg-red-50", text: "text-[#8E0012]" };
		case "Medium":
			return { bg: "bg-amber-50", text: "text-[#AD4B00]" };
		default:
			return { bg: "bg-emerald-50", text: "text-[#00AA28]" };
	}
}

function getActions(score: number) {
	if (score >= 70) {
		return [
			"Contact your embassy or consulate immediately",
			"Request contract revisions before signing",
			"Share the report with community safety",
		];
	}
	if (score >= 40) {
		return [
			"Review flagged clauses carefully",
			"Ask for clarifications on unclear terms",
			"Save and keep this analysis report",
		];
	}
	return [
		"Keep a copy for your records",
		"Monitor wage and overtime clauses",
		"Report any future discrepancies",
	];
}

export default function ContractsPage() {
	const [scans, setScans] = useState<ContractScan[]>(() => loadScans());
	const [selectedScan, setSelectedScan] = useState<ContractScan | null>(null);
	const [isUploading, setIsUploading] = useState(false);

	useEffect(() => {
		localStorage.setItem(STORAGE_KEY, JSON.stringify(scans));
	}, [scans]);

	useEffect(() => {
		if (!selectedScan && scans.length > 0) {
			setSelectedScan(scans[0]);
		}
	}, [scans, selectedScan]);

	const handleUpload = (file: File) => {
		if (!file) return;
		setIsUploading(true);
		const score = Math.floor(Math.random() * 80) + 10;
		const issueCount = Math.max(1, Math.floor(score / 15));
		const criticalCount = score >= 70 ? Math.max(1, Math.floor(score / 35)) : 0;
		const newScan: ContractScan = {
			id: `scan-${Date.now()}`,
			name: file.name,
			date: new Date().toISOString().slice(0, 10),
			score,
			issueCount,
			criticalCount,
			status: scoreToStatus(score),
		};
		setTimeout(() => {
			setScans((prev) => [newScan, ...prev]);
			setSelectedScan(newScan);
			setIsUploading(false);
		}, 900);
	};

	const summary = useMemo(() => {
		const total = scans.length;
		const highRisk = scans.filter((scan) => scan.status === "High").length;
		const mediumRisk = scans.filter((scan) => scan.status === "Medium").length;
		return { total, highRisk, mediumRisk };
	}, [scans]);

	return (
		<WorkerLayout>
			<main className="mx-auto w-full max-w-6xl px-4 py-6 sm:px-6 lg:px-8">
				<div className="flex flex-col gap-6">
					<div>
						<p className="text-[12px] font-semibold uppercase tracking-[0.2em] text-slate-400">Contract Scanner</p>
						<h1 className="mt-2 text-[26px] font-extrabold text-slate-900">Contract Reality Check</h1>
						<p className="text-[14px] text-slate-600">Scan your employment contract and identify risks early.</p>
					</div>

					<section className="grid gap-4 md:grid-cols-3">
						<div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
							<p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">Total Scans</p>
							<p className="mt-3 text-[22px] font-extrabold text-slate-900">{summary.total}</p>
						</div>
						<div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
							<p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">High Risk</p>
							<p className="mt-3 text-[22px] font-extrabold text-[#8E0012]">{summary.highRisk}</p>
						</div>
						<div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
							<p className="text-[12px] font-semibold uppercase tracking-wide text-slate-500">Medium Risk</p>
							<p className="mt-3 text-[22px] font-extrabold text-[#AD4B00]">{summary.mediumRisk}</p>
						</div>
					</section>

					<section className="grid gap-6 lg:grid-cols-[1.1fr_0.9fr]">
						<div className="rounded-3xl border border-dashed border-slate-200 bg-white p-6 shadow-sm">
							<div className="flex flex-col items-center justify-center gap-4 text-center">
								<div className="flex h-14 w-14 items-center justify-center rounded-full bg-blue-50 text-[#003696]">
									<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
										<path d="M12 16v-8" />
										<path d="M9 13l3 3 3-3" />
										<path d="M20 16.5A4.5 4.5 0 0 1 15.5 21h-7A4.5 4.5 0 0 1 4 16.5" />
									</svg>
								</div>
								<div>
									<p className="text-[15px] font-semibold text-slate-900">Upload contract for analysis</p>
									<p className="mt-1 text-[12px] text-slate-500">
										PDF or DOCX files up to 10MB
									</p>
								</div>
								<label className="cursor-pointer rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white">
									{isUploading ? "Analyzing..." : "Choose file"}
									<input
										type="file"
										className="hidden"
										onChange={(e) => {
											const file = e.target.files?.[0];
											if (file) handleUpload(file);
										}}
									/>
								</label>
							</div>
						</div>

						<div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
							<p className="text-[14px] font-semibold text-slate-900">Selected Scan</p>
							{selectedScan ? (
								<div className="mt-4">
									<div className="flex items-center justify-between">
										<div>
											<p className="text-[13px] font-semibold text-slate-900">{selectedScan.name}</p>
											<p className="text-[11px] text-slate-500">{selectedScan.date}</p>
										</div>
										<span
											className={`rounded-full px-3 py-1 text-[11px] font-semibold ${
												statusStyles(selectedScan.status).bg
											} ${statusStyles(selectedScan.status).text}`}
										>
											{selectedScan.status} Risk
										</span>
									</div>

									<div className="mt-4 grid grid-cols-3 gap-3">
										<div className="rounded-xl bg-slate-50 px-3 py-3">
											<p className="text-[10px] font-semibold text-slate-500">Score</p>
											<p className="mt-1 text-[16px] font-bold text-slate-900">{selectedScan.score}</p>
										</div>
										<div className="rounded-xl bg-slate-50 px-3 py-3">
											<p className="text-[10px] font-semibold text-slate-500">Issues</p>
											<p className="mt-1 text-[16px] font-bold text-slate-900">{selectedScan.issueCount}</p>
										</div>
										<div className="rounded-xl bg-slate-50 px-3 py-3">
											<p className="text-[10px] font-semibold text-slate-500">Critical</p>
											<p className="mt-1 text-[16px] font-bold text-slate-900">{selectedScan.criticalCount}</p>
										</div>
									</div>

									<div className="mt-4 rounded-2xl bg-blue-50 px-4 py-3">
										<p className="text-[12px] font-semibold text-slate-700">Recommended actions</p>
										<ul className="mt-2 list-disc space-y-1 pl-5 text-[12px] text-slate-600">
											{getActions(selectedScan.score).map((action) => (
												<li key={action}>{action}</li>
											))}
										</ul>
									</div>
								</div>
							) : (
								<p className="mt-4 text-[12px] text-slate-500">No scans yet.</p>
							)}
						</div>
					</section>

					<section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
						<div className="flex items-center justify-between">
							<p className="text-[14px] font-semibold text-slate-900">Recent Scans</p>
							<p className="text-[12px] text-slate-500">{scans.length} files</p>
						</div>
						<div className="mt-4 grid gap-3">
							{scans.map((scan) => (
								<button
									key={scan.id}
									onClick={() => setSelectedScan(scan)}
									className="flex w-full items-center justify-between rounded-2xl border border-slate-100 bg-slate-50/70 px-4 py-3 text-left transition hover:bg-white"
								>
									<div>
										<p className="text-[13px] font-semibold text-slate-900">{scan.name}</p>
										<p className="text-[11px] text-slate-500">{scan.date}</p>
									</div>
									<div className="flex items-center gap-3">
										<span
											className={`rounded-full px-3 py-1 text-[11px] font-semibold ${
												statusStyles(scan.status).bg
											} ${statusStyles(scan.status).text}`}
										>
											{scan.status} Risk
										</span>
										<span className="text-[13px] font-semibold text-slate-700">{scan.score}</span>
									</div>
								</button>
							))}
						</div>
					</section>
				</div>
			</main>
		</WorkerLayout>
	);
}
