# GLUECK: Growth pattern Learning for Unsupervised Extraction of Cancer Kinetics

Code repository for "GLUECK: Growth pattern Learning for Unsupervised Extraction of Cancer Kinetics" by Cristian Axenie & Daria Kurz accepted at ECML PKDD 2020, Ghent, Belgium, 14-18 September 2020.

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

