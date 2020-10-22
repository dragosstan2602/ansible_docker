#!/bin/bash

cd /home/ansible_docker && git pull
cd /home/HomeLabConfigs && git pull
cd /home/ansible_docker && ansible-playbook -i hosts.yaml pb_pull_configs.yaml
cd /home/HomeLabConfigs && git add . && git commit -m "Docker commit $(date +"%Y.%m.%d-%H:%M")" && git push