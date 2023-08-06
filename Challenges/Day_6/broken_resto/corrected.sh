#!/bin/bash

# Define a function to display the restaurant menu
function display_menu() {
    echo "Welcome to the Restaurant!"
    echo "Menu:"
    echo "1. Burger - ₹120"
    echo "2. Pizza - ₹250"
    echo "3. Salad - ₹180"
    echo "4. Soda - ₹40"
    echo "5. Pasta - ₹180"
    echo "6. Sandwich - ₹150"
    echo "7. Coke - ₹50"
    echo "8. Fries - ₹100"
    echo "9. Ice Cream - ₹120"
}

# Define item prices using an associative array
declare -A item_prices
item_prices[1]=120
item_prices[2]=250
item_prices[3]=180
item_prices[4]=40
item_prices[5]=180
item_prices[6]=150
item_prices[7]=50
item_prices[8]=100
item_prices[9]=120

# Define a function to calculate the total bill
function calculate_total_bill() {
    local total=0
    for i in "${!order[@]}"; do
        total=$((total + (order[$i] * item_prices[$i])))
    done
    echo "$total"
}

# Define a function to handle invalid user input
function handle_invalid_input() {
    echo "Invalid input! Please enter a valid item number and quantity."
}

# Main script starts here

# Display the menu to the customer
display_menu

# Ask for the customer's name
read -p "Please enter your name: " customer_name
if [ ${#customer_name} -eq 0 ]; then
    echo "No name was entered."
    exit 1
fi

# Ask for the order
echo "Please enter the item number and quantity (e.g., 1 2 for two Burgers):"
read -a input_order
if [ $(( ${#input_order[@]} % 2 )) -ne 0 ]; then
    echo "Please enter the quantity of the last item you mentioned."
    exit 1
fi

# Process the customer's order
declare -A order
for (( i = 0; i < ${#input_order[@]}; i += 2 )); do
    item_number="${input_order[i]}"
    quantity="${input_order[i+1]}"
    order[$item_number]=$quantity
done

# Calculate the total bill
total_bill=$(calculate_total_bill)

# Display the total bill to the customer
echo "Thank you, $customer_name! Your total bill is ₹$total_bill."

