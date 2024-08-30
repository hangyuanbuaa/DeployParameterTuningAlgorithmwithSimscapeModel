# Deploy Parameter Tuning Algorithm with Simscape Model

A digital twin of a current hardware asset should:
- Model the machine’s dynamics
- Automatically update parameters of a model when new data from the physical asset becomes available

First principle model of physical assets can be first developed in Simulink and Simscape,
In order to reflect the up-to-date state of the asset in operation, parameters need to be tuned.
**Simulink Design Optimization™** helps you develop parameter tuning algorithms 
for a digital twin to match the current asset condition.
You can interactively preprocess test data, automatically estimate model parameters and states, 
and validate estimation results with the **Parameter Estimator** app or command-line functions.
Then generate MATLAB code from within the Parameter Estimator App for deployment or 
additional customizations.
For batch parameter estimation of multiple assets or operating points, 
simulations can be run in parallel using **Parallel Computing Toolbox**.
Deploy the algorithms on premises, cloud, or edge systems using **Simulink Compiler™**.

## Special Instructions
Follow the instructions in the "workflow.mlx" live script.

## Reference
Shipping demo: DC Servo Motor Parameter Estimation [link](https://www.mathworks.com/help/releases/R2024a/sldo/ug/dc-servo-motor-parameter-estimation.html) <br>
Digital Twin Parameter Tuning [video link](https://ww2.mathworks.cn/videos/digital-twin-parameter-tuning-1627455885561.html).

## Contact
Hang Yuan

## Relevant Industries
IAM

## Relevant Products
- MATLAB
- Simulink
- Simscape (Simscape Electrical,etc.)
- Optimization Toolbox
- Simulink Design Optimization
- MATLAB Compiler
- Simulink Compiler
