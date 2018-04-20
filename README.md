# rpi-metasploit

Docker Container for Metasploit configured with database.

To build:

docker build .

Run the Container with args for ports necessary for exploit communications:

docker run -it --name msf-container -p 4444:4444 <image_name> 

Once container starts, run:

./msfconsole
