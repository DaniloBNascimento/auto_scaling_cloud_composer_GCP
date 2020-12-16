#!/bin/sh

# --- variables --- #
PROJECT="projeto-vpn-001"
ZONE="us-central1-a"

# coletando nome do grupo de instâncias gerenciadas
NAME_INSTANCE_GRP=$(gcloud compute instance-groups list | grep airflow | cut -f 1 -d " ")

# gerando self-link
SELFLINK="projects/$PROJECT/zones/$ZONE/instanceGroupManagers/$NAME_INSTANCE_GRP"

# gerando selflink em JSON
jq -n --arg SELFLINK $SELFLINK '{self_link:$SELFLINK}'