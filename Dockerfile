####
# Docker file for creating a xcms container
#
# A shared folder is created called /host
# this folder can be used to put the data and/or
# the script you want to call. Also scripts called 
# will be executed from this folder.
#
# build the container
# >> docker build -t xcms .
#
# run the container and mount the shared folder from 
# the host in the container
# >> docker run -v $HOST_PATH/host:/host xcms $SCRIPT
#
####

FROM ubuntu:14.04

MAINTAINER "Michael van Vliet" m.s.vanvliet@leidenuniv.nl

## add normal user
RUN useradd docker \
	&& mkdir /home/docker \
	&& chown docker:docker /home/docker \
	&& addgroup docker staff

RUN mkdir /host
RUN cd /host
WORKDIR /host

# perform installation of required linux dependencies
RUN apt-get -y update && apt-get install -y \
	lynx \
	r-base \
	r-base-dev \
	libnetcdf-dev \
	netcdf-bin \
	libglu1-mesa-dev \
	nano
	
# perform installation of R dependencies
ADD rlibs.sh .
RUN chmod 755 ./rlibs.sh
RUN chmod +X ./rlibs.sh
RUN ./rlibs.sh

# prepare entrypoint of image
ENTRYPOINT ["Rscript"]
CMD ["--help"]
