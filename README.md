# Mike Kim — Content Skills Plugin

Hi Mike 👋

This repo powers your content skills inside Claude. Once you connect it, every skill update I push reaches you automatically — no downloading or uploading.

Five steps. About ten minutes.

---

## Step 1 — Accept the GitHub invitation

You'll get an email from GitHub: *"Chad Owen invited you to maeve-ferguson-consulting/mike-kim"*

1. Click **View invitation**
2. Click **Accept invitation**
3. You should land on the `mike-kim` repo page at https://github.com/maeve-ferguson-consulting/mike-kim

If no email, check spam — or text Chad.

---

## Step 2 — Connect GitHub to Claude (one-time)

1. Open the **Claude desktop app**
2. Click your profile icon (top-right) → **Customize**
3. Find the **Plugins** section → click **+** → **Sync from GitHub**
4. If you haven't connected GitHub before, click **Install GitHub App** — this opens your browser
5. When GitHub asks "All repositories" or "Only select repositories" → pick **Only select repositories** → choose only `mike-kim`
6. Click **Install & Authorize**

---

## Step 3 — Sync this plugin

Still in the Sync dialog (reopen via Plugins → + → Sync from GitHub if it closed):

1. Pick `maeve-ferguson-consulting/mike-kim` from the dropdown
2. Toggle **Sync automatically** to **ON** — this is the key setting. When Chad pushes updates, you get them without lifting a finger.
3. Set **Default access** to **Installed by default**
4. Confirm

---

## Step 4 — Create a Claude project for your content work

1. In Claude, create a new **Project** — call it "Mike Kim Content"
2. In the Project settings, find **Project Knowledge**
3. Paste the contents of `docs/BRAND.md` (from this repo) into Project Knowledge — this is the brand intelligence file the skills read from

That's your brand context loaded.

---

## Step 5 — Run `define-brand-voice` first

Before using the content skills, run `define-brand-voice` inside your project. It'll refine your brand context into the exact format the other skills expect.

Then you're ready to use:
- **`plan-content`** — map a month of newsletter content
- **`write-newsletter`** — draft your weekly newsletter from the plan
- **`repurpose-content`** — cascade the newsletter across your platforms

---

## Your skills

| Skill | What it does |
|-------|-------------|
| `define-brand-voice` | Sets up and refines your brand voice in Project Knowledge |
| `plan-content` | Plans a month of content — interview-driven, tethered to your positioning |
| `write-newsletter` | Drafts your weekly newsletter in your voice from raw material |
| `repurpose-content` | Turns the newsletter into a full week of social content |

---

## Your brand files

`docs/BRAND.md` — your brand intelligence document (voice, positioning, audience, story assets)
`docs/vip-day-transcript.md` — transcript from your Category of One VIP day with Ryan Levesque

These are in this repo so they're always accessible. Add `BRAND.md` to your Claude Project Knowledge to activate the skills.

---

Questions? Text Chad.
