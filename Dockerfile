FROM centos:centos8

RUN dnf install -y epel-release && dnf makecache && dnf install ansible git -y
RUN ansible-galaxy collection install cisco.asa
RUN git config --global user.email "dragos.stan2602@gmail.com" && git config --global user.name "dragosstan2602"

RUN mkdir -p /home/ansible && mkdir -p ~/.ssh
COPY ansible_ssh_key /root/.ssh/ansible_ssh_key
COPY config /root/.ssh/config
RUN chmod -R 600 /root/.ssh/ansible_ssh_key
RUN chmod -R 600 /root/.ssh/config

WORKDIR /home/ansible
RUN git clone git@github.com:dragosstan2602/HomeLabConfigs.git

RUN mkdir -p /home/configs && mkdir -p group_vars host_vars roles

COPY *.yaml ./
COPY ansible.cfg ./
COPY full_run.sh ./
ADD group_vars/ group_vars/
ADD host_vars/ host_vars/
ADD roles/ roles/
RUN chmod +x full_run.sh

CMD ["./full_run.sh"]
