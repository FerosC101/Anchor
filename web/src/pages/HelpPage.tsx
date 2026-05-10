import { WorkerLayout } from "../components/layout/WorkerLayout";

const FAQS = [
  {
    question: "How does contract scanning work?",
    answer:
      "Upload a PDF or DOCX contract and the system flags risky clauses. Always consult legal experts for final decisions.",
  },
  {
    question: "How accurate is the AI analysis?",
    answer:
      "The AI model is trained on migrant worker contracts and reports. It provides guidance but should not replace legal advice.",
  },
  {
    question: "Can I report anonymously?",
    answer:
      "Yes, community reports can be posted without your name. Protect your identity whenever needed.",
  },
  {
    question: "How do I track wages?",
    answer:
      "Log each salary payment and compare it with expected pay to catch delays or deductions.",
  },
];

const GUIDES = [
  {
    title: "Create Your Profile",
    description: "Set up personal and work details to receive personalized recommendations.",
  },
  {
    title: "Upload Your Contract",
    description: "Scan contracts to detect risks and verify employer terms.",
  },
  {
    title: "Wage Monitoring",
    description: "Track earnings, deductions, and payment delays in one place.",
  },
  {
    title: "Financial Shield",
    description: "Plan your safety net and emergency exit strategy.",
  },
];

export default function HelpPage() {
  return (
    <WorkerLayout>
      <main className="mx-auto w-full max-w-5xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="flex flex-col gap-6">
          <div>
            <p className="text-[12px] font-semibold uppercase tracking-[0.2em] text-slate-400">Help & Support</p>
            <h1 className="mt-2 text-[26px] font-extrabold text-slate-900">Guides and FAQs</h1>
            <p className="text-[14px] text-slate-600">Everything you need to get started safely.</p>
          </div>

          <section className="grid gap-4 md:grid-cols-2">
            {GUIDES.map((guide) => (
              <div key={guide.title} className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
                <p className="text-[15px] font-semibold text-slate-900">{guide.title}</p>
                <p className="mt-3 text-[12px] text-slate-600">{guide.description}</p>
              </div>
            ))}
          </section>

          <section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
            <p className="text-[14px] font-semibold text-slate-900">Frequently Asked Questions</p>
            <div className="mt-4 space-y-3">
              {FAQS.map((faq) => (
                <div key={faq.question} className="rounded-2xl bg-slate-50/70 px-4 py-3">
                  <p className="text-[12px] font-semibold text-slate-700">{faq.question}</p>
                  <p className="mt-2 text-[12px] text-slate-600">{faq.answer}</p>
                </div>
              ))}
            </div>
          </section>
        </div>
      </main>
    </WorkerLayout>
  );
}
