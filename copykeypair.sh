#!/bin/bash

function copyonserver(){
  echo -n "Enter the name of the .pub file - assuming this is held in `pwd` [ENTER]: "
  read pubfile
  cat $pubfile >> ~/.ssh/authorized_keys && echo 'Public key added' || echo 'Public key not added'
  exit 0
}

function copytoserver(){
  echo -n "Enter the name of the .pub file - assuming this is held in `pwd` [ENTER]: "
  read pubfile
  echo -n "Enter the address of your server [ENTER]: "
  read server
  echo -n "Enter your username to login with [ENTER]: "
  read user
  echo -n "Enter the name of your .pem file to login with - assuming this is held in .ssh [ENTER]: "
  read keypair

  cat $pubfile | ssh -i ~/.ssh/$keypair $user@$server 'cat >> .ssh/authorized_keys' && echo 'Public key added' || echo 'Public key not added'
  exit 0
}

while true; do
    read -p "Are you already logged into the remote server? " yn
    case $yn in
        [Yy]* ) copyonserver ;;
        [Nn]* ) copytoserver ;;
        * ) echo "Please answer y or n. ";;
    esac
done
