FROM golang:1.10.3
MAINTAINER Bilbo Baggins <ilcartographer90@gmail.com>

# Stripped down version of: https://github.com/bibinwilson/jenkins-docker-slave/blob/master/Dockerfile
# This image is intended to be used as a Jenkins build slave for Golang

# Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git
# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN apt-get install -y default-jre default-jdk
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]