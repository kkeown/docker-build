FROM 9.212.156.58:6000/library/smd_rhel65_server

ENV ARTIFACT_REPO http://sbybz221159.cloud.dst.ibm.com/artifacts
ENV IBM_JRE_VERSION 8.0-1.10
ENV UCD_SERVER ibm-ucd-6.1.3.0.695062
ENV UCD_SERVER_ZIP http://sbybz221159.cloud.dst.ibm.com/artifacts/$UCD_SERVER.zip
ENV IBM_UCD_SECURE true

RUN set -x \
    && yum update -y \
    && yum -y install tar \
    && yum -y install unzip \
    && yum -y install openssh-clients \
	&& yum clean packages

RUN set -x \
  && mkdir -p /opt/java \
  && cd /opt/java \
  && wget -O - $ARTIFACT_REPO/ibm-java-x86_64-jre-8.0-1.10.tar.gz | tar xzf -

RUN yum clean packages

ENV JAVA_HOME /opt/java/ibm/java-x86_64-80/jre
ENV PATH $JAVA_HOME/bin:$PATH

WORKDIR /opt/ibm-ucd/server
VOLUME /ucddata
VOLUME /appsdata
EXPOSE 8080 9443 7918
COPY installtools/ /installtools/

RUN /installtools/install_ucd.sh $UCD_SERVER_ZIP
COPY setup_certs.sh /

# copy component artifacts 
RUN mkdir /artifacts
COPY artifacts/ /artifacts/

# copy server keys
RUN mkdir /keystores
COPY keys/ /keystores/

RUN rm -f /$UCD_SERVER.zip

# by default run the ucd server command with the run option
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["server", "run"]