#!/bin/bash

echo "running taccoform script"
echo ""
sudo yum -y update && sudo yum -y install cowsay

cowsay 'this packer thing works'
