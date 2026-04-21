✅ README.md — autopilot-deployment-lab
# 🚀 Windows Autopilot Deployment Lab

This repository documents a structured, real-world approach to building and scaling **Windows Autopilot deployments** using Microsoft Intune.

The goal is to break Autopilot into **modular, reusable components** that can be adapted across environments while maintaining consistency and scalability.

---

# 👋 Overview

This lab is designed to demonstrate:

- Zero-touch provisioning (Autopilot)
- Hybrid vs Entra-only device strategies
- Dynamic grouping using Group Tags
- Scalable application deployment models
- Enrollment control and failure handling
- Automation opportunities via scripting

---

# 🧩 Deployment Architecture Breakdown

## 1. Intune Connector for Active Directory
Used for **Hybrid Azure AD Join scenarios**

### Purpose
- Enables on-prem domain join during Autopilot

### Key Actions
- Install connector on domain-joined server
- Validate connectivity to Intune services
- Ensure proper permissions for domain join

---

## 2. Device Configuration Profile (Domain Join)

### Purpose
Defines how devices join the domain during Autopilot

### Key Settings
- Computer Name Prefix  
- Domain Name  

company.lan

- Organizational Unit Structure  

OU=<Team>,OU=<Department>,DC=COMPANY,DC=LAN


---

## 3. Group Tag Strategy (Critical for Scale)

### Purpose
Drives automation, grouping, and policy assignment

### Naming Convention Examples

COMPANY_Department_HybridJoin
COMPANY_Department_EntraJoin
COMPANY_LOCATION_SelfDeploy


---

## 4. Dynamic Security Groups

### Purpose
Automatically group devices based on Group Tag

### Example Rule
'''powershell
(device.devicePhysicalIds -any (_ -eq "[OrderID]:COMPANY_Department_HybridJoin"))'''

## 5. Deployment Profiles
Purpose: Controls Out-of-Box Experience (OOBE) and enrollment behavior

Capabilities
Configure OOBE experience
Define device naming (Entra Join only)
Convert existing devices to Autopilot
Assign dynamic groups for targeting

## 6. Enrollment Status Page (ESP)
Purpose: Controls deployment flow and ensures required configurations complete
Recommended Configuration
Timeout Window: ~180 minutes (adjust based on environment)
Block on required app failures
Custom error messaging:
IT support contact
Self-service troubleshooting steps
Targeting
Assign via dynamic Autopilot device groups

## 7. Application Deployment Strategy
Categories
🔒 Required (Blocking via ESP)
Must install before user access
Critical security / baseline apps
📦 Required (Non-blocking)
Deploy automatically post-enrollment
🧑‍💻 Available (Self-Service)
Delivered via Company Portal
❌ Uninstall
Enforce removal of unwanted apps
Best Practices
Assign apps to user groups when possible
Use device groups for baseline enforcement
Always deploy Company Portal

## 8. Device Categories (Optional but Powerful)
Purpose: Enable environment segmentation:
Production
QA
Pilot / POC

Benefits:
Switch categories via Company Portal
Enables controlled update rollouts
Improves lifecycle management

## 9. Autopilot Device Registration
Methods:
Vendor-provided device registration
Manual import via hardware hash
Automatic capture from existing devices
Key Configuration Steps
Assign Group Tag
Assign User (optional)
Define device name (best effort for Entra Join)

## 10. Group Tag Assignment
Purpose: Defines how the device is treated across the environment

Example Workflow
Identify device via Serial Number
Assign Group Tag
Device joins correct dynamic group
Policies + apps apply automatically

🔄 End-to-End Flow
Device Imported → Group Tag Assigned → Dynamic Group Membership → 
Deployment Profile Assigned → OOBE → ESP → Apps/Policies Applied → 
Device Ready

🧠 Design Philosophy
This lab is built around:

Automation-first deployment
Dynamic grouping over static assignment
Separation of concerns (apps, policies, identity)
Scalable naming and tagging strategy

🛠️ Planned Enhancements (TO DO)
PowerShell scripts for:
Group Tag assignment
Device import automation
Reporting and validation
Example automation workflows:
Bulk device onboarding
Group validation scripts
Autopilot readiness checks
Integration with:
Microsoft Graph API
CI/CD-style deployment validation

📌 Key Takeaways
Group Tags are the backbone of scalable Autopilot
Dynamic groups eliminate manual targeting
ESP should enforce only what truly matters
Separate blocking vs non-blocking apps strategically
Device Categories unlock advanced lifecycle control

🔗 Related Projects
Endpoint Automation Platform (coming soon)
Intune Remediation Scripts (coming soon)
AI Log Analysis Toolkit (coming soon)

👤 Author

Billy Gordon
Endpoint Automation Engineer
Focused on scalable endpoint management, automation, and AI-driven operations
