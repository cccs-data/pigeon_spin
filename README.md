# Coordinating directional switches in pigeon flocks: The role of nonlinear interactions

## Introduction

MatLab Code for paper "Coordinating directional switches in pigeon flocks: The role of nonlinear interactions".

## Dataset

To validate the model proposed by our paper, we used the dataset of pigeon flock collected by Prof. Tamás Vicsek. Unfortunately, we can only upload the truncated dataset in ```./coordinationData``` with our code for copyright issues. The complete pigeon flock dataset is available [here](http://hal.elte.hu/pigeonflocks/data.html) after sending request e-mail to <nagymate@hal.elte.hu>.

## Usage

The truncated dataset is stored in ```./coordinationData```

The output of Omega matrix is stored in ```./coordinationOmega```

To use our model to simulated the spin of pigeon flock, run ```./model_Simulation.m```

```./returnOmega.m```  apply SBL algorithm to obtain Omega matrix.

```./returnYS.m```  calculate the dictionary matrix in SBL.

```./tac_reconstruction.m```  is the solving function of SBL.