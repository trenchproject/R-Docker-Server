# Shiny-Docker-Server

This repository contains a build script to install and run a docker image (also located here) that will create and configure an r shiny and rstudio server to host various r shiny apps on an ec2 instance. To host more/ different apps, simply modify the apps pulled by the script and install any additional packages needed by modifying the dockerfile.  

## Execution 
To use this repository to create a new RShiny and RStudio Docker based server, create a new Linux 2 EC2 instance (suggest using a medium instance with >=25gb storage and >=4gb memory). If you create it with the security group "R-Docker-Server", you will automatically provide access to relevant ports. You also will need to have already created a free Docker account.
Then, ssh into the instance using a keypair and execute the following commands 
1. Install Git: 
`sudo yum install git -y`
2. Clone this repository: 
`git clone https://github.com/trenchproject/R-Docker-Server.git`
3. Make the scripts executable: 
`chmod +x ./R-Docker-Server/*.sh`
4. Execute the script `build.sh` with proper flags to install and configure Docker (This will terminate the ssh session and may take several minutes): 
`./R-Docker-Server/build.sh`
5. Execute the script `containers.sh` with proper flags to build, run, and secure R server containers (This may take several minutes): 
`./R-Docker-Server/containers.sh -u [Desired RStudio Username] -p [Desired RStudio Password] -e [Contact email for Let's Encrypt]` 

After the script has finished executing, 
- The RStudio server will be available via a browser at <my_public_ip>:8787 
- The RShiny apps are available via a browser at <my_public_ip>
- To visit a specific RShiny app, navigate to <my_public_ip>/my_app_repository_name

***Note:*** The inbound security group rules associated with the EC2 instance must be modified to include the following protocols in order to allow access to your newly constructed R ecosystem. If you used the R-Docker-Server security group when creating your instance, don't fret it has been done already!
- Port **80** from **anywhere** (Webserver/ RShiny Server)
- Port **8787** from **anywhere** (RStudio Server) 
