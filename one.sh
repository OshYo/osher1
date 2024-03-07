#!/bin/bash

DATA_FILE="people.txt"

# Function to check if ID already exists
check_id_existence() {
    id=$1
    if grep -q "^$id:" "$DATA_FILE"; then
        return 0  # ID exists
    else
        return 1  # ID does not exist
    fi
}

# Function to add a person to the data file
add_person() {
    echo "$1:$2:$3" >> "$DATA_FILE"
    echo "Person added successfully."
}

# Function to display a person's details by ID
display_by_id() {
    id=$1
    person=$(grep "^$id:" "$DATA_FILE")
    if [ -n "$person" ]; then
        echo "$person"
    else
        echo "Person with ID $id not found."
    fi
}

# Function to display people's details by first name or last name
display_by_name() {
    name=$1
    grep -i "$name" "$DATA_FILE"
}

# Main menu
while true; do
    echo "Main Menu:"
    echo "1. Add a person"
    echo "2. Search by ID"
    echo "3. Search by name"
    echo "4. Display all people"
    echo "5. Exit"

    read -p "Please choose an option: " choice

    case $choice in
        1)
            read -p "Enter first name: " first_name
            read -p "Enter last name: " last_name
            read -p "Enter ID: " id
            if check_id_existence "$id"; then
                echo "ID already exists."
            else
                add_person "$first_name" "$last_name" "$id"
            fi
            ;;
        2)
            read -p "Enter ID to search: " id
            display_by_id "$id"
            ;;
        3)
            read -p "Enter name to search: " name
            display_by_name "$name"
            ;;
        4)
            echo "People List:"
            cat "$DATA_FILE"
            ;;
        5)
            echo "Exiting program."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
