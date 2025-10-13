

# Flask + Svelte + PostgreSQL Application

A full-stack application with Flask backend, SvelteKit frontend, and PostgreSQL database.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Database Setup (PostgreSQL)](#database-setup-postgresql)
- [Backend Setup (Flask)](#backend-setup-flask)
- [Frontend Setup (SvelteKit)](#frontend-setup-sveltekit)
- [Running the Application](#running-the-application)
- [Common Commands](#common-commands)
- [Troubleshooting](#troubleshooting)

## 🔧 Prerequisites

Before starting, ensure you have the following installed:

- **PostgreSQL 12+** ([Download](https://www.postgresql.org/download/))
- **Anaconda or Miniconda** ([Download Anaconda](https://www.anaconda.com/download) | [Download Miniconda](https://docs.conda.io/en/latest/miniconda.html))
- **Node.js 16+** and npm ([Download](https://nodejs.org/))
- **Git** (for version control)

Verify installations:
```bash
psql --version
conda --version
node --version
npm --version
```

## 📁 Project Structure

```
project-root/
├── client/                 # SvelteKit frontend
│   ├── src/
│   ├── static/
│   ├── .env               # Frontend environment variables
│   ├── package.json
│   └── svelte.config.js
├── server/                # Flask backend
│   ├── app/
│   │   ├── config/
│   │   ├── core/
│   │   ├── postgreDB/
│   │   ├── tools/
│   │   ├── utils/
│   │   ├── .env          # Backend environment variables
│   │   └── __init__.py
│   ├── scripts/
│   ├── tests/
│   ├── requirements.txt
│   ├── run.py
│   └── setup_database.py
└── .gitignore
```

## 🗄️ Database Setup (PostgreSQL)

### Understanding PostgreSQL Databases and Users

Before we begin, let's clarify some PostgreSQL concepts:

**What is the "postgres" database?**
- `postgres` is the **default administrative database** that comes with every PostgreSQL installation
- It's used for administrative tasks and as a connection point before you create your own databases
- Think of it as the "lobby" - you connect here first, then create and manage your actual application databases

**Database vs User Relationship:**
- **Users (Roles)**: PostgreSQL authentication accounts that can log in and perform operations
- **Databases**: Separate data containers, like different filing cabinets
- **Relationship**: A user can access multiple databases, and a database can be accessed by multiple users (with appropriate permissions)
- **Ownership**: Each database has an owner (usually the user who created it or was assigned as owner)

**In our setup:**
- We create a user `tanguix_user` who will "own" our application database
- We create a database `tanguix_dev_db` specifically for our Flask application development
- We grant `tanguix_user` all privileges on `tanguix_dev_db`
- Our Flask app connects as `tanguix_user` to work with `tanguix_dev_db`

### 1. Install PostgreSQL

**macOS (using Homebrew - Recommended):**
```bash
# Install PostgreSQL server
brew install postgresql@15

# Start PostgreSQL service
brew services start postgresql@15

# Verify installation
psql --version

# Verify PostgreSQL is running
brew services list | grep postgresql
```

**⚠️ Important for macOS Homebrew users:**
When PostgreSQL is installed via Homebrew, it creates a superuser with your Mac username (NOT "postgres"). To find your username:
```bash
whoami
# Example output: xrc
```

You can connect to PostgreSQL using:
```bash
# Connect using your Mac username automatically
psql -d postgres

# Or specify your username explicitly
psql -U your_mac_username -d postgres
```

**macOS (GUI Installer):**
- Download from [PostgreSQL macOS Downloads](https://www.postgresql.org/download/macosx/)
- Download the official installer or Postgres.app
- Run installer and follow the setup wizard
- This method creates a traditional `postgres` superuser

**Windows:**
- Download installer from [PostgreSQL Downloads](https://www.postgresql.org/download/windows/)
- Run installer and follow the setup wizard
- Remember the password you set for the `postgres` user during installation

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### 2. Install pgAdmin (Optional GUI Tool)

pgAdmin is a visual database management tool that makes working with PostgreSQL easier.

**macOS:**
```bash
# Install via Homebrew
brew install --cask pgadmin4
```

**Or download directly:**
- macOS: [pgAdmin 4 for macOS](https://www.pgadmin.org/download/pgadmin-4-macos/)
- Windows: [pgAdmin 4 for Windows](https://www.pgadmin.org/download/pgadmin-4-windows/)
- Linux: [pgAdmin 4 for Linux](https://www.pgadmin.org/download/pgadmin-4-apt/)

### 3. Verify PostgreSQL Installation and Find Your Superuser

Before creating your database, let's verify everything is working:

```bash
# List all databases (this also tells you which superuser exists)
psql -l
```

You should see output like:
```
                              List of databases
   Name    | Owner | Encoding |   Collate   |    Ctype    
-----------+-------+----------+-------------+-------------
 postgres  | xrc   | UTF8     | en_US.UTF-8 | en_US.UTF-8
 template0 | xrc   | UTF8     | en_US.UTF-8 | en_US.UTF-8
 template1 | xrc   | UTF8     | en_US.UTF-8 | en_US.UTF-8
```

**Important:** Look at the **Owner** column! 
- If you see `xrc` (or your Mac username): Your superuser is your Mac username (Homebrew installation)
- If you see `postgres`: Your superuser is `postgres` (GUI installer or Windows/Linux)

**To see all users/roles:**
```bash
psql -d postgres -c "\du"
```

Output example:
```
                                   List of roles
 Role name |                         Attributes                         
-----------+------------------------------------------------------------
 xrc       | Superuser, Create role, Create DB, Replication, Bypass RLS
```

**Remember your superuser name** - you'll need it for pgAdmin!

### 4. Create Database and User

You can create your database using **either** the command line or pgAdmin GUI. Both methods are equally valid.

#### **Option A: Command Line Method (Recommended for Speed)**

**Step 1: Connect to PostgreSQL**

```bash
# Connect to default 'postgres' database
# If you're a Homebrew user (macOS), this should work automatically:
psql -d postgres

# If the above doesn't work, specify your superuser explicitly:
psql -U your_superuser_name -d postgres
# For Homebrew: psql -U xrc -d postgres
# For GUI installer: psql -U postgres
```

**Step 2: Run SQL Commands**

Once you're in the `psql` prompt (you'll see `postgres=#`), run these commands:

```sql
-- Create your application user with a secure password
-- This user will be used by your Flask application
CREATE USER tanguix_user WITH PASSWORD 'your_secure_password_here';

-- Create your development database
-- Owner is set to tanguix_user so this user has full control
CREATE DATABASE tanguix_dev_db OWNER tanguix_user;

-- Grant all privileges on the database
GRANT ALL PRIVILEGES ON DATABASE tanguix_dev_db TO tanguix_user;

-- Connect to the newly created database
\c tanguix_dev_db

-- Grant schema privileges (REQUIRED for PostgreSQL 15+)
-- The 'public' schema is where tables are created by default
GRANT ALL ON SCHEMA public TO tanguix_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tanguix_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO tanguix_user;

-- Set default privileges for future tables
-- This ensures new tables created will also be accessible
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO tanguix_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO tanguix_user;

-- Verify database was created
\l

-- Verify user was created
\du

-- Exit psql
\q
```

**What you should see after `\l`:**
```
                                    List of databases
      Name      |    Owner     | Encoding |   Collate   |    Ctype    
----------------+--------------+----------+-------------+-------------
 postgres       | xrc          | UTF8     | en_US.UTF-8 | en_US.UTF-8
 tanguix_dev_db | tanguix_user | UTF8     | en_US.UTF-8 | en_US.UTF-8  ← Your new database!
 template0      | xrc          | UTF8     | en_US.UTF-8 | en_US.UTF-8
 template1      | xrc          | UTF8     | en_US.UTF-8 | en_US.UTF-8
```

**What you should see after `\du`:**
```
                                   List of roles
 Role name    |                         Attributes                         
--------------+------------------------------------------------------------
 tanguix_user |                                                             ← Your new user!
 xrc          | Superuser, Create role, Create DB, Replication, Bypass RLS
```

**Common psql commands for reference:**
```bash
\l                          # List all databases
\c database_name            # Connect to a database
\du                         # List all users/roles
\dt                         # List all tables in current database
\d table_name               # Describe a specific table
\dn                         # List all schemas
\q                          # Quit psql
SELECT current_database();  # Show current database
SELECT current_user;        # Show current user
```

#### **Option B: pgAdmin GUI Method (Visual Step-by-Step)**

**Step 1: Launch pgAdmin**
- Open pgAdmin (first launch will ask you to create a master password for pgAdmin itself)
- This master password is just for pgAdmin, not for PostgreSQL

**Step 2: Connect to PostgreSQL Server**

1. In the left sidebar, right-click on **"Servers"**
2. Select **"Register"** → **"Server..."**

3. **General tab:**
   - Name: `Local PostgreSQL` (you can name it anything)

4. **Connection tab:**
   - Host name/address: `localhost`
   - Port: `5432`
   - Maintenance database: `postgres` (this is the default database to connect to)
   - Username: **Enter your PostgreSQL superuser name**
     - For Homebrew macOS: Use your Mac username (e.g., `xrc`)
     - For GUI installer: Usually `postgres`
     - To find yours: Run `whoami` in terminal or check the output of `psql -l` (see Owner column)
   - Password: Leave blank if you haven't set one (Homebrew default), or enter your postgres password
   - Save password: ✓ Check this box (optional, for convenience)

5. Click **"Save"**

You should now see "Local PostgreSQL" in the left sidebar with a green icon (connected).

**Step 3: Create the User (tanguix_user)**

1. In the left sidebar, expand **"Local PostgreSQL"**
2. Expand **"PostgreSQL 15"** (or your version number)
3. Right-click on **"Login/Group Roles"** → **"Create"** → **"Login/Group Role..."**

4. **General tab:**
   - Name: `tanguix_user`

5. **Definition tab:**
   - Password: `your_secure_password_here` (choose a strong password)
   - Password confirmation: Re-enter the same password
   - Account expires: Leave empty (never expires)

6. **Privileges tab:**
   - Can login?: **Toggle ON** (must be YES/ON)
   - Superuser?: Leave OFF (not needed)
   - Create roles?: Leave OFF (not needed)
   - Create databases?: **Toggle ON** (optional, useful for development)
   - Update catalog?: Leave OFF
   - Inherit rights from parent roles?: Toggle ON (default)
   - Can initiate streaming replication?: Leave OFF
   - Bypass RLS?: Leave OFF

7. Click **"Save"**

You should now see `tanguix_user` under Login/Group Roles.

**Step 4: Create the Database (tanguix_dev_db)**

1. Right-click on **"Databases"** → **"Create"** → **"Database..."**

2. **General tab:**
   - Database: `tanguix_dev_db`
   - Owner: Select **"tanguix_user"** from the dropdown
   - Comment: `Development database for Flask application` (optional)

3. **Definition tab:**
   - Encoding: `UTF8` (default)
   - Template: `template1` (default)
   - Tablespace: `pg_default` (default)
   - Collation: Leave default
   - Character type: Leave default
   - Connection limit: `-1` (unlimited, default)

4. Click **"Save"**

You should now see `tanguix_dev_db` under Databases, with owner = tanguix_user.

**Step 5: Grant Schema Privileges (CRITICAL STEP)**

This step is essential for your Flask app to create and access tables!

**Method 1: Using Properties Dialog**

1. In the left sidebar, expand **"Databases"** → **"tanguix_dev_db"** → **"Schemas"**
2. Right-click on **"public"** schema → **"Properties"**
3. Go to **"Security"** tab
4. Look for the list of privileges
5. Click the **"+"** button at the top-right of the privileges list
6. In the new row:
   - **Grantee**: Select **"tanguix_user"** from dropdown
   - **Privileges**: Check **ALL** boxes (USAGE, CREATE, etc.)
   - Or manually check: **USAGE** and **CREATE** (minimum required)
7. Click **"Save"**

**Method 2: Using Query Tool (Faster and Recommended)**

1. Right-click on **"tanguix_dev_db"** in the left sidebar
2. Select **"Query Tool"**
3. In the query editor, paste the following SQL:

```sql
-- Grant all privileges on the public schema
GRANT ALL ON SCHEMA public TO tanguix_user;

-- Grant privileges on existing tables (if any)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tanguix_user;

-- Grant privileges on sequences (for auto-incrementing IDs)
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO tanguix_user;

-- Set default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO tanguix_user;

-- Set default privileges for future sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO tanguix_user;
```

4. Click the **"Execute/Run"** button (▶️ play icon) or press **F5**
5. You should see "Query returned successfully" at the bottom

**Step 6: Verify Everything**

In the left sidebar, you should now see:

1. **Under "Login/Group Roles":**
   - `tanguix_user` ✓

2. **Under "Databases":**
   - `tanguix_dev_db` (Owner: tanguix_user) ✓

3. **Test the connection:**
   - Right-click on `tanguix_dev_db` → "Query Tool"
   - Run: `SELECT current_user, current_database();`
   - Should show: `tanguix_user` and `tanguix_dev_db`

### 5. Understanding the Connection Flow

Here's how everything connects together:

```
┌─────────────────────────────────────────────────────────┐
│ PostgreSQL Server (localhost:5432)                      │
│                                                          │
│  ┌──────────────────┐      ┌──────────────────┐       │
│  │ postgres         │      │ tanguix_dev_db   │       │
│  │ (default admin   │      │ (your app        │       │
│  │  database)       │      │  database)       │       │
│  └──────────────────┘      └──────────────────┘       │
│                                     ↑                    │
│                                     │                    │
│                                     │ owns & has full    │
│                                     │ privileges         │
│                                     │                    │
│  ┌──────────────────────────────────┴─────────┐        │
│  │ tanguix_user (database user/role)          │        │
│  │ - Can login                                 │        │
│  │ - Owns tanguix_dev_db                      │        │
│  │ - Has all privileges on tanguix_dev_db    │        │
│  └────────────────────────────────────────────┘        │
└─────────────────────────────────────────────────────────┘
                            ↑
                            │
                    reads credentials from
                            │
                   ┌────────┴─────────┐
                   │ server/app/.env  │
                   │                  │
                   │ POSTGRES_USER=   │
                   │   tanguix_user   │
                   │ POSTGRES_DB_NAME=│
                   │   tanguix_dev_db │
                   └────────┬─────────┘
                            │
                    constructs connection
                            │
              postgresql://tanguix_user:password@localhost:5432/tanguix_dev_db
                            │
                            ↓
                   ┌─────────────────┐
                   │ Flask Backend   │
                   │ (server/run.py) │
                   └─────────────────┘
```

### 6. Test Database Connection

Before proceeding to the backend setup, verify you can connect to your new database:

```bash
# Test connection as tanguix_user to tanguix_dev_db
psql -U tanguix_user -d tanguix_dev_db -h localhost

# You'll be prompted for password (enter the password you set)
```

If successful, you should see:
```
Password for user tanguix_user: 
psql (15.x)
Type "help" for help.

tanguix_dev_db=>
```

**Test a few commands:**
```sql
-- Check current connection info
SELECT current_user, current_database();

-- Should show:
--  current_user | current_database 
-- --------------+------------------
--  tanguix_user | tanguix_dev_db

-- List tables (should be empty for now)
\dt

-- Exit
\q
```

✅ **Database setup is complete!** You're now ready to configure your Flask backend.

## 🐍 Backend Setup (Flask)

Now that your database is ready, let's set up the Flask backend to connect to it.

### 1. Configure Backend Environment Variables

Create `server/app/.env` file with the following content:

```env
# ================================
# PostgreSQL Database Configuration
# ================================
# These values MUST match what you created in PostgreSQL!

# Database server location (usually localhost for development)
POSTGRES_HOST=localhost

# PostgreSQL default port
POSTGRES_PORT=5432

# Database user we created (tanguix_user)
POSTGRES_USER=tanguix_user

# Password you set when creating tanguix_user
# ⚠️ IMPORTANT: Use the EXACT password you set in Step 4
POSTGRES_PASSWORD=your_secure_password_here

# Database name we created for development
# ⚠️ We use tanguix_dev_db specifically for application development
POSTGRES_DB_NAME=tanguix_dev_db

# ================================
# Application Configuration
# ================================
# Flask secret key (change in production!)
SECRET_KEY=your-super-secret-key-change-in-production

# Debug mode (set to False in production)
DEBUG=True
TESTING=False

# Environment mode
FLASK_ENV=development

# Logging level (DEBUG, INFO, WARNING, ERROR)
LOG_LEVEL=INFO

# ================================
# Frontend Configuration
# ================================
# Primary frontend URL (for CORS)
FRONTEND_URL=http://localhost:5173

# Multiple frontend URLs (comma-separated for different environments)
FRONTEND_URLS=http://localhost:5173,http://localhost:3000,http://localhost:4173,http://127.0.0.1:5173

# Production frontend URL (update before deploying)
PRODUCTION_URL=https://your-production-domain.com

# Staging frontend URL
STAGING_URL=https://staging.your-domain.com

# Backend IP (fixed for consistent backend URL)
# To find your local IP: hostname -I (Linux) or ipconfig (Windows) or ifconfig (macOS)
LOCAL_IP=192.168.110.52

# ================================
# Database Management
# ================================
# Automatically create tables on startup
AUTO_CREATE_TABLES=True

# Initialize with sample data (useful for development)
INIT_SAMPLE_DATA=False

# ================================
# Email Configuration
# ================================
# Email password for sending notifications (if using email features)
MAIL_PASSWORD=your_fastmail_app_password_here

# ================================
# Security
# ================================
# Admin token (optional, for admin operations)
ADMIN_TOKEN=your_admin_token_here

# ================================
# Directory Configuration
# ================================
# Base directory for the application
# Default is ~/appdev if not specified
BASE_HOST_DIR=/Users/yourusername/appdev

# ================================
# Production Settings (Update before deploying)
# ================================
# For production deployment, update these:
# DEBUG=False
# TESTING=False
# FLASK_ENV=production
# AUTO_CREATE_TABLES=False
# INIT_SAMPLE_DATA=False
# SECRET_KEY=your-production-secret-key
# LOG_LEVEL=WARNING
# FRONTEND_URL=https://your-production-domain.com
# FRONTEND_URLS=https://your-production-domain.com
```

**⚠️ CRITICAL: Verify These Values Match Your PostgreSQL Setup**

| Environment Variable | What to Enter | Example |
|---------------------|---------------|---------|
| `POSTGRES_HOST` | Database server location | `localhost` (for local development) |
| `POSTGRES_PORT` | PostgreSQL port | `5432` (default PostgreSQL port) |
| `POSTGRES_USER` | Database user you created | `tanguix_user` (MUST match Step 4) |
| `POSTGRES_PASSWORD` | Password you set for tanguix_user | `your_secure_password_here` |
| `POSTGRES_DB_NAME` | Database name you created | `tanguix_dev_db` (for development) |

**How Flask uses these values:**
1. Flask reads `server/app/.env` on startup
2. Constructs connection string: `postgresql://tanguix_user:your_password@localhost:5432/tanguix_dev_db`
3. SQLAlchemy uses this to connect to PostgreSQL
4. All database operations happen within `tanguix_dev_db`

**Security Notes:**
- Never commit `.env` to git (already in `.gitignore`)
- Use strong passwords for `POSTGRES_PASSWORD`
- Change `SECRET_KEY` before production
- Keep all credentials secure

### 2. Navigate to Server Directory

```bash
cd server
```

### 3. Create Conda Environment

```bash
# Create a new conda environment with Python 3.10
conda create -n flask-app python=3.10 -y

# Activate the environment
conda activate flask-app
```

**Note:** Replace `flask-app` with your preferred environment name.

### 4. Install Dependencies

```bash
# Install from requirements.txt
pip install -r requirements.txt
```

**Alternative - Install major packages via conda first (optional but recommended):**
```bash
# Install major packages via conda
conda install flask sqlalchemy psycopg2 -y

# Then install remaining packages via pip
pip install -r requirements.txt
```

### 5. Verify Installation

```bash
# Check installed packages
pip list

# Or use conda
conda list

# Verify psycopg2 is installed (PostgreSQL adapter for Python)
python -c "import psycopg2; print('psycopg2 version:', psycopg2.__version__)"
```

### 6. Initialize Database Tables

Now that your Flask environment is set up and `.env` is configured, initialize your database schema:

```bash
# Make sure you're in the server directory
cd server

# Make sure conda environment is activated
conda activate flask-app

# Run database setup script
python setup_database.py
```

**What this script does:**
1. Reads credentials from `server/app/.env`
2. Connects to PostgreSQL as `tanguix_user`
3. Connects to `tanguix_dev_db` database
4. Creates all necessary tables based on your models
5. Optionally initializes sample data (if `INIT_SAMPLE_DATA=True`)

**Expected output:**
```
Connecting to database...
Connected successfully!
Creating tables...
Tables created successfully!
Database initialization complete.
```

**Verify tables were created:**

```bash
# Connect to database
psql -U tanguix_user -d tanguix_dev_db -h localhost

# Inside psql, list all tables
\dt

# You should see your application tables listed
# Describe a specific table
\d table_name

# Exit
\q
```

### 7. Run Backend Server

```bash
# Make sure conda environment is activated
conda activate flask-app

# Run the Flask application
python run.py
```

**Expected output:**
```
 * Serving Flask app 'app'
 * Debug mode: on
WARNING: This is a development server. Do not use it in a production deployment.
 * Running on http://localhost:5000
Press CTRL+C to quit
```

The backend should now be running at `http://localhost:5000` (or your configured IP).

**Test the backend:**
```bash
# In another terminal
curl http://localhost:5000

# Or open in browser: http://localhost:5000
```

✅ **Backend setup is complete!**

## 🎨 Frontend Setup (SvelteKit)

### 1. Configure Frontend Environment Variables

Create `client/.env` file:

```env
# Backend API URL
# ⚠️ Update this with your actual backend IP address and port
VITE_BACKEND_HOST=http://192.168.110.52:5000

# Or use localhost for local development
# VITE_BACKEND_HOST=http://localhost:5000

# Frontend host (optional, for reference)
# VITE_FRONTEND_HOST=http://localhost:5173
```

**⚠️ IMPORTANT: Two Separate .env Files Required**

This project uses **TWO** `.env` files:
1. `client/.env` - Frontend configuration (Vite/SvelteKit)
2. `server/app/.env` - Backend configuration (Flask/PostgreSQL)

**Note:** 
- `VITE_` prefix is **required** for SvelteKit to expose variables to the browser
- Update the IP address to match your backend server IP
- For local development, `http://localhost:5000` is fine
- Port 5000 is the default Flask port

### 2. Navigate to Client Directory

```bash
cd client
```

### 3. Install Dependencies

```bash
npm install
```

### 4. Run Development Server

```bash
npm run dev
```

**Expected output:**
```
  VITE v5.x.x  ready in xxx ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: http://192.168.x.x:5173/
  ➜  press h + enter to show help
```

The frontend should now be running at `http://localhost:5173`.

### 5. Access the Application

Open your browser and navigate to:
```
http://localhost:5173
```

You should see your SvelteKit application. It will make API calls to your Flask backend at the URL specified in `client/.env`.

✅ **Frontend setup is complete!**

## 🚀 Running the Application

### Development Mode

You need **two terminal windows/tabs** running simultaneously:

**Terminal 1 - Backend (Flask):**
```bash
cd server
conda activate flask-app
python run.py
```

**Terminal 2 - Frontend (SvelteKit):**
```bash
cd client
npm run dev
```

### Accessing the App

- **Frontend UI:** http://localhost:5173
- **Backend API:** http://localhost:5000 (or your configured IP)
- **Database:** Accessed via Flask backend using `tanguix_user` → `tanguix_dev_db`
- **pgAdmin:** Manage database visually (if installed)

### Complete System Overview

```
┌──────────────────────────────────────────────────────────────┐
│                     Your Computer                            │
│                                                              │
│  ┌────────────────┐    HTTP Requests    ┌──────────────┐  │
│  │   Browser      │ ←─────────────────→ │   SvelteKit  │  │
│  │ localhost:5173 │                      │   Frontend   │  │
│  └────────────────┘                      │  (client/)   │  │
│                                           └──────┬───────┘  │
│                                                  │          │
│                                           API calls         │
│                                           (VITE_BACKEND)    │
│                                                  │          │
│                                                  ↓          │
│                                           ┌──────────────┐  │
│                                           │    Flask     │  │
│                                           │   Backend    │  │
│                                           │  localhost   │  │
│                                           │    :5000     │  │
│                                           │  (server/)   │  │
│                                           └──────┬───────┘  │
│                                                  │          │
│                                      reads server/app/.env  │
│                                      POSTGRES_USER          │
│                                      POSTGRES_PASSWORD      │
│                                      POSTGRES_DB_NAME       │
│                                                  │          │
│                                   SQL queries/connection    │
│                                                  ↓          │
│                                           ┌──────────────┐  │
│                                           │ PostgreSQL   │  │
│                                           │   Server     │  │
│                                           │ localhost    │  │
│                                           │   :5432      │  │
│                                           │              │  │
│                                           │ Database:    │  │
│                                           │ tanguix_     │  │
│                                           │  dev_db      │  │
│                                           └──────────────┘  │
└──────────────────────────────────────────────────────────────┘
```

## 📝 Common Commands

### Database Commands

```bash
# Connect to your application database
psql -U tanguix_user -d tanguix_dev_db -h localhost

# Connect to default postgres database (admin tasks)
psql -d postgres

# List all databases
psql -l

# Backup your database
pg_dump -U tanguix_user -d tanguix_dev_db > backup_$(date +%Y%m%d).sql

# Restore from backup
psql -U tanguix_user -d tanguix_dev_db < backup_20241013.sql

# Drop and recreate database (⚠️ deletes all data!)
psql -d postgres -c "DROP DATABASE tanguix_dev_db;"
psql -d postgres -c "CREATE DATABASE tanguix_dev_db OWNER tanguix_user;"
```

**Common SQL queries inside psql:**
```sql
-- List all tables
\dt

-- Describe table structure
\d table_name

-- Show current database and user
SELECT current_database(), current_user;

-- Count rows in a table
SELECT COUNT(*) FROM table_name;

-- View recent records
SELECT * FROM table_name ORDER BY created_at DESC LIMIT 10;

-- List all users and their roles
\du

-- Show table sizes
\dt+

-- Quit psql
\q
```

### Backend (Flask) Commands

```bash
# Activate conda environment (always do this first!)
conda activate flask-app

# Run development server
python run.py

# Install new package
pip install package-name
pip freeze > requirements.txt  # Update requirements.txt

# Or install via conda (preferred when available)
conda install package-name -y

# Reinstall all dependencies
pip install -r requirements.txt

# List all installed packages
conda list
pip list

# Export environment for reproducibility
conda env export > environment.yml

# Create environment from exported file
conda env create -f environment.yml

# Remove and recreate conda environment (clean slate)
conda deactivate
conda env remove -n flask-app
conda create -n flask-app python=3.10 -y
conda activate flask-app
pip install -r requirements.txt

# Run database initialization
python setup_database.py

# Run tests (if available)
python -m pytest tests/

# Check Python version in environment
python --version

# Deactivate conda environment
conda deactivate

# List all conda environments
conda env list
```

### Frontend (SvelteKit) Commands

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Run dev server with network access (access from other devices)
npm run dev -- --host

# Build for production
npm run build

# Preview production build
npm run preview

# Type-check the project
npm run check

# Run linting
npm run lint

# Format code with Prettier
npm run format

# Clean reinstall (if packages are corrupted)
rm -rf node_modules package-lock.json .svelte-kit
npm install

# Update all packages to latest versions
npm update

# Check for outdated packages
npm outdated

# Install a specific package
npm install package-name

# Uninstall a package
npm uninstall package-name
```

## 🐛 Troubleshooting

### Database Issues

**"role 'postgres' does not exist" error (macOS Homebrew):**

This is very common with Homebrew PostgreSQL installations. Homebrew creates a superuser with your Mac username instead of "postgres".

**Solution 1: Use your Mac username**
```bash
# Find your username
whoami

# Connect with your Mac username
psql -d postgres

# Or specify it explicitly
psql -U your_mac_username -d postgres
```

In pgAdmin, use your Mac username instead of "postgres" when connecting.

**Solution 2: Create the "postgres" superuser**
```bash
# Connect with your Mac username first
psql -d postgres

# Create postgres role
CREATE ROLE postgres WITH SUPERUSER CREATEDB CREATEROLE LOGIN;
ALTER ROLE postgres WITH PASSWORD 'your_password';

# Exit
\q
```

**"database 'tanguix_dev_db' does not exist" error:**

The database wasn't created or was deleted.

```bash
# Connect as superuser
psql -d postgres

# Create the database
CREATE DATABASE tanguix_dev_db OWNER tanguix_user;
GRANT ALL PRIVILEGES ON DATABASE tanguix_dev_db TO tanguix_user;

# Exit and test
\q
psql -U tanguix_user -d tanguix_dev_db -h localhost
```

**"role 'tanguix_user' does not exist" error:**

The user wasn't created.

```bash
# Connect as superuser
psql -d postgres

# Create the user
CREATE USER tanguix_user WITH PASSWORD 'your_secure_password';
GRANT ALL PRIVILEGES ON DATABASE tanguix_dev_db TO tanguix_user;

# Exit
\q
```

**"permission denied for schema public" error:**

The user doesn't have proper schema privileges.

```bash
# Connect as superuser to your database
psql -d tanguix_dev_db

# Grant privileges
GRANT ALL ON SCHEMA public TO tanguix_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tanguix_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO tanguix_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO tanguix_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO tanguix_user;

# Exit
\q
```

**"password authentication failed for user 'tanguix_user'" error:**

The password in `server/app/.env` doesn't match what you set in PostgreSQL.

```bash
# Reset the password
psql -d postgres

# Change password
ALTER USER tanguix_user WITH PASSWORD 'new_password';

# Update server/app/.env with the new password
# POSTGRES_PASSWORD=new_password
```

**Cannot connect to PostgreSQL:**

```bash
# Check if PostgreSQL is running
brew services list | grep postgresql  # macOS
sudo systemctl status postgresql      # Linux
# Windows: Check Services app

# Start PostgreSQL if not running
brew services start postgresql@15     # macOS
sudo systemctl start postgresql       # Linux

# Check if PostgreSQL is listening on port 5432
lsof -i :5432  # macOS/Linux
netstat -an | findstr 5432  # Windows
```

### Backend Issues

**Import errors / Module not found:**
```bash
# Make sure conda environment is activated
conda activate flask-app
conda env list  # Check which environment is active

# Reinstall dependencies
pip install -r requirements.txt

# Check if psycopg2 is installed
python -c "import psycopg2; print(psycopg2.__version__)"
```

**"No module named 'app'" or similar:**
```bash
# Make sure you're in the server directory
cd server

# Check if __init__.py exists
ls app/__init__.py

# Try running with Python path
PYTHONPATH=. python run.py
```

**Port 5000 already in use:**
```bash
# Find process using port 5000
lsof -i :5000  # macOS/Linux
netstat -ano | findstr :5000  # Windows

# Kill the process
kill -9 <PID>  # macOS/Linux
taskkill /PID <PID> /F  # Windows

# Or change port in your Flask config
```

**Database connection error in Flask:**

1. Verify PostgreSQL is running
2. Check `server/app/.env` credentials match your PostgreSQL setup
3. Test connection manually:
   ```bash
   psql -U tanguix_user -d tanguix_dev_db -h localhost
   ```
4. Check Flask logs for specific error messages

**Environment variables not loading:**
- Ensure `.env` file is in `server/app/` directory
- Check for typos in variable names
- Restart Flask server after changing `.env`
- Verify `python-dotenv` is installed: `pip list | grep dotenv`

### Frontend Issues

**Cannot connect to backend / CORS errors:**

1. Verify backend is running at the URL in `client/.env`
2. Check `VITE_BACKEND_HOST` matches your backend URL
3. Test backend directly: `curl http://localhost:5000`
4. Check Flask CORS configuration
5. Check browser console for specific error messages

**Port 5173 already in use:**
```bash
# Kill process on port 5173
npx kill-port 5173

# Or find and kill manually
lsof -i :5173  # macOS/Linux
kill -9 <PID>
```

**Build errors / Module not found:**
```bash
# Clear caches and reinstall
rm -rf node_modules .svelte-kit package-lock.json
npm install

# Try building again
npm run build
```

**Environment variables not working:**
- Frontend variables MUST have `VITE_` prefix
- Restart dev server after changing `client/.env`
- Check browser console: `import.meta.env.VITE_BACKEND_HOST`

### General Issues

**Forgot which database/user you created:**
```bash
# List all databases
psql -l

# List all users
psql -d postgres -c "\du"

# Check current connection
psql -U tanguix_user -d tanguix_dev_db -c "SELECT current_database(), current_user;"
```

**Need to start fresh (reset everything):**

⚠️ **WARNING: This deletes all data!**

```bash
# Drop database
psql -d postgres -c "DROP DATABASE IF EXISTS tanguix_dev_db;"

# Drop user
psql -d postgres -c "DROP USER IF EXISTS tanguix_user;"

# Now recreate from Step 4 in Database Setup
```

## 📌 Important Notes

1. **Two .env files required** - `client/.env` and `server/app/.env` must both be configured
2. **Database naming** - Use `tanguix_dev_db` for development, create separate databases for testing/production
3. **Never commit .env files** - They contain sensitive credentials and are in `.gitignore`
4. **Activate conda environment** - Always run `conda activate flask-app` before backend commands
5. **Password security** - Use strong passwords and change defaults in production
6. **Homebrew PostgreSQL** - Default superuser is your Mac username, not "postgres"
7. **Schema privileges** - Don't forget Step 5 in database setup (granting schema privileges)
8. **Environment variable names** - Must match exactly between PostgreSQL and `.env` files
9. **Frontend variables** - Must have `VITE_` prefix in SvelteKit
10. **Regular backups** - Backup your database regularly, especially before major changes
11. **Default postgres database** - Don't use it for your application, it's for administration only
12. **Port conflicts** - Make sure ports 5000 (Flask), 5173 (Vite), and 5432 (PostgreSQL) are available

## 🔗 Useful Resources

- [Flask Documentation](https://flask.palletsprojects.com/)
- [SvelteKit Documentation](https://kit.svelte.dev/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
- [psql Command Reference](https://www.postgresql.org/docs/current/app-psql.html)
- [pgAdmin Documentation](https://www.pgadmin.org/docs/)
- [SQLAlchemy Documentation](https://docs.sqlalchemy.org/)
- [Vite Environment Variables](https://vitejs.dev/guide/env-and-mode.html)
- [Conda Cheat Sheet](https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html)

## 🎓 Quick Reference

### PostgreSQL Concepts

- **postgres database**: Default admin database (connect here to create other databases)
- **tanguix_dev_db**: Your application database (stores all your app data for development)
- **tanguix_user**: Your application user (Flask connects as this user)
- **Schema**: Namespace within a database (default is `public`)
- **Role**: PostgreSQL term for users and groups
- **Superuser**: Admin account with all privileges (e.g., `postgres` or your Mac username)

### Connection String Format

```
postgresql://[user]:[password]@[host]:[port]/[database]

Example:
postgresql://tanguix_user:mypassword@localhost:5432/tanguix_dev_db
```

### Port Reference

- **5432**: PostgreSQL default port
- **5000**: Flask backend default port
- **5173**: Vite/SvelteKit dev server default port

### Key File Locations

- Backend config: `server/app/.env`
- Frontend config: `client/.env`
- Flask app: `server/run.py`
- Database setup: `server/setup_database.py`
- Requirements: `server/requirements.txt`

### Environment Variables Summary

**Backend (`server/app/.env`):**
- `POSTGRES_USER=tanguix_user` - Database user
- `POSTGRES_PASSWORD=your_password` - Database password
- `POSTGRES_DB_NAME=tanguix_dev_db` - Database name
- `POSTGRES_HOST=localhost` - Database host
- `POSTGRES_PORT=5432` - Database port

**Frontend (`client/.env`):**
- `VITE_BACKEND_HOST=http://localhost:5000` - Backend API URL

---

**Last Updated:** October 2025
**Version:** 2.0 (Database-First Setup Guide)



