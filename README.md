# ⚓ Anchor — AI-Powered Protection for OFWs

Anchor is a comprehensive AI-powered protection platform for **Overseas Filipino Workers (OFWs)**. It enables workers to verify job offers, analyze employment contracts through AI, receive real-time safety alerts, and connect with a trusted OFW community.

---

## 📁 Repository Structure

```
anchor/
├── ai-services/         # AI model integrations & services
├── docs/                # Architecture & API documentation
├── firebase/            # Firebase Cloud Functions & security rules
├── mobile/              # Flutter mobile application (Android & iOS)
├── web/                 # React admin/NGO web platform
├── firebase.json
├── package.json
└── README.md
```

---

## 🚀 Tech Stack

| Layer                  | Technology                                      |
| ---------------------- | ----------------------------------------------- |
| **Mobile**             | Flutter (Dart)                                  |
| **Web**                | React + TypeScript + Vite + TailwindCSS         |
| **Auth**               | Firebase Authentication (Email + Google)        |
| **Database**           | Cloud Firestore                                 |
| **Storage**            | Firebase Storage                                |
| **Functions**          | Firebase Cloud Functions (Node.js / TypeScript) |
| **Hosting**            | Firebase Hosting                                |
| **Push Notifications** | Firebase Cloud Messaging (FCM)                  |
| **AI**                 | OpenAI API / Google Gemini API                  |

---

## ⚙️ Prerequisites

Make sure the following are installed on your machine:

- [Node.js](https://nodejs.org/) >= 18.x
- [npm](https://npmjs.com/) >= 9.x
- [Flutter SDK](https://flutter.dev/docs/get-started/install) >= 3.19.x
- [Dart SDK](https://dart.dev/get-dart) >= 3.3.x
- [Firebase CLI](https://firebase.google.com/docs/cli) >= 13.x
- [Git](https://git-scm.com/)

---

## 🏁 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/anchor.git
cd anchor
```

### 2. Install Root & Web Dependencies

```bash
npm install
```

### 3. Configure Environment Variables

Copy the example env files and fill in your credentials:

```bash
# Root-level Firebase config
cp .env.example .env

# Web platform
cp web/.env.example web/.env.local

# Firebase Functions
cp firebase/functions/.env.example firebase/functions/.env
```

### 4. Set Up Firebase

```bash
# Login to Firebase
firebase login

# Initialize your Firebase project (or link existing)
firebase use --add

# Deploy Firestore & Storage rules
npm run deploy:rules
```

---

## 📱 Mobile App (Flutter)

### Setup

```bash
cd mobile
flutter pub get
```

### Configure Firebase for Flutter

1. Go to [Firebase Console](https://console.firebase.google.com/) → your project → Add App (Android/iOS)
2. Download `google-services.json` → place at `mobile/android/app/`
3. Download `GoogleService-Info.plist` → place at `mobile/ios/Runner/`
4. Run FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

### Run

```bash
cd mobile

# Run on connected device/emulator
flutter run

# Run on specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

### Build

```bash
# Android APK (from mobile/)
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 🌐 Web Platform (React)

### Setup

```bash
cd web
npm install
```

### Run Development Server

```bash
cd web
npm run dev
# Runs at http://localhost:5173
```

### Build for Production

```bash
cd web
npm run build
```

### Preview Production Build

```bash
cd web
npm run preview
```

---

## ☁️ Firebase Functions

### Setup

```bash
cd firebase/functions
npm install
```

### Run Locally (Emulator)

```bash
# From root
npm run emulators
```

### Deploy Functions

```bash
npm run deploy:functions
```

---

## 🚢 Deployment

### Deploy Everything

```bash
npm run deploy
```

### Deploy Individually

```bash
# Web hosting only
npm run deploy:hosting

# Functions only
npm run deploy:functions

# Firestore & Storage rules only
npm run deploy:rules
```

---

## 🔥 Firebase Emulator Suite

Run the full local emulator suite for development:

```bash
npm run emulators
```

Access emulator UIs:

- **Emulator Hub**: http://localhost:4000
- **Firestore**: http://localhost:8080
- **Auth**: http://localhost:9099
- **Functions**: http://localhost:5001
- **Storage**: http://localhost:9199
- **Hosting**: http://localhost:5000

---

## 🛡️ Firestore Collections Schema

| Collection  | Key Fields                                                           |
| ----------- | -------------------------------------------------------------------- |
| `users`     | `id`, `name`, `country`, `role` (ofw/admin)                          |
| `contracts` | `user_id`, `file_url`, `ai_risk_score`, `risk_summary`, `created_at` |
| `jobs`      | `title`, `employer`, `country`, `verified`, `risk_score`             |
| `reports`   | `user_id`, `job_id`, `description`, `risk_level`                     |
| `posts`     | `user_id`, `content`, `created_at`                                   |
| `alerts`    | `title`, `description`, `country`, `created_at`                      |

---

## 🤖 AI Cloud Functions

| Function              | Description                                                                 |
| --------------------- | --------------------------------------------------------------------------- |
| `analyzeContract`     | Receives uploaded contract → sends to AI API → returns risk score & summary |
| `verifyJob`           | AI scans job details → flags potential scams                                |
| `generateSafetyAlert` | Summarizes community reports → posts safety alerts                          |

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

MIT License — see [LICENSE](./LICENSE) for details.

---

## 📞 Support

For support, contact the Anchor team or open an issue on GitHub.

> Built with ❤️ for the Filipino diaspora.
