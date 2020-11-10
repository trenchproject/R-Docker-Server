# Shiny-Docker-Server

This repository contains a build script to install and run a docker image (also located here) that will create and configure an r shiny and rstudio server to host various r shiny apps on an ec2 instance. To host more/ different apps, simply modify the apps pulled by the script and install any additional packages needed by modifying the dockerfile.  

## Execution 
To use this repository to create a new RShiny and RStudio Docker based server, create a new Linux 2 EC2 instance (suggest using a medium instance with >=25gb storage and >=4gb memory). If you create it with the security group "R-Docker-Server", you will automatically provide access to relevant ports.
Then, ssh into the instance using a keypair and execute the following commands 
1. Install Git
`sudo yum install git -y`
2. Clone this repository 
`git clone https://github.com/trenchproject/R-Docker-Server.git`
3. Enter the cloned repository 
`cd R-Docker-Server`
4. Make the script executable
`chmod +x build.sh`
5. Execute the script (This may take several minutes)
`./build`


After the script has finished executing, 
- The RStudio server will be available via a browser at <my_public_ip>:8787 
- The RShiny apps are available via a browser at <my_public_ip>
- To visit a specific RShiny app, navigate to <my_public_ip>/my_app_repository_name

***Note:*** The inbound security group rules associated with the EC2 instance must be modified to include the following protocols in order to access your newly constructed R ecosystem. (If you used the R-Docker-Server security group when creating your instance, don't fret it has been done already!)
- Port **80** from **anywhere** (Webserver/ RShiny Server)
- Port **8787** from **anywhere** (RStudio Server) 
