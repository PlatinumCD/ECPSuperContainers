FROM registry.access.redhat.com/ubi8:8.2-347
RUN yum update -y --skip-broken --nobest \
  	--exclude=dbus-daemon \
  	--exclude=filesystem \
	--exclude=trousers \
	--exclude=util-linux \
	--exclude=unbound-libs && \
    yum install -y libevent libevent-devel \
	kernel-headers perl python3 gcc \
	wget unzip tar make gcc openssl-devel libcurl-devel expat-devel \
	https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
