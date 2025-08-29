# 1. LFSPE-ICESat2-Bathymetry

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
### test1: Run Bathymetry Extraction
```matlab
% 1. Open MATLAB (R2022a or later recommended)
% 2. Set the current working directory to the root of this project
% 3. Execute:
run_bathymetry
 ```

### test2
```matlab
clc; clear; close all
FILE_NAME = 'E:\ICESat-2_beijing\ATL03_20231103152820_06972102_006_01.h5';

bm = '/gt3r';
atl03 = getatl03(FILE_NAME, bm, false);

try
    xxs = atl03.atd(1:10000);
    yys = atl03.alt(1:10000);
catch
    xxs = atl03.atd;
    yys = atl03.alt;
end

minDistance = 0.5;

idxs = vec_resolution(xxs,yys, minDistance);
xx = xxs(idxs);
yy = yys(idxs);

rng(0)

xx = xx-min(xx);

x_scaled = adjust_intervals(xx,[]);
%% 
x1 = x_scaled;
y1 = yy;

params.radius = 30;
params.distT = 1.5;
params.resT = 2.5;
params.distsrT = 5;
params.densityT = 20;

[density1, lines, idx, res, idnew1, slope, dists, radii, distsr1] = getdensity(x1,y1,params.radius,params.distT, params.distsrT,params.densityT, params.resT,"seasurface", [], []);
if islogical(idnew1), idnew1 = find(idnew1); end
id_in_orig = idxs(idnew1);     % xxs/yys index

%%
idnew1 = density1>5 | distsr1 < 5;

figure('Position', [100, 100, 450, 300]);
plot(x1, y1, 'k.');
hold on;
plot(x1(idnew1), y1(idnew1), '.', 'Color', [0.0, 0.45, 0.70]); 
set(gca, 'FontSize', 12)
lgd = legend({'Other photons', 'Signal photons'},'Location', 'northeast', 'FontSize', 12)
lgd.Box = 'on'; 
lgd.Color = 'white'; 
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
% xlim([0 max(x)])
axis equal
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
