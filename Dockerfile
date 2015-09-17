FROM sameersbn/gitlab-ci-runner:latest

# Install Java openssh-server, maven and git.
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN \ 
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  apt-get install -y oracle-java8-installer && \
  apt-get install openssh-server maven git

  

# Install 
RUN apt-get clean

ADD assets/ /app/
RUN chmod 755 /app/setup/install
RUN /app/setup/install

# Use the customize init file.
RUN rm -f /app/init
ADD assets/init /app/init
RUN chmod 755 /app/init

EXPOSE 22
