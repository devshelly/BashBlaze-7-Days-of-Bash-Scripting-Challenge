#!/bin/bash

# Usage Display

usage_function() {
	echo "Usage: $0 <option>"
	echo " Options are as under: "
	echo "  -c, --create  : Create a new user account"
        echo "  -d, --delete  : Delete an existing user account"
        echo "  -r, --reset   : Reset the password of an existing user account"
        echo "  -l, --list    : List all user accounts"
        echo "  -h, --help    : Display this help message"
}

# Check username exists or not.

username_exist() {
	local username="$1"
	id "$username" &>/dev/null
}

# Function to create new user

create_new_user() {
	read -p "Enter username to be created: " new_user
	
	if username_exist "$new_user"; then
		echo "Username $new_user already exist. Choose a different one."
		exit 1
	fi

	read -sp "Enter password for $new_user: " new_pass
	sudo useradd -m -s /bin/bash $new_user
	echo "$new_user:$new_pass" | sudo chpasswd
	echo ""
	echo "User $new_user created successfully."
}

# Function for user deletion

user_del() {
	read -p "Enter the username to delete: " del_user

	if ! username_exist "$del_user"; then
		echo " user $del_user doesn't exist."
		exit 1 
	fi

	sudo userdel -r $del_user
	echo "User $del_user deleted successfully"
}

#function to reset exixting user password

pass_change() {
	read -p "Enter exixting username for password reset: " username_passReset

	if ! username_exist "$username_passReset"; then
		echo "username $username_passReset doesn't exist."
		exit 1
	fi

	read -sp "Enter the new password for $username_passReset :" new_pswd
	echo ""
	echo "$username_passReset:$new_pswd" | sudo chpasswd
	echo "Password for $username_passreset changed successfully".
}


#function to list user account
list_user_accounts() {
	echo ""
	echo -e "############################\n"
	echo -e " LISTS OF ALL USER ACCOUNTS\n"
	echo -e "############################\n"
	awk -F: '{print NR, "Username: ", $1,"  ", "UID: ", $3}' /etc/passwd 
}

case $1 in 
	-c|--create) create_new_user ;;
	-d|--delete) user_del ;;
	-r|--reset) pass_change ;;
	-l|--list) list_user_accounts ;;
	-h|--help) usage_function ;;
	*) echo "Invalid option: please pass "-h or --help" as an argument for help"
esac

