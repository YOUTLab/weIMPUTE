# weIMPUTE: A User-Friendly Web-Based Genotype Imputation Platform
**A web-based imputation GUI, weIMPUTE, which supports multiple software including SHAPEIT, Eagle2, Minimac4,Beagle5, and IMPUTE2 for genotype phasing and imputation.**

<img src="logo.png" alt="weIMPUTE" style="zoom: 50%;" />

This repository provides a Docker Image to run your own instance of the weIMPUTE Imputation Server.

Genotype imputation is a crucial step before genome-wide association studies (GWAS), which could increase the marker size to improve the statistical power in causal SNPs detection. Researchers want  to perform  imputation using the user-friendly graphical analysis tools that do not require  informatics or  computer expertise. The genotype imputation software provides phasing or imputing function but lack a graphical user interface (GUI) to effectively conduct imputation. We developed a web-based imputation GUI, weIMPUTE, which supports multiple software including SHAPEIT, Eagle, Minimac4, Beagle, and IMPUTE2 for genotype phasing and imputation. weIMPUTE featuresa completeworkflow that includes quality control and data format converting making the process of imputation accessible to both novice and experienced users. Owners of  reference genotype data can choose to install weIMPUTE to the server or workstation and  provide a web-based imputation service to public users, where the reference data could be used for imputation without sharing. weIMPUTE is a comprehensive imputation planform that provide an easy-to-use solution for the users from various research fields Users can easily build their own imputation server using weIMPUTE across different operating systems.

### Authors:

> You Tang and Meng Huang

### Contact:

> E-mail: tangyou@jlnku.edu.cn
>
> 

# Installation


## Requirements

[Docker](http://docker.io) must be installed on your local computer. Please following the [guide](https://docs.docker.com/engine/installation/linux/ubuntu/) step by step to install the latest version.

## Deploy  


After the successful installation of Docker, Download the suanfa_v6.tar file from 

http://144.34.160.128:82/suanfa_v6.tar

Run the commands as follow:

```
docker load -i suanfa_v6.tar
docker run -d --privileged --net=host suanfa:v6
```

It may take several minutes depending on your internet connection and computer resources. Then, your imputation server instance is ready and you are able to access it on.

http://IP:9083 

and

http://IP:9085

IP refers to the IP address of your local computer where weIMPUTE is installed.

## Example Website

If you deploy correctly, the local service should match the example website URL.

http://144.34.160.128:80

http://144.34.160.128:81

Enter the verification code and login as admin with the default admin password：

admin

admin123


## Documentation

For specific usage instructions, please refer to [README.pdf](README.pdf).
