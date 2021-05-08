# Haziness-degree-evaluator

## Summary
This is the MATLAB source code for reproducing the results in the paper entitled "**Haziness Degree Evaluator: A Knowledge-Driven Approach for Haze Density Estimation**", submitted to the *MDPI Sensors* journal.

The source code of the proposed HDE is placed in the folder "source_code" under the filename "new_indicator_v5_opt.m". In addition, we also provided our implementation of the work of [Jiang et al.](https://ieeexplore.ieee.org/document/7918592) under the filename "ref_model.m".

In the "data" folder, we provided the ".mat" files that contain the FADE, DF, and HDE values calculated on the two testing sets of the [RESIDE](https://sites.google.com/view/reside-dehaze-datasets/reside-standard?authuser=0) dataset. Therefore, it would be more convenient to leverage those results instead of calculating them again.

To reproduce the results on hazy/haze-free image classification on new data, please run the script "acc_test.m". The results would be identical those in the following table.

| **Class** | **FADE** | **DF** | **HDE** |
| --------- | :------: | :----: | :-----: |
| *DV*      | 0.9866   | 0.2968 | 0.8811  |
| *P*       | 1020                     ||||
| *TP*      | 863      | 242    | 929     |
| *TPR*     | 84.6%    | 23.7%  | 91.1%   |
| *FN*      | 157      | 778    | 91      |
| *FNR*     | 15.4%    | 76.3%  | 8.9%    |
| *N*       | 552                      ||||
| *TN*      | 446      | 508    | 507     |
| *TNR*     | 80.8%    | 92.0%  | 91.1%   |
| *FP*      | 106      | 44     | 45      |
| *FPR*     | 19.2%    | 8.0%   | 8.1%    |
| *ACC*     | 83.3%    | 47.7%  | 91.4%   |

Furthermore, the run-time comparison results can also be reproduced by invoking the script "runtime_meaaure.m" on test images in the "test-images-for-runtime-measure" folder. For executing the script, it is required to specify the path to the FADE's source code, which can be obtained from [http://live.ece.utexas.edu/research/fog/index.html](http://live.ece.utexas.edu/research/fog/index.html). Also, please specify the path to test images on line 21.
