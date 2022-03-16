docker build -t workato-agent:latest .

** remember to add the local folder to be mountable by docker **
docker run -it --name opa --publish-all -v /usr/local/workato/conf:/opt/workato/workato-agent/conf -v /usr/local/workato/files:/var/opa/files workato-agent:latest


** Using the password encryptor running within the container **
docker exec -it opa /opt/workato/workato-agent/bin/encryptor.sh