#!/bin/bash

sftp_user=julien
sftp_user_def=$sftp_user::$(id -u)
sftp_home=/home/$sftp_user
sftp_share=$sftp_home/share
local_share=~/share

image=atmoz/sftp
container_name=sftp

cmd=$1
script_path=$(dirname $(realpath -s $0))

if [[ "$1" == "start" ]]
then
    mkdir -p $local_share
    echo Starting container $container_name...
    docker run \
    -v $script_path/../secrets/ssh_host_ed25519_key:/etc/ssh/ssh_host_ed25519_key \
    -v $script_path/../secrets/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key \
    -v $script_path/../pubkeys:$sftp_home/.ssh/keys:ro \
    -v $local_share:$sftp_share \
    --name $container_name \
    -p 2222:22 -d $image \
    $sftp_user_def
    echo Container $container_name started
elif [[ "$1" == "stop" ]]
then
    echo Stopping container $container_name...
    docker stop $container_name
    echo Container $container_name stopped
elif [[ "$1" == "clean" ]]
then
    docker rm $container_name
else
echo "Usage: $0 start | stop | clean"
fi