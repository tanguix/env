# Flask + Svelte + PostgreSQL Application

A full-stack application with Flask backend, SvelteKit frontend, and PostgreSQL database.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Database Setup (PostgreSQL)](#database-setup-postgresql)
- [Environment Configuration](#environment-configuration)
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
│   ├── .env               # ⚠️ Frontend environment variables (YOU MUST CREATE THIS)
│   ├── package.json
│   └── svelte.config.js
├── server/                # Flask backend
│   ├── app/
│   │   ├── config/
│   │   ├── core/
│   │   ├── postgreDB/
│   │   ├── tools/
│   │   ├── utils/
│   │   ├── .env          # ⚠️ Backend environment variables (YOU MUST CREATE THIS)
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

**Remember your superuser name** - you'll need it for pgAdmin and database creation!

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
-- ⚠️ IMPORTANT: You MUST set a password - PostgreSQL requires authentication
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

#### **Option B: pgAdmin GUI Method (Visual Step-by-Step)**

**Step 1: Launch pgAdmin**
- Open pgAdmin (first launch will ask you to create a master password for pgAdmin itself)

**Step 2: Connect to PostgreSQL Server**

1. In the left sidebar, right-click on **"Servers"**
2. Select **"Register"** → **"Server..."**

3. **General tab:** 
   - Name = `Local PostgreSQL` (you can name it anything)

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
   - **⚠️ CRITICAL: Remember this password! You will need it in `server/app/.env`**

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

**Important Notes:**
- The password is set in the **"Definition"** tab, not the "Security" tab
- PostgreSQL **requires** a password for authentication by default
- This password must **exactly match** what you put in `server/app/.env` later

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

**Method: Using Query Tool (Recommended)**

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

### 5. Test Database Connection

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

✅ **Database setup is complete!** You're now ready to configure your backend.

## 🔐 Environment Configuration

### ⚠️ CRITICAL: Create TWO Environment Files

This project requires **TWO separate `.env` files** - one for frontend and one for backend. **You MUST create both files manually.**

---

### 1. Frontend Environment File

**📍 Location:** `client/.env`

**⚠️ YOU MUST CREATE THIS FILE MANUALLY**

Create a new file at `client/.env` and add this single line:

```env
VITE_BACKEND_HOST=http://localhost:5000
```

**That's it!** The frontend only needs to know where the backend is.

**Notes:**
- `VITE_` prefix is **REQUIRED** for SvelteKit to expose the variable to the browser
- Use `http://localhost:5000` for local development
- Update to your backend's IP if accessing from another device (e.g., `http://192.168.1.100:5000`)

**Common mistake:** Forgetting to create this file will cause frontend errors like:
```
GET http://localhost:5173/undefined/auth/public/login 404 (Not Found)
```

---

### 2. Backend Environment File

**📍 Location:** `server/app/.env`

**⚠️ YOU MUST CREATE THIS FILE MANUALLY**

Create a new file at `server/app/.env` with the following content:

```env
# ================================
# PostgreSQL Database Configuration
# ================================
# ⚠️ These values MUST match what you created in PostgreSQL!

# Database server location (usually localhost for development)
POSTGRES_HOST=localhost

# PostgreSQL default port
POSTGRES_PORT=5432

# Database user you created (must match Step 4 in database setup)
POSTGRES_USER=tanguix_user

# Password you set when creating tanguix_user
# ⚠️ CRITICAL: Use the EXACT password you set in PostgreSQL
POSTGRES_PASSWORD=your_secure_password_here

# Database name you created for development
# We use tanguix_dev_db specifically for application development
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

# Backend IP (for network access)
# To find your local IP: hostname -I (Linux) or ipconfig (Windows) or ifconfig (macOS)
LOCAL_IP=192.168.1.100

# ================================
# Database Management
# ================================
# Automatically create tables on startup
AUTO_CREATE_TABLES=True

# Initialize with sample data (useful for development)
INIT_SAMPLE_DATA=False

# ================================
# Email Configuration (Optional)
# ================================
# Email password for sending notifications (if using email features)
MAIL_PASSWORD=your_fastmail_app_password_here

# ================================
# Security (Optional)
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

---

### ⚠️ Configuration Checklist

Before proceeding, verify:

- [ ] `client/.env` exists with `VITE_BACKEND_HOST`
- [ ] `server/app/.env` exists with all database credentials
- [ ] `POSTGRES_PASSWORD` in `server/app/.env` matches the password you set in PostgreSQL
- [ ] `POSTGRES_USER` is `tanguix_user`
- [ ] `POSTGRES_DB_NAME` is `tanguix_dev_db`
- [ ] Both `.env` files are in `.gitignore` (never commit them!)

**How to verify database credentials match:**

```bash
# Try connecting with the credentials from your .env
psql -U tanguix_user -d tanguix_dev_db -h localhost
# If prompted, enter the password from POSTGRES_PASSWORD
# If it works, your credentials are correct!
```

---

### 🔒 Security Notes

- **Never commit `.env` files to git** - They contain sensitive credentials
- `.env` files should already be in `.gitignore`
- Use strong passwords for `POSTGRES_PASSWORD` in production
- Change `SECRET_KEY` before production deployment
- Keep `ADMIN_TOKEN` and `MAIL_PASSWORD` secure

## 🐍 Backend Setup (Flask)

Now that your database and environment files are configured, let's set up the Flask backend.

### 1. Navigate to Server Directory

```bash
cd server
```

### 2. Create Conda Environment

```bash
# Create a new conda environment with Python 3.10
conda create -n flask-app python=3.10 -y

# Activate the environment
conda activate flask-app
```

**Note:** Replace `flask-app` with your preferred environment name.

### 3. Install Dependencies

```bash
# Install Flask-SQLAlchemy (REQUIRED - without this you'll get mock db errors)
pip install Flask-SQLAlchemy

# Install all other dependencies from requirements.txt
pip install -r requirements.txt
```

**Alternative - Install major packages via conda first (optional but recommended):**
```bash
# Install major packages via conda
conda install flask sqlalchemy psycopg2 -y

# Then install remaining packages via pip
pip install -r requirements.txt
```

### 4. Verify Installation

```bash
# Check installed packages
pip list

# Or use conda
conda list

# Verify Flask-SQLAlchemy is installed (CRITICAL)
python -c "import flask_sqlalchemy; print('Flask-SQLAlchemy version:', flask_sqlalchemy.__version__)"

# Verify psycopg2 is installed (PostgreSQL adapter for Python)
python -c "import psycopg2; print('psycopg2 version:', psycopg2.__version__)"
```

**If Flask-SQLAlchemy is not installed, you'll see errors like:**
```
[DEBUG] Flask-SQLAlchemy not available, creating mock db object
Error finding user by username admin: 'NoneType' object has no attribute 'query'
```

### 5. Initialize Database Tables

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
5. Creates a default admin user with username `admin` and password `iamyourfather`

**Expected output:**
```
✅ PostgreSQL is running (admin user: xrc)
🔧 Creating PostgreSQL user: tanguix_user
✅ User 'tanguix_user' created successfully with password
🔧 Creating database: tanguix_dev_db
✅ Database 'tanguix_dev_db' created successfully
✅ Schema privileges granted successfully
🧪 Testing connection as application user 'tanguix_user'...
✅ Connection successful!
🎉 Database setup completed successfully!
```

**Verify tables were created:**

```bash
# Connect to database
psql -U tanguix_user -d tanguix_dev_db -h localhost

# Inside psql, list all tables
\dt

# Check the default admin user
SELECT username, role, status FROM auth.users WHERE username = 'admin';

# You should see:
#  username | role  | status 
# ----------+-------+--------
#  admin    | ADMIN | active

# Exit
\q
```

### 6. Run Backend Server

```bash
# Make sure conda environment is activated
conda activate flask-app

# Run the Flask application
python run.py
```

**Expected output:**
```
======================================================================
🌐 CORS Configuration - Network Origins
======================================================================
✓ FRONTEND_URLS found: 4 origins
  - http://localhost:5173
  - http://localhost:3000
  - http://localhost:4173
  - http://127.0.0.1:5173
----------------------------------------------------------------------
📋 Total CORS origins allowed: 7
🖥️  Backend will be accessible at: http://127.0.0.1:5000
======================================================================

 * Serving Flask app 'app'
 * Debug mode: on
 * Running on http://127.0.0.1:5000
 * Running on http://192.168.x.x:5000
```

The backend should now be running at `http://localhost:5000`.

**Test the backend:**
```bash
# In another terminal
curl http://localhost:5000/auth/public/health

# Or open in browser: http://localhost:5000/auth/public/health
```

✅ **Backend setup is complete!**

### 7. Default Login Credentials

After initialization, you can login with:
- **Username:** `admin`
- **Password:** `iamyourfather`

**⚠️ Important:** Change this password immediately after first login in production!

## 🎨 Frontend Setup (SvelteKit)

### 1. Navigate to Client Directory

```bash
cd client
```

### 2. Verify Environment File Exists

**⚠️ CRITICAL CHECK:**

```bash
# Check if .env exists
ls -la .env

# If it doesn't exist, CREATE IT NOW:
echo "VITE_BACKEND_HOST=http://localhost:5000" > .env

# Verify it was created correctly
cat .env
# Should show: VITE_BACKEND_HOST=http://localhost:5000
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

You should see your SvelteKit application login page.

**Test the login:**
- Username: `admin`
- Password: `iamyourfather`

If you see errors like `GET http://localhost:5173/undefined/auth/public/login`, it means `client/.env` is missing or incorrect!

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
- **Backend API:** http://localhost:5000
- **Database:** Accessed via Flask backend using `tanguix_user` → `tanguix_dev_db`
- **pgAdmin:** Manage database visually (if installed)

### Default Login Credentials

- **Username:** `admin`
- **Password:** `iamyourfather`

### Complete System Architecture

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
│                                         reads client/.env   │
│                                         VITE_BACKEND_HOST   │
│                                                  │          │
│                                           API calls         │
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

-- Check admin user
SELECT username, role, status FROM auth.users WHERE username = 'admin';

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
pip install Flask-SQLAlchemy
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

### Environment File Issues

**"undefined" in frontend URLs (e.g., `http://localhost:5173/undefined/auth/login`):**

This means `client/.env` is missing or `VITE_BACKEND_HOST` is not set!

```bash
# Check if .env exists
ls -la client/.env

# If it doesn't exist, create it:
echo "VITE_BACKEND_HOST=http://localhost:5000" > client/.env

# Verify the content
cat client/.env

# Restart the frontend dev server
cd client
npm run dev
```

**Verify in browser console:**
```javascript
console.log(import.meta.env.VITE_BACKEND_HOST)
// Should show: http://localhost:5000
// NOT: undefined
```

### Backend Issues

**"Flask-SQLAlchemy not available, creating mock db object":**

Flask-SQLAlchemy is not installed!

```bash
conda activate flask-app
pip install Flask-SQLAlchemy
python run.py  # Restart server
```

**"'NoneType' object has no attribute 'query'":**

This happens when Flask-SQLAlchemy is not properly installed. See above fix.

**Port 5000 already in use:**
```bash
# Find process using port 5000
lsof -i :5000  # macOS/Linux
netstat -ano | findstr :5000  # Windows

# Kill the process
kill -9 <PID>  # macOS/Linux
taskkill /PID <PID> /F  # Windows
```

**Database connection error:**
- Verify PostgreSQL is running: `pg_isready`
- Check `server/app/.env` credentials match your database
- Test connection manually: `psql -U tanguix_user -d tanguix_dev_db -h localhost`
- Verify `.env` file exists and has correct values

**Import errors / Module not found:**
```bash
# Make sure conda environment is activated
conda activate flask-app
conda env list  # Check which environment is active

# Reinstall dependencies
pip install -r requirements.txt

# Check if specific package is installed
python -c "import package_name"
```

### Database Issues

**"role 'postgres' does not exist" error (macOS Homebrew):**

This is very common with Homebrew PostgreSQL installations. Homebrew creates a superuser with your Mac username instead of "postgres".

**Solution: Use your Mac username**
```bash
# Find your username
whoami

# Connect with your Mac username
psql -d postgres

# Or specify it explicitly
psql -U your_mac_username -d postgres
```

In pgAdmin, use your Mac username instead of "postgres" when connecting.

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

**Solution: Reset the password**
```bash
# Connect as superuser
psql -d postgres

# Change password
ALTER USER tanguix_user WITH PASSWORD 'new_password';

# Exit
\q

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

### Frontend Issues

**Cannot connect to backend / CORS errors:**

1. Verify backend is running at the URL in `client/.env`
2. Check `VITE_BACKEND_HOST` in `client/.env` matches backend URL
3. Test backend directly: `curl http://localhost:5000/auth/public/health`
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

### Login Issues

**Login fails with "Invalid username or password":**

1. **Check default credentials:**
   - Username: `admin`
   - Password: `iamyourfather`

2. **Verify admin user exists:**
```bash
psql -U tanguix_user -d tanguix_dev_db -h localhost
SELECT username, role, status FROM auth.users WHERE username = 'admin';
\q
```

3. **If no admin user, recreate:**
```bash
cd server
conda activate flask-app
python setup_database.py
```

## 📌 Important Notes

1. **Two .env files required** - `client/.env` and `server/app/.env` must both be created manually
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
12. **Password matching** - `POSTGRES_PASSWORD` in `.env` must EXACTLY match the password you set in PostgreSQL
13. **Password required** - PostgreSQL requires authentication; you cannot leave password empty
14. **Flask-SQLAlchemy required** - Must be installed for database operations to work
15. **Default admin credentials** - Username: `admin`, Password: `iamyourfather` (change in production!)

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

### Environment Files Checklist

- [ ] `client/.env` created with `VITE_BACKEND_HOST=http://localhost:5000`
- [ ] `server/app/.env` created with all database credentials
- [ ] `POSTGRES_PASSWORD` matches the password set in PostgreSQL
- [ ] Both files are in `.gitignore`

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

### Default Credentials

**After running `python setup_database.py`:**
- Username: `admin`
- Password: `iamyourfather`
- Role: `ADMIN`
- Status: `active`

---

**Last Updated:** October 2025
**Version:** 3.0 (Environment Files Emphasis)