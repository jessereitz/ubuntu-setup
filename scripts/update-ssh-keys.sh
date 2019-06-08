#! /usr/bin/env bash
echo "Downloading ssh keys from GitHub for jessereitz"
curl https://github.com/jessereitz.keys > /home/jessereitz/.ssh/authorized_keys
echo "Done."