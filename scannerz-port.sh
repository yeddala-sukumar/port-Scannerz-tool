#!/bin/bash

banner() {
    clear  
    figlet "ScannerZ"  
    echo "############################################"
    echo "#                                          #"
    echo "#              Port Scanner                #"
    echo "#                                          #"
    echo "#         Developer: Sukumar               #"
    echo "############################################"
    echo ""
}

scan_ports() {
    local target=$1
    local start_port=$2
    local end_port=$3
    local open_ports=()
    echo "Scanning $target..."
    for port in $(seq $start_port $end_port); do
        nc -z -w 1 $target $port &> /dev/null
        if [ $? -eq 0 ]; then
            echo "Port $port is open"
            open_ports+=($port)
        else
            echo "Port $port is closed"
        fi
    done
    if [ ${#open_ports[@]} -gt 0 ]; then
        echo -e "\nOpen Ports: ${open_ports[@]}"
    else
        echo -e "\nNo open ports found."
    fi
}

main() {
    # Display the banner using figlet
    banner

    # Get target (IP or domain)
    read -p "Enter the website or IP address to scan: " target

    # Validate target input
    if [[ -z "$target" ]]; then
        echo "Target cannot be empty."
        exit 1
    fi
    start_port=1
    end_port=1000
    start_time=$(date +%s)
    scan_ports $target $start_port $end_port
    end_time=$(date +%s)
    elapsed_time=$((end_time - start_time))
    echo -e "\nScan completed in $elapsed_time seconds."
}


main

