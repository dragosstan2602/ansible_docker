#!/bin/bash
cd HomeLabConfigs && git pull
cd .. && ansible-playbook -i hosts.yaml pb_test.yaml
cd HomeLabConfigs && git add . && git commit -m "Docker commit $(date +"%Y.%m.%d-%H:%M")" && git push
