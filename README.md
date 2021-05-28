# Trench Project R Docker Server
This repository contains the structure to build and host map.trenchproject.com through AWS and Docker.
Hosted projects can be found at: [map.trenchproject.com](https://map.trenchproject.com)

## Debugging in the R Docker Server
Live code can be viewed at [rstudio.trenchproject.com](rstudio.trenchproject.com) with login.
Further debugging requires ssh-ing into the EC2 instance using a keypair. Within the EC2 instance:
- code location: `cd /srv/shinyapps`
- print debugging logs: `docker logs shiny`
- live containiners: `docker ps`

---

## Building/Rebuilding the R Docker Server
This repository contains a build script to install and run a docker image (also located here) that will create and configure an r shiny and rstudio server to host various r shiny apps on an ec2 instance. To host more/ different apps, simply modify the apps pulled by the script and install any additional packages needed by modifying the dockerfile.  

### Execution 
To use this repository to create a new RShiny and RStudio Docker based server, create a new Linux 2 EC2 instance (suggest using a medium instance with >=25gb storage and >=4gb memory). If you create it with the security group "R-Docker-Server", you will automatically provide access to relevant ports. You also will need to have already created a free Docker account. Finally, you will need to add the subdomains `map` and `rstudio` to the desired domain (under advanced setting in Squarespace domains) as A records using the public ipv4 address of the EC2 instance. Ssh into the instance using a keypair.

If an EC2 instance exists and you need to rebuild it, simply ssh into it and continue below starting with Step 3.

Execute the following commands in the EC2 instance:
1. Install Git: 
`sudo yum install git -y`
2. Clone this repository: 
`git clone https://github.com/trenchproject/R-Docker-Server.git`
3. Make the scripts executable: 
`chmod +x ./R-Docker-Server/*.sh`
4. Execute the script `build.sh` with proper flags to install and configure Docker (This will terminate the ssh session and may take several minutes): 
`./R-Docker-Server/build.sh`
5. Execute the script `containers.sh` with proper flags to build, run, and secure R server containers (This may take several minutes): 
`./R-Docker-Server/containers.sh -u [Desired RStudio Username] -p [Desired RStudio Password]` 

If you recieve errors regarding access keys or the secret key, find these with:
`cat ~/.aws/credentials`

After the script has finished executing, 
- The RStudio server will be available via a browser at rstudio.trenchproject.com
- The RShiny apps are available via a browser at map.trenchproject.com
- To visit a specific RShiny app, navigate to map.trenchproject.com/<my_app_repository_name>

***Note:*** The inbound security group rules associated with the EC2 instance must be modified to include the following protocols in order to allow access to your newly constructed R ecosystem. If you used the R-Docker-Server security group when creating your instance, don't fret it has been done already!
- Port **80** from **anywhere** (Webserver- RShiny and RStudio)
- Port **443** from **anywhere** (Webserver- RShiny and RStudio)
