<img width="2047" height="3007" alt="fig3" src="https://github.com/user-attachments/assets/1f2673a4-9206-46b4-87b2-e904ce963e87" /># 1. LFSPE-ICESat2-Bathymetry

This repository provides the official MATLAB implementation of the **Linear Feature-Based Signal Photon Extraction (LFSPE)** algorithm for shallow-water bathymetry using ICESat-2 ATL03 photon-counting LiDAR data, as proposed in:

> **Shi, Z., Li, J., Yang, Z., Long, H., Cui, H., Zhao, S., Li, X., Li, Q. (2025). A Linear Feature-Based Method for Signal Photon Extraction and Bathymetric Retrieval Using ICESat-2 Data. Remote Sensing, 17(16), 2792.**  
> [https://doi.org/10.3390/rs17162792](https://doi.org/10.3390/rs17162792)

---

## 1.1 Overview

The **LFSPE** algorithm improves signal photon identification accuracy and robustness across varying water depths and noise conditions by:

- **Adaptive resolution adjustment** (vertical & horizontal) to standardize photon spacing  
- **Segmented Gaussian fitting** to separate underwater and non-underwater photons  
- **Linear feature analysis** with a depth-dependent adaptive neighborhood radius  
- **Refraction correction** for accurate bathymetric depth retrieval  

**Performance Highlights** (vs. DBSCAN):

<!-- Performance Highlights (vs. DBSCAN) -->
<div align="center">

<table width="100%">
  <colgroup>
    <col width="20%">
    <col width="40%">
    <col width="40%">
  </colgroup>
  <thead>
    <tr>
      <th align="center">Metric</th>
      <th align="center">LFSPE</th>
      <th align="center">DBSCAN</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center">Precision</td>
      <td align="center"><b>0.977</b></td>
      <td align="center">0.751</td>
    </tr>
    <tr>
      <td align="center">Recall</td>
      <td align="center"><b>0.958</b></td>
      <td align="center">0.817</td>
    </tr>
    <tr>
      <td align="center">F1 Score</td>
      <td align="center"><b>0.967</b></td>
      <td align="center">0.778</td>
    </tr>
    <tr>
      <td align="center">OA</td>
      <td align="center"><b>0.972</b></td>
      <td align="center">0.796</td>
    </tr>
  </tbody>
</table>

</div>



---

## 1.2 Data Sources

- **ICESat-2 ATL03 data** – Download from [NASA Earthdata Search](https://search.earthdata.nasa.gov)  
- **CUDEM Bathymetric Data** – Download from [NOAA NGDC](https://www.ngdc.noaa.gov/mgg/bathymetry/bathymetry.html)  
- **Full experimental datasets from the paper** – [Google Drive Link](https://drive.google.com/drive/folders/1RTBe8tc0kQiUXllJGJ4sMKz0Mpm5O1TD?usp=drive_link)  

---

## 1.3 Usage
### Run Bathymetry Extraction
```matlab
% 1. Open MATLAB (R2022a or later recommended)
% 2. Set the current working directory to the root of this project
% 3. Execute:
run_bathymetry
 ```
---
## 1.4 License
This code is released for academic and non-commercial use only.
For commercial licensing or extended use, please contact the authors.

## 1.5 Contact
For questions, feedback, or collaboration inquiries, please contact:
📨 Zhenwei Shi: shizw@aircas.ac.cn

## 1.6 Results
<div align="center">

<img src="figures\fig3.png" alt="Results" width="80%">

**Coarse segmentation of underwater and non-underwater photons. Panels (a–h) correspond to datasets 1–8. Underwater photons are represented in orange, and non-underwater photons in blue.** 

<img src="figures\fig5-1.png" alt="Results" width="80%">
<img src="figures\fig5-2.png" alt="Results" width="80%">

**Signal photon extraction results, with (a–h) corresponding to experimental datasets 1–8.**
</div>
