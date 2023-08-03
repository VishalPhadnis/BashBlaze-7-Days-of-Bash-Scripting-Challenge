#!/bin/bash

# Function to display usage information and available command-line options
function display_usage {
    echo "Usage: $0 [OPTIONS]"  # Display the script usage
    echo "Options:"
    echo "  -c, --create  Create a new user account"
    echo "  -d, --delete  Delete an existing user account"
    echo "  -r, --reset   Reset the password of an existing user account"
    echo "  -l, --list    List all user accounts on the system"
    echo "  -h, --help    Display this help message"
}

# Function to check if a user exists
function check_user_existence {
    local username=$1
    id "$username" &>/dev/null  # Check if the given username exists using the 'id' command
    return $?  # Return the exit status of the 'id' command (0 if user exists, non-zero otherwise)
}

# Function to create a new user account
function create_user_account {
    read -p "Enter the new username: " new_username  # Prompt for new username

    # Check if the username already exists
    if check_user_existence "$new_username"; then
        echo "Error: Username already exists. Please choose a different username."
        exit 1
    fi

    # Prompt for password and create the user
    read -s -p "Enter the password for $new_username: " new_password  # Prompt for new password
    echo
    useradd "$new_username" --create-home --password "$new_password"  # Create user with specified username and password

    echo "User account '$new_username' created successfully."
}

# Function to delete an existing user account
function delete_user_account {
    read -p "Enter the username to be deleted: " delete_username  # Prompt for username to be deleted

    # Check if the username exists
    if ! check_user_existence "$delete_username"; then
        echo "Error: Username '$delete_username' does not exist."
        exit 1
    fi

    userdel -r "$delete_username"  # Delete the user account and associated files
    echo "User account '$delete_username' deleted successfully."
}

# Function to reset the password of an existing user account
function reset_user_password {
    read -p "Enter the username for password reset: " reset_username  # Prompt for username to reset password

    # Check if the username exists
    if ! check_user_existence "$reset_username"; then
        echo "Error: Username '$reset_username' does not exist."
        exit 1
    fi

    read -s -p "Enter the new password for $reset_username: " new_password  # Prompt for new password
    echo
    echo "$reset_username:$new_password" | chpasswd  # Set the new password for the user

    echo "Password for user account '$reset_username' reset successfully."
}

# Function to list all user accounts on the system
function list_user_accounts {
    echo "Listing all user accounts:"
    awk -F: '{print "Username:",$1,"\tUID:",$3}' /etc/passwd  # Use 'awk' to print usernames and UIDs from /etc/passwd
}

# Parse command-line options
while [[ "$1" != "" ]]; do
    case $1 in
        -c | --create)
            create_user_account  # Call the create_user_account function
            ;;
        -d | --delete)
            delete_user_account  # Call the delete_user_account function
            ;;
        -r | --reset)
            reset_user_password  # Call the reset_user_password function
            ;;
        -l | --list)
            list_user_accounts  # Call the list_user_accounts function
            ;;
        -h | --help)
            display_usage  # Call the display_usage function
            exit 0
            ;;
        *)
            echo "Error: Invalid option '$1'."
            display_usage  # Call the display_usage function
            exit 1
            ;;
    esac
    shift
done

# If no options provided, display usage information
if [[ "$#" -eq 0 ]]; then
    echo "Error: No options provided."
    display_usage  # Call the display_usage function
    exit 1
fi




