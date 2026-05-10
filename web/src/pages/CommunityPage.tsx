import { useEffect, useMemo, useState } from "react";
import { WorkerLayout } from "../components/layout/WorkerLayout";

interface CommunityPost {
	id: string;
	company: string;
	location: string;
	description: string;
	tags: string[];
	upvotes: number;
	comments: number;
	createdAt: string;
}

interface CommunityReport {
	id: string;
	title: string;
	location: string;
	category: string;
	status: "Submitted" | "In Review" | "Verified";
	createdAt: string;
}

const POSTS_KEY = "anchor_community_posts";
const REPORTS_KEY = "anchor_community_reports";

const DEFAULT_POSTS: CommunityPost[] = [
	{
		id: "post-1",
		company: "BuildRite Construction",
		location: "Riyadh, Saudi Arabia",
		description:
			"Employer delayed wages for 2 months and withheld passports. Reported to embassy; investigation ongoing.",
		tags: ["Wage Theft", "Document Confiscation"],
		upvotes: 48,
		comments: 12,
		createdAt: "2026-05-06",
	},
	{
		id: "post-2",
		company: "BrightStar Domestic Services",
		location: "Dubai, UAE",
		description:
			"Workers report excessive overtime without pay. Agency asked for contract review.",
		tags: ["Unpaid Overtime"],
		upvotes: 31,
		comments: 7,
		createdAt: "2026-05-02",
	},
	{
		id: "post-3",
		company: "MegaConstruct Ltd",
		location: "Singapore",
		description:
			"Safety violations at site; workers lack protective gear. Multiple incidents this week.",
		tags: ["Unsafe Conditions"],
		upvotes: 58,
		comments: 19,
		createdAt: "2026-04-27",
	},
];

const DEFAULT_REPORTS: CommunityReport[] = [
	{
		id: "rep-1",
		title: "Delayed wage payments",
		location: "Doha, Qatar",
		category: "Wage Theft",
		status: "In Review",
		createdAt: "2026-05-01",
	},
	{
		id: "rep-2",
		title: "Unsafe dormitory conditions",
		location: "Kuwait City, Kuwait",
		category: "Living Conditions",
		status: "Submitted",
		createdAt: "2026-04-24",
	},
];

const HOTSPOTS = [
	{ country: "Saudi Arabia", city: "Riyadh", severity: "High" },
	{ country: "UAE", city: "Dubai", severity: "Medium" },
	{ country: "Hong Kong", city: "Kowloon", severity: "Medium" },
];

function loadItems<T>(key: string, fallback: T[]): T[] {
	try {
		const raw = localStorage.getItem(key);
		if (raw) return JSON.parse(raw) as T[];
	} catch {
		return fallback;
	}
	return fallback;
}

export default function CommunityPage() {
	const [posts, setPosts] = useState<CommunityPost[]>(() => loadItems(POSTS_KEY, DEFAULT_POSTS));
	const [reports, setReports] = useState<CommunityReport[]>(() => loadItems(REPORTS_KEY, DEFAULT_REPORTS));
	const [showPostModal, setShowPostModal] = useState(false);
	const [showReportModal, setShowReportModal] = useState(false);
	const [postForm, setPostForm] = useState({ company: "", location: "", description: "", tags: "" });
	const [reportForm, setReportForm] = useState({ title: "", location: "", category: "Wage Theft", description: "" });

	useEffect(() => {
		localStorage.setItem(POSTS_KEY, JSON.stringify(posts));
	}, [posts]);

	useEffect(() => {
		localStorage.setItem(REPORTS_KEY, JSON.stringify(reports));
	}, [reports]);

	const statusStyle = (status: CommunityReport["status"]) => {
		switch (status) {
			case "Verified":
				return "bg-emerald-50 text-[#00AA28]";
			case "In Review":
				return "bg-blue-50 text-[#003696]";
			default:
				return "bg-amber-50 text-[#AD4B00]";
		}
	};

	const handleUpvote = (id: string) => {
		setPosts((prev) =>
			prev.map((post) => (post.id === id ? { ...post, upvotes: post.upvotes + 1 } : post))
		);
	};

	const handleCreatePost = () => {
		if (!postForm.company || !postForm.location || !postForm.description) return;
		const tags = postForm.tags
			.split(",")
			.map((tag) => tag.trim())
			.filter(Boolean);
		const newPost: CommunityPost = {
			id: `post-${Date.now()}`,
			company: postForm.company,
			location: postForm.location,
			description: postForm.description,
			tags: tags.length ? tags : ["General"],
			upvotes: 0,
			comments: 0,
			createdAt: new Date().toISOString().slice(0, 10),
		};
		setPosts((prev) => [newPost, ...prev]);
		setPostForm({ company: "", location: "", description: "", tags: "" });
		setShowPostModal(false);
	};

	const handleCreateReport = () => {
		if (!reportForm.title || !reportForm.location) return;
		const newReport: CommunityReport = {
			id: `rep-${Date.now()}`,
			title: reportForm.title,
			location: reportForm.location,
			category: reportForm.category,
			status: "Submitted",
			createdAt: new Date().toISOString().slice(0, 10),
		};
		setReports((prev) => [newReport, ...prev]);
		setReportForm({ title: "", location: "", category: "Wage Theft", description: "" });
		setShowReportModal(false);
	};

	const hotspotSummary = useMemo(() => {
		const high = HOTSPOTS.filter((spot) => spot.severity === "High").length;
		return `Hotspots: ${high} high, ${HOTSPOTS.length - high} moderate`;
	}, []);

	return (
		<WorkerLayout>
			<main className="mx-auto w-full max-w-6xl px-4 py-6 sm:px-6 lg:px-8">
				<div className="flex flex-col gap-6">
					<div>
						<p className="text-[12px] font-semibold uppercase tracking-[0.2em] text-slate-400">Community Safety</p>
						<h1 className="mt-2 text-[26px] font-extrabold text-slate-900">Stay informed with fellow workers</h1>
						<p className="text-[14px] text-slate-600">Share reports, read alerts, and keep each other safe.</p>
					</div>

					<section className="grid gap-4 lg:grid-cols-[1.1fr_0.9fr]">
						<div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
							<div className="flex items-center justify-between">
								<div>
									<p className="text-[14px] font-semibold text-slate-900">Safety Map</p>
									<p className="text-[12px] text-slate-500">{hotspotSummary}</p>
								</div>
								<button
									onClick={() => setShowReportModal(true)}
									className="rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white"
								>
									Report Issue
								</button>
							</div>

							<div className="mt-4 grid gap-3">
								{HOTSPOTS.map((spot) => (
									<div key={`${spot.city}-${spot.country}`} className="rounded-2xl bg-slate-50/70 p-4">
										<div className="flex items-center justify-between">
											<div>
												<p className="text-[13px] font-semibold text-slate-900">
													{spot.city}, {spot.country}
												</p>
												<p className="text-[11px] text-slate-500">Latest reports this month</p>
											</div>
											<span
												className={`rounded-full px-3 py-1 text-[11px] font-semibold ${
													spot.severity === "High"
														? "bg-red-50 text-[#8E0012]"
														: "bg-amber-50 text-[#AD4B00]"
												}`}
											>
												{spot.severity} Risk
											</span>
										</div>
									</div>
								))}
							</div>
						</div>

						<div className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
							<div className="flex items-center justify-between">
								<div>
									<p className="text-[14px] font-semibold text-slate-900">My Reports</p>
									<p className="text-[12px] text-slate-500">{reports.length} submitted</p>
								</div>
								<button
									onClick={() => setShowReportModal(true)}
									className="rounded-full border border-slate-200 px-4 py-2 text-[12px] font-semibold text-slate-600"
								>
									New report
								</button>
							</div>
							<div className="mt-4 grid gap-3">
								{reports.map((report) => (
									<div key={report.id} className="rounded-2xl bg-slate-50/70 p-4">
										<div className="flex items-center justify-between">
											<div>
												<p className="text-[13px] font-semibold text-slate-900">{report.title}</p>
												<p className="text-[11px] text-slate-500">{report.location}</p>
											</div>
											<span className={`rounded-full px-3 py-1 text-[11px] font-semibold ${statusStyle(report.status)}`}>
												{report.status}
											</span>
										</div>
										<p className="mt-2 text-[11px] text-slate-500">{report.category} · {report.createdAt}</p>
									</div>
								))}
							</div>
						</div>
					</section>

					<section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
						<div className="flex items-center justify-between">
							<div>
								<p className="text-[14px] font-semibold text-slate-900">Community Feed</p>
								<p className="text-[12px] text-slate-500">Latest safety discussions</p>
							</div>
							<button
								onClick={() => setShowPostModal(true)}
								className="rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white"
							>
								Share Update
							</button>
						</div>
						<div className="mt-4 grid gap-4 lg:grid-cols-2">
							{posts.map((post) => (
								<div key={post.id} className="rounded-2xl border border-slate-100 bg-slate-50/70 p-4">
									<div className="flex items-center justify-between">
										<div>
											<p className="text-[13px] font-semibold text-slate-900">{post.company}</p>
											<p className="text-[11px] text-slate-500">{post.location}</p>
										</div>
										<span className="text-[11px] text-slate-400">{post.createdAt}</span>
									</div>
									<p className="mt-3 text-[12px] text-slate-600">{post.description}</p>
									<div className="mt-3 flex flex-wrap gap-2">
										{post.tags.map((tag) => (
											<span key={tag} className="rounded-full bg-white px-3 py-1 text-[11px] font-semibold text-slate-600">
												{tag}
											</span>
										))}
									</div>
									<div className="mt-4 flex items-center justify-between text-[11px] text-slate-500">
										<button
											onClick={() => handleUpvote(post.id)}
											className="rounded-full bg-white px-3 py-1 text-[11px] font-semibold text-slate-600"
										>
											▲ {post.upvotes}
										</button>
										<span>{post.comments} comments</span>
									</div>
								</div>
							))}
						</div>
					</section>
				</div>
			</main>

			{showPostModal ? (
				<div className="fixed inset-0 z-50 flex items-center justify-center bg-black/30 px-4">
					<div className="w-full max-w-lg rounded-3xl bg-white p-6 shadow-lg">
						<div className="flex items-center justify-between">
							<p className="text-[16px] font-semibold text-slate-900">Share Community Update</p>
							<button onClick={() => setShowPostModal(false)} className="rounded-full p-2 text-slate-400 hover:bg-slate-100">✕</button>
						</div>
						<div className="mt-4 grid gap-3">
							<input
								value={postForm.company}
								onChange={(e) => setPostForm((prev) => ({ ...prev, company: e.target.value }))}
								placeholder="Company / Employer"
								className="rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
							/>
							<input
								value={postForm.location}
								onChange={(e) => setPostForm((prev) => ({ ...prev, location: e.target.value }))}
								placeholder="Location"
								className="rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
							/>
							<textarea
								value={postForm.description}
								onChange={(e) => setPostForm((prev) => ({ ...prev, description: e.target.value }))}
								placeholder="Describe the situation"
								className="h-24 rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
							/>
							<input
								value={postForm.tags}
								onChange={(e) => setPostForm((prev) => ({ ...prev, tags: e.target.value }))}
								placeholder="Tags (comma-separated)"
								className="rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
							/>
						</div>
						<div className="mt-6 flex items-center justify-end gap-2">
							<button
								onClick={() => setShowPostModal(false)}
								className="rounded-full border border-slate-200 px-4 py-2 text-[12px] font-semibold text-slate-600"
							>
								Cancel
							</button>
							<button
								onClick={handleCreatePost}
								className="rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white"
							>
								Post Update
							</button>
						</div>
					</div>
				</div>
			) : null}

			{showReportModal ? (
				<div className="fixed inset-0 z-50 flex items-center justify-center bg-black/30 px-4">
					<div className="w-full max-w-lg rounded-3xl bg-white p-6 shadow-lg">
						<div className="flex items-center justify-between">
							<p className="text-[16px] font-semibold text-slate-900">Submit Safety Report</p>
							<button onClick={() => setShowReportModal(false)} className="rounded-full p-2 text-slate-400 hover:bg-slate-100">✕</button>
						</div>
						<div className="mt-4 grid gap-3">
							<input
								value={reportForm.title}
								onChange={(e) => setReportForm((prev) => ({ ...prev, title: e.target.value }))}
								placeholder="Report title"
								className="rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
							/>
							<input
								value={reportForm.location}
								onChange={(e) => setReportForm((prev) => ({ ...prev, location: e.target.value }))}
								placeholder="Location"
								className="rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
							/>
							<select
								value={reportForm.category}
								onChange={(e) => setReportForm((prev) => ({ ...prev, category: e.target.value }))}
								className="rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
							>
								{[
									"Wage Theft",
									"Unsafe Conditions",
									"Contract Issues",
									"Living Conditions",
									"Harassment",
								].map((category) => (
									<option key={category} value={category}>
										{category}
									</option>
								))}
							</select>
							<textarea
								value={reportForm.description}
								onChange={(e) => setReportForm((prev) => ({ ...prev, description: e.target.value }))}
								placeholder="Describe the issue"
								className="h-24 rounded-xl border border-slate-200 px-3 py-2 text-[13px]"
							/>
						</div>
						<div className="mt-6 flex items-center justify-end gap-2">
							<button
								onClick={() => setShowReportModal(false)}
								className="rounded-full border border-slate-200 px-4 py-2 text-[12px] font-semibold text-slate-600"
							>
								Cancel
							</button>
							<button
								onClick={handleCreateReport}
								className="rounded-full bg-[#003696] px-4 py-2 text-[12px] font-semibold text-white"
							>
								Submit Report
							</button>
						</div>
					</div>
				</div>
			) : null}
		</WorkerLayout>
	);
}
