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

### Download

After the successful installation of Docker, Download the suanfa_v6.tar file from 

http://144.34.160.128:82/suanfa_v6.tar

### Deploy weIMPUTE on CentOS

To get started with weIMPUTE on CentOS, make sure your firewall allows ports **9083** and **9085** to be open. You can follow these steps:

```
sudo firewall-cmd --permanent --add-port=9083/tcp
sudo firewall-cmd --permanent --add-port=9085/tcp
sudo firewall-cmd --reload
```

Now, ports 9083 and 9085 have been added to the CentOS firewall rules and are allowed through the firewall.

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

### Deploy weIMPUTE on Ubuntu

To get started with weIMPUTE on Ubuntu, make sure your firewall allows ports **9083** and **9085** to be open. You can follow these steps:

```
sudo ufw allow 9083/tcp
sudo ufw allow 9085/tcp
sudo ufw enable
```

Now, ports 9083 and 9085 have been added to the Ubuntu firewall rules and are allowed through the firewall.

Run the **[DeployonUbuntu.sh](https://github.com/YOUTLab/weIMPUTE/blob/main/DeployonUbuntu.sh)** command.

Save the file 'DeployonUbuntu.sh' in the same folder as 'suanfa.txt,' then change the execute permission of 'DeployonUbuntu.sh' using the command:

```
sudo chmod 774 DeployonUbuntu.sh
```

After that, execute it using the following command.

```
./DeployonUbuntu.sh
```

It may take several minutes depending on your internet connection and computer resources. Then, your imputation server instance is ready and you are able to access it on.

http://IP:9083 

and

http://IP:9085

IP refers to the IP address of your local computer where weIMPUTE is installed.

### Deploy weIMPUTE on Windows

Ensure that Docker is installed correctly on Windows, and either disable the firewall or open ports 9083 and 9085.

Run the commands as follow:

```
docker load -i suanfa_v6.tar
docker run -d --privileged -p 9083:9083 -p 9085:9085 --net=bridge suanfa:v6
```

It may take several minutes depending on your internet connection and computer resources. Then, your imputation server instance is ready and you are able to access it on.

http://localhost:9083 

and

http://localhost:9085
## Example Website

If you deploy correctly, the local service should match the example website URL.

http://144.34.160.128:80

http://144.34.160.128:81

Enter the verification code and login as admin with the default admin password：

admin

admin123

**Attention! This example webpage is for demonstration purposes only and is intended solely for testing with small files. You can find the test file at the following link: DemoData/DemoFile. For testing with larger files, please deploy it to a high-performance server and then use it.** 



## Documentation

For specific usage instructions, please refer to [USAGE_GUIDE.pdf](USAGE_GUIDE.pdf).


## Quick Start
video:
[https://github.com/YOUTLab/weIMPUTE/blob/main/Quick%20start/quickstart7.7.mp4](https://github.com/YOUTLab/weIMPUTE/assets/141199195/df5b6cb3-dac0-4fef-a1bd-259a08361d41)https://github.com/YOUTLab/weIMPUTE/assets/141199195/df5b6cb3-dac0-4fef-a1bd-259a08361d41
