# LFSPE-ICESat2-Bathymetry

This repository provides the implementation of the **Linear Feature-Based Signal Photon Extraction (LFSPE)** algorithm for shallow-water bathymetry using ICESat-2 ATL03 photon-counting data.

The method is designed to improve signal photon identification accuracy and robustness across varying water depths and noise conditions by leveraging linear feature characteristics and adaptive parameter strategies.

---

## 📂 Structure

```text
├── run_bathymetry.m              # 🔹 Main entry point
├── getParametersSeafloor.m       # 🔧 Set parameters for seafloor photon extraction
├── getParametersSeaSurface.m     # 🔧 Set parameters for sea surface photon extraction
└── README.md

---

## 🚀 How to Run

1. Open **MATLAB** (R2021a or later recommended).
2. Set your current working directory to the root of this project.
3. Execute the main script:

   ```matlab
   run_bathymetry

---

## 🛰️ Dataset Access
Due to size limitations, the full ICESat-2 and validation datasets are hosted externally.

📦 Download the full dataset from Google Drive:
👉 https://drive.google.com/drive/folders/1RTBe8tc0kQiUXllJGJ4sMKz0Mpm5O1TD?usp=drive_link

---

## 📧 Contact
For questions, feedback, or collaboration inquiries, please contact:
📨 Zhenwei Shi: shizw@aircas.ac.cn

---

##📄 License
This code is released for academic and non-commercial use only.
For commercial licensing or extended use, please contact the authors.
---

