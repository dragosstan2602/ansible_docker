FROM centos:centos8

RUN dnf install -y epel-release && dnf makecache && dnf install ansible git -y

# CONFIGURE GIT FOR SSH ACCESS
RUN git config --global user.email "dragos.stan2602@gmail.com" && git config --global user.name "dragosstan2602"
RUN mkdir -p ~/.ssh
COPY ansible_ssh_key /root/.ssh/ansible_ssh_key
COPY config /root/.ssh/config
RUN chmod -R 600 /root/.ssh/ansible_ssh_key
RUN chmod -R 600 /root/.ssh/config

# CONFIGURE ANSIBLE PLAYBOOKS
WORKDIR /home/
RUN git clone git@github.com:dragosstan2602/ansible_docker.git
RUN git clone git@github.com:dragosstan2602/HomeLabConfigs.git

RUN chmod +x ansible_docker/full_run.sh

# RUN ANSIBLE PLAYBOOKS
CMD ["./ansible_docker/full_run.sh"]