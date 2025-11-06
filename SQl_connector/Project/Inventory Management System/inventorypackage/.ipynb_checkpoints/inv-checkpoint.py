import os

# Get the directory of the current file
current_dir = os.path.dirname(os.path.abspath(__file__))

# Construct the full path to the products.txt file
products_file_path = os.path.join(current_dir, "products.txt")

# Open and read the products.txt file
with open(products_file_path, "r") as f1:
    products = f1.read().split("\n")

# Define the decorator function
def decorator_func(og_function):
    def wrapper_function(*args):
        print("Welcome to your Inventory")
        result = og_function()
        print("Thanks for shopping with us")
        return result
    return wrapper_function

@decorator_func
def Product_id_details():
    found = False
    ui_prod_id = input("Enter the product id: ")
    ui_prod_qty = input("Enter the qty you need: ")
    for product in products:
        if ui_prod_id == product.split(",")[0]:
            print(product)
            if int(product.split(",")[3]) >= int(ui_prod_qty):
                product_list = product.split(",")
                product_list[3] = str(int(product_list[3]) - int(ui_prod_qty))
                products[products.index(product)] = ",".join(product_list)
                found = True
                break
    if not found:
        print("Unfortunately, we don't have the product id you entered.")

# Call the function
Product_id_details()
