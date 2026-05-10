import { WorkerLayout } from "../components/layout/WorkerLayout";

const RESOURCES = [
  {
    title: "Embassy Hotlines",
    description:
      "Keep your embassy and labor attaché numbers saved offline. Contact them immediately in emergencies.",
  },
  {
    title: "Emergency Exit Guide",
    description:
      "Plan a safe exit route and share your plan with trusted family or friends.",
  },
  {
    title: "Know Your Rights",
    description:
      "Review standard contract clauses, minimum wage protections, and rest-day entitlements.",
  },
  {
    title: "Document Safety",
    description:
      "Store digital copies of your passport, visa, and contract in a secure place.",
  },
];

const CONTACTS = [
  {
    label: "Philippine Overseas Labor Office (POLO)",
    value: "+63 2 8334 2200",
  },
  {
    label: "DOLE Hotline",
    value: "1349",
  },
  {
    label: "OWWA 24/7 Hotline",
    value: "+63 2 8913 6437",
  },
];

export default function SafetyResourcesPage() {
  return (
    <WorkerLayout>
      <main className="mx-auto w-full max-w-5xl px-4 py-6 sm:px-6 lg:px-8">
        <div className="flex flex-col gap-6">
          <div>
            <p className="text-[12px] font-semibold uppercase tracking-[0.2em] text-slate-400">Safety Resources</p>
            <h1 className="mt-2 text-[26px] font-extrabold text-slate-900">Emergency support at your fingertips</h1>
            <p className="text-[14px] text-slate-600">Important guides and contacts for OFW protection.</p>
          </div>

          <section className="grid gap-4 md:grid-cols-2">
            {RESOURCES.map((resource) => (
              <div key={resource.title} className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
                <p className="text-[15px] font-semibold text-slate-900">{resource.title}</p>
                <p className="mt-3 text-[12px] text-slate-600">{resource.description}</p>
              </div>
            ))}
          </section>

          <section className="rounded-3xl border border-slate-100 bg-white p-6 shadow-sm">
            <p className="text-[14px] font-semibold text-slate-900">Emergency Contacts</p>
            <div className="mt-4 grid gap-3">
              {CONTACTS.map((contact) => (
                <div key={contact.label} className="rounded-2xl bg-slate-50/70 px-4 py-3">
                  <p className="text-[12px] font-semibold text-slate-700">{contact.label}</p>
                  <p className="mt-1 text-[12px] text-slate-500">{contact.value}</p>
                </div>
              ))}
            </div>
          </section>
        </div>
      </main>
    </WorkerLayout>
  );
}
