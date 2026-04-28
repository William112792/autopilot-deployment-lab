# 🚀 Windows Autopilot Deployment Lab

![Autopilot](https://github.com/William112792/autopilot-deployment-lab/blob/main/diagrams/autopilot-end-to-end.png?raw=true)

This repository demonstrates a **real-world, scalable approach to Windows Autopilot deployment** using Microsoft Intune.

The focus is on building **modular, automation-driven deployment patterns** that scale across environments while minimizing manual effort.

---

# 👋 Overview

This lab demonstrates:

* Zero-touch provisioning (Windows Autopilot)
* Hybrid vs Entra-only deployment strategies
* Dynamic device targeting using Group Tags
* Scalable application deployment models
* Enrollment control via ESP (Enrollment Status Page)
* Automation opportunities using PowerShell + structured workflows

---

# 📦 Example Device Import & Automation

## 🔹 Sample Autopilot CSV (Hardware Hash Import)

Example CSV used for device import:

https://github.com/William112792/autopilot-deployment-lab/blob/main/examples/AutopilotHWID.csv

### Purpose

* Demonstrates required format for Autopilot import
* Includes:

  * Device Serial Number
  * Windows Product ID (optional)
  * Hardware Hash

---

## 🔹 Hardware Hash Collection Script

Simplified script for exporting Autopilot device information:

https://github.com/William112792/autopilot-deployment-lab/blob/main/scripts/REM_AutoPilotInfo.ps1

### Purpose

* Collects device hardware hash
* Outputs CSV for import into Intune
* Enables bulk onboarding workflows

---

# 🧩 Deployment Architecture Breakdown

## 1. Intune Connector for Active Directory (Hybrid Only)

### Purpose

Enables **on-prem domain join during Autopilot**

### Key Actions

* Install on domain-joined server
* Validate Intune connectivity
* Ensure domain join permissions

---

## 2. Device Configuration Profile (Domain Join)

### Purpose

Defines how devices join domain during deployment

### Key Settings

* Computer Name Prefix
* Domain Name: `company.lan`
* OU Structure:
  `OU=<Team>,OU=<Department>,DC=COMPANY,DC=LAN`

---

## 3. Group Tag Strategy (Core to Automation)

### Purpose

Drives:

* Dynamic grouping
* Policy targeting
* App deployment

### Naming Examples

* `COMPANY_Department_HybridJoin`
* `COMPANY_Department_EntraJoin`
* `COMPANY_LOCATION_SelfDeploy`

---

## 4. Dynamic Security Groups

### Purpose

Automatically assign devices based on Group Tag

### Example Rule

```text
(device.devicePhysicalIds -any (_ -eq "[OrderID]:COMPANY_Department_HybridJoin"))
```

---

## 5. Deployment Profiles

### Purpose

Controls:

* OOBE (Out-of-Box Experience)
* Enrollment behavior
* Device naming (Entra Join)

### Capabilities

* Assign to dynamic groups
* Convert existing devices to Autopilot
* Standardize onboarding experience

---

## 6. Enrollment Status Page (ESP)

### Purpose

Enforces required configuration before user access

### Recommended Configuration

* Timeout: ~180 minutes
* Block on required app failures
* Custom error messaging:

  * IT contact info
  * Troubleshooting steps

### Targeting

* Assigned via dynamic Autopilot device groups

---

## 7. Application Deployment Strategy

### Categories

#### 🔒 Required (Blocking via ESP)

* Must install during enrollment
* Security baseline apps
* Example:

  * Defender
  * Company Portal
  * Core enterprise apps

#### 📦 Required (Non-blocking)

* Deploy automatically after enrollment

#### 🧑‍💻 Available (Self-Service)

* Delivered via Company Portal
* Installed by user on demand

#### ❌ Uninstall

* Removes unwanted software

---

### Best Practices

* Assign apps to **user groups when possible**
* Use **device groups for baseline enforcement**
* Always deploy **Company Portal**

---

## 8. Device Categories (Optional)

### Purpose

Enable segmentation:

* Production
* QA
* Pilot / POC

### Benefits

* Controlled rollout strategy
* Lifecycle management improvements
* Category switching via Company Portal

---

## 9. Autopilot Device Registration

### Methods

* Vendor-provided registration (preferred)
* Manual import (CSV / hardware hash)
* Existing device capture

### Key Steps

* Assign Group Tag
* Assign user (optional)
* Define naming (Entra Join)

---

## 10. Group Tag Assignment (Automation Trigger)

### Purpose

Defines how device is treated across environment

### Workflow

1. Device imported (CSV / OEM)
2. Group Tag assigned
3. Device joins dynamic group
4. Policies + apps apply automatically

---

# 🔄 End-to-End Flow

```text
Device Imported
   ↓
Group Tag Assigned
   ↓
Dynamic Group Membership
   ↓
Deployment Profile Assigned
   ↓
OOBE (User Setup)
   ↓
Enrollment Status Page (ESP)
   ↓
Required Apps + Policies Applied
   ↓
User Sign-In
   ↓
Additional Apps (User-Based) Deploy
   ↓
Device Ready
```

---

# 🧠 Design Philosophy

* **Automation-first** deployment model
* **Dynamic grouping over static assignment**
* **Separation of concerns** (apps, policies, identity)
* **Scalable naming + tagging strategy**

---

# 🛠️ Planned Enhancements

* PowerShell automation:

  * Group Tag assignment
  * Bulk device onboarding
  * Reporting + validation

* Microsoft Graph integration

* CI/CD-style deployment validation

* Autopilot readiness checks

---

# 📌 Key Takeaways

* Group Tags are the backbone of scalable Autopilot
* Dynamic groups eliminate manual targeting
* ESP should enforce only critical requirements
* Separate blocking vs non-blocking apps intentionally
* User-based app deployment extends automation post-login

---

# 🔗 Related Projects

* Endpoint Automation Platform (in progress)
* Intune Remediation Scripts
* AI Log Analysis Toolkit (planned)

---

# 👤 Author

Billy Gordon

Endpoint Automation Engineer

Focus:

* Endpoint Automation (Intune / Autopilot)
* Scalable deployment architecture
* Automation-first engineering

