# LFSPE-ICESat2-Bathymetry

This repository provides the implementation of the **Linear Feature-Based Signal Photon Extraction (LFSPE)** algorithm for shallow-water bathymetry using ICESat-2 ATL03 photon-counting data.

The method is designed to improve signal photon identification accuracy and robustness across varying water depths and noise conditions by leveraging linear feature characteristics and adaptive parameter strategies.


---
# 📂 Structure

```text
├── run_bathymetry.m              # 🔹 Main entry point
├── getParametersSeafloor.m       # 🔧 Set parameters for seafloor photon extraction
├── getParametersSeaSurface.m     # 🔧 Set parameters for sea surface photon extraction
└── README.md

---


# 🚀 How to Run

1. Open **MATLAB** (R2021a or later recommended).
2. Set your current working directory to the root of this project.
3. Execute the main script:

   ```matlab
   run_bathymetry



📦 Dataset Access
Due to size constraints, datasets are hosted externally.

📥 Download full datasets from Google Drive:
🔗 ICESat-2 and validation data

📄 License

This code is released for academic and non-commercial use only.
For commercial licensing or extended use, please contact the authors.

📧 Contact
For questions, feedback, or collaboration inquiries, please contact:
📨 Zhenwei Shi: shizw@aircas.ac.cn



# LFSPE-ICESat2-Bathymetry
This repository provides the implementation of the **Linear Feature-Based Signal Photon Extraction (LFSPE)** algorithm for shallow-water bathymetry using ICESat-2 ATL03 photon-counting data.

The method is designed to improve signal photon identification accuracy and robustness across varying water depths and noise conditions by leveraging linear feature characteristics and adaptive parameter strategies.

PointClouds
--------------
📥 Download full datasets from Google Drive:
🔗 [ICESat-2 and validation data](https://drive.google.com/drive/folders/1RTBe8tc0kQiUXllJGJ4sMKz0Mpm5O1TD?usp=drive_link)


Example
--------------
Run in Matlab: demo_extract_powerline.m
```matlab
1. Open **MATLAB** (R2022a or later recommended).
2. Set your current working directory to the root of this project.
3. Execute the main script:
   run_bathymetry
```

Results
--------------
<div align=center>
<img src="https://github.com/zwshi-pku/3DLiDAR/blob/main/ExtractPowerLine/re_f1_nonGroundPoints.png"  height="70%" width="70%">
<img src="https://github.com/zwshi-pku/3DLiDAR/blob/main/ExtractPowerLine/re_f2_candidate%20powerline%20points.png"  height="70%" width="70%">
<img src="https://github.com/zwshi-pku/3DLiDAR/blob/main/ExtractPowerLine/re_f3_candidate%20powerline%20points%20clusters.png"  height="70%" width="70%">
<img src="https://github.com/zwshi-pku/3DLiDAR/blob/main/ExtractPowerLine/re_f4_powerline%20points%20clusters.png"  height="70%" width="70%">
<img src="https://github.com/zwshi-pku/3DLiDAR/blob/main/ExtractPowerLine/re_f5_colorization%20clusters.png"  height="70%" width="70%">
<img src="https://github.com/zwshi-pku/3DLiDAR/blob/main/ExtractPowerLine/re_f6_powerLines%20clusters.png"  height="70%" width="70%">
<img src="https://github.com/zwshi-pku/3DLiDAR/blob/main/ExtractPowerLine/re_f7_Power%20line%20model.png"  height="70%" width="70%">
</div>

📄 License
--------------
This code is released for academic and non-commercial use only.
For commercial licensing or extended use, please contact the authors.

📧 Contact
--------------
For questions, feedback, or collaboration inquiries, please contact:
📨 Zhenwei Shi: shizw@aircas.ac.cn







