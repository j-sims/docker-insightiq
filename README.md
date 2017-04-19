### Overview
This provides a script and config files for installing Isilon InsightIQ in a docker container. By installing in a container under docker we can avoid port conflicts with other running services. It also provides a quickl, repeatable way to build IIQ instances for review IIQ DB dumps in a test environment.


### Instructions
- Install docker 1.6.2 or later
	https://docs.docker.com/installation/
- Ensure docker is operational
	docker -v
	docker ps -a
- (Required) Download latest IIQ .sh file and place existing in /files/
	Update answerfile if needed
- Edit the script and update the variables as needed
	(Required) Change the local datastore mount path - DATASTORE='/path/to/where/you/want/the/datastore/stored'
	vi ./docker_iiq.sh
	(Optional) Change the image and container name as desired
- Build the image
	 ./docker_iiq.sh build
- Run the Container
	./docker_iiq.sh start
- Check the logs
	./docker_iiq.sh logs
	CTRLC+C to quit
	Wait for Success starting message to appear
- Connect to the IIQ Instance
	https://$HOST:$HTTPSPORT
	HOST = The docker Host IP
	HTTPSPORT = Check docker_iiq.sh for this variable setting (Default:18443)
	Default User: Administrator
	Default Pass: a
- Stop and remove the container (including everything but the datastore)
	./docker_iiq.sh stop
- Remove the image that was built
	./docker_iiq.sh clean
- Change the password
	./docker_iiq.sh changepass

### Known Issues
- FSA does not function at this time
- Logs show broken pipe error
	----------------------------------------
	Exception happened during processing of request from ('::ffff:192.168.0.153', 59558, 0, 0)
	Traceback (most recent call last):
	 File "/usr/share/isilon/lib/python2.6/site-packages/Paste-1.7.5.1-py2.6.egg/paste/httpserver.py", line 1068, in process_request_in_thread
          self.finish_request(request, client_address)
	  File "/usr/share/isilon/lib64/python2.6/SocketServer.py", line 333, in finish_request
	    self.RequestHandlerClass(request, client_address, self)
	  File "/usr/share/isilon/lib64/python2.6/SocketServer.py", line 634, in __init__
	    self.finish()
	  File "/usr/share/isilon/lib64/python2.6/SocketServer.py", line 677, in finish
	    self.wfile.flush()
	  File "/usr/lib64/python2.6/socket.py", line 303, in flush
	    self._sock.sendall(buffer(data, write_offset, buffer_size))
	SysCallError: (32, 'Broken pipe')
