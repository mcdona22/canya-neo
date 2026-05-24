# canya_mobile

## Development Environment Setup

Every time you restart your macOS environment, you need to spin up the local
Graph Bridge gateway and the Flutter reactive code-generation background
daemons. Follow the instructions below across separate Terminal tabs.

---

### Terminal 1: Graph Bridge & Aurora Credentials

Navigate to your Node.js backend directory to inject the temporary cluster
authentication tokens into your shell instance and boot the gateway bridge.

```bash
# 1. Export local Aurora cluster connection strings
export AURORA_DB_USER="your_username"
export AURORA_DB_PASSWORD="your_password"
export AURORA_DB_HOST="your-aurora-cluster-endpoint"
export AURORA_DB_PORT="5432"

# 2. Fire up the backend gateway process
npm run start

# Run from your root Flutter project directory
flutter pub run build_runner watch --delete-conflicting-outputs