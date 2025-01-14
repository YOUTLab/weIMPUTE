# weIMPUTE: A User-Friendly Web-Based Genotype Imputation Platform
**A web-based imputation GUI, weIMPUTE, which supports multiple software including SHAPEIT, Eagle2, Minimac4,Beagle5, and IMPUTE2 for genotype phasing and imputation.**

<img src="logo.png" alt="weIMPUTE" style="zoom: 50%;" />

This repository provides a Docker Image to run your own instance of the weIMPUTE Imputation Server.

Genotype imputation is a crucial step before genome-wide association studies (GWAS), which could increase the marker size to improve the statistical power in causal SNPs detection. Researchers want  to perform  imputation using the user-friendly graphical analysis tools that do not require  informatics or  computer expertise. The genotype imputation software provides phasing or imputing function but lack a graphical user interface (GUI) to effectively conduct imputation. We developed a web-based imputation GUI, weIMPUTE, which supports multiple software including SHAPEIT, Eagle, Minimac4, Beagle, and IMPUTE2 for genotype phasing and imputation. weIMPUTE featuresa completeworkflow that includes quality control and data format converting making the process of imputation accessible to both novice and experienced users. Owners of  reference genotype data can choose to install weIMPUTE to the server or workstation and  provide a web-based imputation service to public users, where the reference data could be used for imputation without sharing. weIMPUTE is a comprehensive imputation planform that provide an easy-to-use solution for the users from various research fields Users can easily build their own imputation server using weIMPUTE across different operating systems.

## Authors:

> You Tang



## Contact:

> E-mail: tangyou9000@163.com



## Example Website

If you deploy correctly, the local service should match the example website URL.

Front-end service server: http://144.34.160.128:9083. 

and

Back-end Management server: http://144.34.160.128:9085.

Enter the verification code and login as admin with the default admin password：

Account: admin

Password: admin123

**Attention! This example webpage is for demonstration purposes only and is intended solely for testing with small files. You can find the test file at the following link: DemoData/DemoFile. For testing with larger files, please deploy weIMPUTE with a high-performance server before using the imputation service.** 

Format Conversion and Quality Control Interface: http://144.34.160.128:8081/. 

Genome-Wide Association Study (GWAS) Interface: http://144.34.160.128:8080/. 


## Quick Start

Please refer to **[Quick Start.pdf](https://github.com/YOUTLab/weIMPUTE/blob/main/Quick%20Start.pdf)** for quick start operational instructions for the demo file imputation service.

Operation Video：

https://github.com/YOUTLab/weIMPUTE/assets/141199195/ac6898c9-22a8-4228-8216-54b1fcc22a2e



## Local Installation

You can install and deploy weIMPUTE on your own server.

To quickly set up **weIMPUTE**, you can use the provided installation script. This will automate most of the installation steps.

1. **Download the Installation Script**

   Download the installation script from the following URL:

   [install_weIMPUTE.sh](https://github.com/YOUTLab/weIMPUTE/blob/main/install_weIMPUTE.sh)

2. **Run the Installation Script**

   After downloading the script, run the following commands in your terminal to make it executable and execute it:

   ```
   chmod +x install_weIMPUTE.sh
   sudo ./install_weIMPUTE.sh
   ```

   The script will automatically:

   - Configure the firewall (open necessary ports)
   - Download and load the Docker image
   - Start the Docker container
   - Set up weIMPUTE

   This installation method may take a few minutes depending on your internet speed and system performance.

   

   Then, your imputation server instance is ready and you can access it through the following address.

   Front-end service server: http://IP:9083. 

   and

   Back-end Management server: http://IP:9085.

   IP refers to the IP address of your local computer where weIMPUTE is installed.


For detailed local installation and deployment steps, please refer to **[Local Installation.pdf](https://github.com/YOUTLab/weIMPUTE/blob/main/Local%20Installation.pdf).**

**It is recommended to use LINUX operating system.**



## Data Preparation

If you would like to input a file other than the one provided, you will need to prepare the relevant files beforehand. Please refer to the **[Data Preparation.pdf](Data%20Preparation.pdf)** document for further instructions.



## Back-end Management

Administrators can perform user management and server management. Please refer to **[Back-end Management.pdf](Back-end%20Management.pdf)** for details.


## Format Conversion and Quality Control

The weIMPUTE_FORMAT Conversion Tool is designed to facilitate the conversion of genomic data from various formats (e.g., PLINK, Hapmap) to the Variant Call Format (VCF), which is the standard input format for weIMPUTE. This tool also supports flexible quality control (QC) measures, such as minor allele frequency (MAF) filtering and Hardy-Weinberg equilibrium (HWE) checks. With this tool, researchers working with different genomic data formats can seamlessly integrate their datasets into the weIMPUTE pipeline for genotype imputation, regardless of their initial format.
Please refer to **([weIMPUTE FORMAT Conversion.pdf](https://github.com/YOUTLab/weIMPUTE/blob/main/weIMPUTE_FORMAT%20Conversion%20Tool/weIMPUTE_FORMAT_Conversion.pdf))** for details.

## Genome-Wide Association Study (GWAS)

The weIMPUTE_GWAS tool is used to configure and manage GWAS (Genome-Wide Association Studies) tools such as GAPIT, allowing users to upload files, set parameters, start GWAS analysis, and visualize the results via a graphical interface. It is integrated with the weIMPUTE and weIMPUTE_GWAS platforms to enhance the user's workflow. 
Please refer to **([weIMPUTE GWAS.pdf](https://github.com/YOUTLab/weIMPUTE/blob/main/weIMPUTE_GWAS/weIMPUTE_GWAS.pdf))** for details.

## Documentation

For specific usage instructions, please refer to **[USAGE_GUIDE.pdf](USAGE_GUIDE.pdf)**.
