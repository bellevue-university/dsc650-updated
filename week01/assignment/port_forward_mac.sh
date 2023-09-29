#!/bin/bash

# Mac OS Script for Port Forwarding

# Get user input for username, IP, and private key location
read -p "Enter your username: " username
read -p "Enter the external IP address: " external_IP
read -p "Enter the location of your private key (default: $HOME/.ssh/id_rsa): " key_location

# Default the private key location if not provided
if [ -z "$key_location" ]; then
    key_location="$HOME/.ssh/id_rsa"
fi

# Define a function to forward port and open browser in a new Terminal window
port_forward() {
    local protocol="http"
    if [ "$1" == "8443" ]; then
        protocol="https"
    fi
    
    echo "Setting up forwarding for port $1..."
    osascript <<END
    tell application "Terminal"
        do script "echo 'Forwarding port $1...'; ssh -i $key_location -L $1:localhost:$1 $username@$external_IP"
    end tell
END
    sleep 2 # Give it some time to initiate the ssh command
    open "$protocol://localhost:$1$2"
}

# HDFS
port_forward 9870 ""
# YARN
port_forward 8088 ""
# Spark Master
port_forward 8080 ""
# Spark History
port_forward 18080 ""
# HBASE
port_forward 16010 ""
# Solr
port_forward 8983 ""
# NIFI
port_forward 8443 "/nifi"

echo "Port forwarding sessions opened in separate Terminal windows. Close each SSH session when you are done with the services."

