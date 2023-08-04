#!/bin/bash

#Function to display menu and take user choice
display_menu() {
	echo -e " \n"
	echo -e "------------ MENU ----------\n"
	echo "1. View Sysyem Metrices"
	echo "2. Monitor a service [e.g: nginx or httpd or any other]"
	echo "3. Exit"
	echo ""
        echo -e "--------------------------\n"
	read -p "Enter your choice : " choice 

}



# Function to display system metrics - CPU, Memory, and Disk Usage
display_metrics() {
    echo -e "========== System Metrics ==========\n"
    echo "CPU Usage:"
    top -bn 1 | grep "Cpu(s)" | awk '{print "   CPU Usage: " $2+$4 "%"}'
    echo -e " \n"
    echo "Memory Usage:"
    free -h
    echo -e " \n"
    echo "Disk Usage:"
    df -h 
    echo " "
    echo "==================================="
}



#Funtion to monitor a service.
monitor_service(){
	read -p "Enter the name of the service to monitor: " service_name
	if systemctl is-active --quiet $service_name; then
		echo " $service_name service is running."
	else
		echo " $service_name service is not running"
	fi
}

# clear the window
 clear


# MASTER ARRIVES 
while true; do
	display_menu

	case $choice in 
		1) display_metrics ;;
		2) monitor_service ;;
		3) echo "Exiting the script. Goodbye!" 
		   exit 0 ;;
		*) echo "Invalid option selected" ;;
	esac
done
