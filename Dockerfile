FROM sameersbn/gitlab-ci-runner:latest

# Install Java openssh-server, maven and git.
RUN \
  sudo add-apt-repository ppa:openjdk-r/ppa \
  apt-get update && \
  apt-get install openjdk-8-jdk && \
  apt-get install -y openssh-server maven git
  

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
