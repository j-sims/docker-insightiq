### Isilon InsightIQ in Docker

This provides a script and config files for installing Isilon InsightIQ in a Docker container.
By installing in a container under Docker we can avoid port conflicts with other running services.
It can be installed on any host that supports Docker.
It also provides a quick, repeatable way to build IIQ instances to review IIQ DB dumps in a test environment.

*Warning:* This is *not* an officially supported installation method.
Do not use this in production environments.
Use at your own risk.

### Instructions

1. Install Docker 1.6.2 or later
    https://docs.docker.com/installation/

2. Ensure Docker is operational
    ```
    docker -v
    docker ps -a
    ```
3. Clone this repository
    `https://github.com/j-sims/docker-insightiq.git`
    
4. Checkout Branch to match version of InsightIQ
    `git checkout 4.X.X.X` or leave as-is for latest version
    
5. Download Isilon InsightIQ (install-insightiq-4.X.X.X.sh) Installation File for Linux Computers from support.emc.com place it in /files/.
   1. Note: Other versions may require updates to /files/answerfile.

6. (Optional) Edit the docker_iiq.sh script and update the variables as needed.
   1. Change the local datastore mount path - DATASTORE='/path/to/where/you/want/the/datastore/stored'
   2. Change the image and container name as desired
   
7. Build the image
   1. `./docker_iiq.sh build`

8. Run the Container
   1. `./docker_iiq.sh start`

9. Set the password
   1. `./docker_iiq.sh changepass`
   
10. Check the logs
   1. `./docker_iiq.sh logs`
   2. CTRL+C to quit

11. Connect to the IIQ Instance
   * https://$HOST:$HTTPSPORT
   * HOST = The docker Host IP
   * HTTPSPORT = Check docker_iiq.sh for this variable setting (Default:18443)
   * Default User: Administrator

12. When prompted to choose the Datastore, select Local Datastore with path `/datastore`.

### Optional Commands
 
1. Stop and remove the container (including everything but the datastore)
   * `./docker_iiq.sh stop`

2. Remove the image that was built
   * `./docker_iiq.sh clean`

### Known Issues
	No known issues at this time.
   ```
### Acknowledgements
Thanks to Claudio Fahey for contributing the 4.1.2 update
