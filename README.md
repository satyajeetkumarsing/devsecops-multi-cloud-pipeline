<div align="center">

# 🛡️ Enterprise Shift-Left DevSecOps CI/CD Pipeline

[![CI Status](https://img.shields.io/badge/CI-Passing-brightgreen.svg)](https://github.com/satyajeetkumarsing/devsecops-multi-cloud-pipeline)
[![TFLint](https://img.shields.io/badge/TFLint-Azure_•_AWS_•_GCP-blue.svg)](https://github.com/terraform-linters/tflint)
[![Checkov](https://img.shields.io/badge/Checkov-CIS_Benchmarks-orange.svg)](https://www.checkov.io/)
[![Trivy](https://img.shields.io/badge/Trivy-Vulnerability_Scan-00C7B7.svg)](https://aquasecurity.github.io/trivy/)
[![Gitleaks](https://img.shields.io/badge/Gitleaks-Secret_Interception-red.svg)](https://github.com/gitleaks/gitleaks)
[![Infracost](https://img.shields.io/badge/Infracost-FinOps_Gates-green.svg)](https://www.infracost.io/)

**Production-grade, shift-left DevSecOps CI/CD pipeline engine for Multi-Cloud (Azure, AWS, GCP) Infrastructure as Code.**

Designed & Engineered by **[Satyajeet Kumar Singh](https://github.com/satyajeetkumarsing)**

</div>

---

## 🧭 Architecture & Shift-Left Flow

```text
[ Feature Branch ]
        │
        ▼ (Pull Request Opened)
+---------------------------------------------------------------------------------------------+
|                          STAGE 1: VALIDATION & SECRET INTERCEPTION                          |
|  • Terraform Format Check (`terraform fmt -check`)                                          |
|  • TFLint Multi-Cloud Ruleset (Azure, AWS, GCP plugins)                                     |
|  • Gitleaks Secret Detection (pre-commit regex for keys, SAS tokens, private certs)         |
+---------------------------------------------------------------------------------------------+
        │
        ▼
+---------------------------------------------------------------------------------------------+
|                          STAGE 2: COMPLIANCE & STATIC SECURITY SCAN                         |
|  • Checkov Static Analysis (400+ CIS Benchmark Policies & NIST compliance)                  |
|  • SARIF Security Report Export to GitHub Security Tab                                      |
|  • Trivy Configuration & Misconfiguration Vulnerability Scanner                             |
+---------------------------------------------------------------------------------------------+
        │
        ▼
+---------------------------------------------------------------------------------------------+
|                          STAGE 3: FINOPS COST IMPACT GATE                                   |
|  • Infracost automated monthly infrastructure delta calculation                             |
|  • Interactive PR commenting with financial breakdown and threshold enforcement            |
+---------------------------------------------------------------------------------------------+
        │
        ▼ (Peer Review & Approval)
+---------------------------------------------------------------------------------------------+
|                          STAGE 4: DETERMINISTIC DEPLOYMENT & ROLLBACK                       |
|  • Multi-stage deployment across Dev ➔ UAT ➔ Production                                     |
|  • Automated rollback hook on health probe degradation or deployment timeout                |
+---------------------------------------------------------------------------------------------+
```

---

## ⚙️ Implemented Security Scanners

1. **TFLint (`.tflint.hcl`)**:
   - Validates resource attributes against Azure RM, AWS, and Google Cloud SDK definitions.
   - Detects deprecated syntax and unused variables.
2. **Gitleaks (`.gitleaks.toml`)**:
   - Intercepts accidental leakage of AWS Access Keys, Azure Storage SAS keys, GCP service account private keys, and RSA private certificates.
3. **Checkov (`.checkov.yaml`)**:
   - Enforces CIS Foundations benchmarks (e.g. HTTPS only, public endpoint prohibition, customer-managed key encryption).
4. **Trivy**:
   - Scans IaC templates and container specifications for CVEs and configuration drift.
5. **Infracost**:
   - Provides FinOps visibility directly on GitHub PRs before changes are merged.

---

## 🚀 Quick Execution Guide

### Local Validation
```bash
# 1. Check formatting and execute security gate script
chmod +x scripts/security_gate.sh
./scripts/security_gate.sh sample-workload

# 2. Run TFLint
tflint --init --config=.tflint.hcl
tflint --config=.tflint.hcl
```

### GitHub Actions Secrets Setup
Configure the following repository secrets in GitHub:
- `INFRACOST_API_KEY`: Infracost API key for automated PR cost commenting.
- `AZURE_CREDENTIALS`: Service Principal JSON credentials for Azure deployments.
- `AWS_ACCESS_KEY_ID` & `AWS_SECRET_ACCESS_KEY`: AWS IAM deployment credentials.
- `GCP_SA_KEY`: Base64 encoded Google Cloud Service Account key.

---

## 📄 License
Licensed under the Apache-2.0 / MIT License.

Architected with precision by **[Satyajeet Kumar Singh](https://github.com/satyajeetkumarsing)**.
