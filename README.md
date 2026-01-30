# 🖥️ Server Health Monitoring & Docker Auto-Healing Script

A Bash-based **server health monitoring script** that checks system resources, Docker service status, container health, logs, and basic network connectivity — with automatic recovery for stopped containers.

This project is designed for **learning Linux, Docker, and basic DevOps monitoring concepts**.

---

## 📌 Features

### 🔍 System Monitoring
- CPU usage (via `mpstat`)
- Memory usage with threshold alerts
- Disk usage (`df -h`)
- System uptime
- Recent system & systemd logs

### 🐳 Docker Monitoring & Auto-Healing
- Checks if Docker is installed
- Automatically installs Docker if missing
- Ensures Docker service is running
- Lists running containers
- Detects **exited containers**
- Automatically restarts stopped containers
- Displays container status in tabular format
- Fetches last 10 logs from each container

### 🌐 Network Checks
- Validates connectivity to specific container/service IPs and ports using `nc`

---

## 🛠️ Prerequisites

- Ubuntu/Linux-based system
- Bash shell
- `sudo` privileges
- Internet access (for Docker installation if required)

### Required Packages
The script uses:
- `docker`
- `mpstat` (from `sysstat`)
- `netcat (nc)`

Install missing tools if needed:
```bash
sudo apt update
sudo apt install -y sysstat netcat
