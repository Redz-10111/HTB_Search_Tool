# 📘 Tutorial — HTB Search Tool

This tutorial guides you step by step to install the requirements, **clone the repository**, give execution permissions to the script, **update the database with `-u`** (downloading `bundle.js`), and finally use the main filters.

---

## 1) 🔧 Requirements (install tools)

> ✅ Compatible with **Linux** and **WSL (Windows Subsystem for Linux)**.  
> 🐚 Recommended to use **Bash** as the main shell.

You need to install:

- 📂 **git** → to clone the repository  
- 🌐 **curl** → to download the `bundle.js` file  
- 🎨 **node-js-beautify** → to format the `bundle.js`  
- 🛠️ **moreutils** → provides the `sponge` utility  

---

## 📥 Quick installation

## **Debian / Ubuntu (and derivatives):**

Copy code
```bash
sudo apt update && sudo apt install -y git curl node-js-beautify moreutils
```
## **Fedora / RHEL (and derivatives):**

Copy code
```bash
sudo dnf install -y git curl moreutils
sudo npm install -g js-beautify
````
## **Arch / Manjaro:**

Copy code
```bash
sudo pacman -S --needed git curl moreutils
sudo npm install -g js-beautify
```
ℹ️ Note: if you don’t have npm, install it with your package manager before running
npm install -g js-beautify.

---

## 2) ⬇️ **Clone the repository**
Download the official GitHub repository and enter the folder:

Copy code
```bash
git clone --no-checkout --depth 1 https://github.com/Redz-10111/HTB_Search_Tool.git
cd HTB_Search_Tool
git sparse-checkout init --cone
git sparse-checkout set htbmachines_english.sh htbmachines_spanish.sh
git checkout main
```
---
## 3) ✅ **Give execution permissions**
Make the scripts executable:

Copy code
```bash
chmod +x htbmachines_spanish.sh htbmachines_english.sh
```
⚠️ You only need to do this the first time you clone the repository.
If you already granted permissions before, you can skip this step.

---

## 4) 🔄 **Update the local database (download bundle.js)**
Run the Spanish script with the -u option.
This will download bundle.js and replace it only if the MD5 checksum changes (prevents overwriting if there are no updates).

Copy code
```bash
./htbmachines_spanish.sh -u
```
📌 This step is mandatory the first time in order to have the local database.

---

## 5) 🚀 **Basic usage (quick queries)**
Run the Spanish script:

Copy code
```bash
./htbmachines_english.sh
```
🔎 **Available filters and options**
The script provides multiple search options and utilities:

🟡 -u → Download or update required files (bundle.js)

🟣 -m → Search by machine name

🟣 -i → Search by IP address

🟣 -d → Filter by difficulty (Easy, Medium, Hard, Insane)

🟣 -o → Filter by operating system (Linux / Windows)

🟣 -s → Filter by skills (e.g., SMB, SQLi, LFI, etc.)

🟣 -c → Filter by certifications (eJPT, OSCP, CEH, etc.)

🟣 -y → Get a direct link to the machine walkthrough on YouTube

🟣 -h → Show the help panel, which summarizes all available options

---

## 6)🆘 **Help panel**
The script includes an interactive help menu that shows all usage options.
Run:

Copy code
```bash
./htbmachines_spanish.sh -h
```
👉 This will display something like:

```bash
[+] Usage:
    u) Download or update required files
    m) Search by machine name
    i) Search by IP address
    d) Search by machine difficulty
    o) Search by operating system
    s) Search by Skills
    c) Filter by certifications
    y) Get machine walkthrough link on YouTube
    h) Show this help panel
```

---

## 7) 🧯 Troubleshooting
❌ permission denied → Run chmod +x ... to grant permissions.

❌ command not found: js-beautify → Install node-js-beautify.

❌ command not found: sponge → Install moreutils.

❌ Error downloading bundle.js → Check your internet connection or run -u again.

❌ GitHub conflicts when pushing changes → Run:
