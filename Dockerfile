FROM registry.fedoraproject.org/fedora:30

ENV LANG C.UTF-8

RUN dnf -y update && \
    dnf -y install 'dnf-command(copr)' && \
    dnf -y copr enable jdoss/wireguard && \
    dnf -y install \
      gcc \
      gcc-c++ \
      git \
      libffi-devel \
      libgit2-devel \
      python3-devel \
      openssl-devel \
      swig \
      virtualenv \
      wireguard-tools \
      zeromq-devel && \
    rm -rf /usr/share/doc /var/cache/dnf

RUN virtualenv --python=python3 /opt/salt
RUN /opt/salt/bin/pip install --upgrade --no-binary ":all:" \
      "pip" \
      "setuptools"
RUN /opt/salt/bin/pip install --upgrade --no-binary ":all:" \
      "salt==2019.2.0" \
      "Jinja2" \
      "MarkupSafe" \
      "PyYAML" \
      "cherrypy" \
      "distro" \
      "m2crypto" \
      "msgpack" \
      "psutil" \
      "pycrypto>=1.6.1" \
      "pygit2==0.27.3" \
      "pyvmomi" \
      "pyzmq<17.1.0" \
      "requests" \
      "tornado<5.0"

RUN ln -s /opt/salt/bin/salt /usr/local/bin/salt
RUN ln -s /opt/salt/bin/salt-cp /usr/local/bin/salt-cp
RUN ln -s /opt/salt/bin/salt-key /usr/local/bin/salt-key
RUN ln -s /opt/salt/bin/salt-run /usr/local/bin/salt-run

VOLUME /etc/salt
VOLUME /var/log/salt
VOLUME /var/run/salt/master

EXPOSE 4505
EXPOSE 4506
EXPOSE 4507
