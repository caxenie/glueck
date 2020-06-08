# GLUECK: Growth pattern Learning for Unsupervised Extraction of Cancer Kinetics

Code repository for "GLUECK: Growth pattern Learning for Unsupervised Extraction of Cancer Kinetics" by Cristian Axenie & Daria Kurz accepted at ECML PKDD 2020, Ghent, Belgium, 14-18 September 2020.

**Abstract**

Neoplastic processes are described by complex and heterogeneous dynamics. The interaction of neoplastic cells with their environment describes tumor growth and is critical for the initiation of cancer invasion. Despite the large spectrum of tumor growth models, there is no clear guidance on how to choose the most appropriate model for a particular cancer and how this will impact its subsequent use in therapy planning. Such models need parametrization that is dependent on tumor biology and hardly generalize to other tumor types and their variability. Moreover, the datasets are small in size due to the limited or expensive measurement methods. Alleviating the limitations that incomplete biological descriptions, the diversity of tumor types, and the small size of the data bring to mechanistic models, we introduce Growth pattern Learning for Unsupervised Extraction of Cancer Kinetics (GLUECK) a novel, data-driven model based on a neural network capable of unsupervised learning of cancer growth curves. Employing mechanisms of competition, cooperation, and correlation in neural networks, GLUECK learns the temporal evolution of the input data along with the underlying distribution of the input space. We demonstrate the superior accuracy of GLUECK, against four typically used tumor growth models, in extracting growth curves from a four clinical tumor datasets. Our experiments show that, without any modification, GLUECK can learn the underlying growth curves being versatile between and within tumor types.


**GLUECK Codebase:**

- datasets - the experimental datasets (csv files) and their source, each in separate directories
- models   - codebase to run and reproduce the experiments


**Directory structure:**

models/GLUECK/.

- create_init_network.m       - init GLUECK network (SOM + HL)
- error_std.m                 - error std calculation function
- glueck_core.m               - main script to run GLUECK
- model_aic.m                 - AIC calculation function
- model_bic.m                 - BIC calculation function
- model_rmse.m                - RMSE calculation function 
- model_sse.m                 - SSE calculation function
- parametrize_learning_law.m  - function to parametrize GLUECK learning
- present_tuning_curves.m     - function to visualize GLUECK SOM tuning curves
- randnum_gen.m               - weight initialization function
- tumor_growth_model_fit.m    - function implementing ODE models
- tumor_growth_models_eval.m  - main evaluation on GLUECK runtime
- visualize_results.m         - visualize GLUECK output and internals
- visualize_runtime.m         - visualize GLUECK runtime



**Usage:**

- models/GLUECK/glueck_core.m - main function that runs GLUECK and generates the runtime output file (mat file)
- models/GLUECK/tumor_growth_models_eval.m - evaluation and plotting function reading the GLUECK runtime output file

