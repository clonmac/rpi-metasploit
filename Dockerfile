FROM resin/rpi-raspbian:stretch
MAINTAINER Aaron Guhl

# Install dependencies
RUN apt-get update && \
	apt-get -y install \
	build-essential \
	zlib1g \
	zlib1g-dev \
	libxml2 \
	libxml2-dev \
	libxslt-dev \
	locate \
	libreadline6-dev \
	libcurl4-openssl-dev \
	git-core \
	libssl-dev \
	libyaml-dev \
	openssl \
	autoconf \
	libtool \
	ncurses-dev \
	bison \
	curl \
	wget \
	postgresql \
	postgresql-contrib \
	libpq-dev \
	libapr1 \
	libaprutil1 \
	libsvn1 \
	libpcap-dev \
	git-core \
	ruby \
	ruby-dev \
	sqlite3 \
	libsqlite3-dev \
	nmap \
	gem

RUN gem install wirble sqlite3 bundler

RUN cd /opt && git clone https://github.com/rapid7/metasploit-framework.git && cd metasploit-framework && bundle install

RUN /etc/init.d/postgresql start && su postgres -c "psql -c \"CREATE USER msf WITH PASSWORD 'msf';\"" && su postgres -c "createdb -O msf msf"

COPY database.yml /opt/metasploit-framework/config/database.yml

# Define working directory
WORKDIR /opt/metasploit-framework/

# Define default command
CMD /etc/init.d/postgresql start && /bin/bash
