            BOOKSTORE DATABASE CREATION AND DATA INSERTION SCRIPT

# Overview

This SQL script is designed to create a database named `BookStore` and populate it with tables and sample data for a bookstore management system. It also includes user creation and privilege assignment for different roles (admin, staff, and reporting).

# The database includes the following tables:

`order_history`: Tracks the history of orders, including status changes.
`order_status`: Stores the different statuses of an order.
`order_line` : Contains the line items for each order (books and quantities).
`cust_order` : Stores customer order information.
`shipping_method` : Lists available shipping methods and their costs.
`book_author` : Links books to their authors.
`book` : Stores book information.
`author` : Stores author information.
`book_language` : Lists available book languages.
`publisher`: Stores publisher information.
`customer_address` : Links customers to their addresses and address statuses.
`customer` : Stores customer information.
`address_status` : Stores address status types.
`address` : Stores address information.
`country` : Stores country information.

# User Creation and Privileges

The script creates three users with different privileges:

`bookstore_admin`: Has full administrative privileges on the database.
`bookstore_staff`: Has select, insert, update, and delete privileges on most tables, but only select privileges on `order_history`, `order_status`, `shipping_method`, `book_author`, and `book`.
`bookstore_report`: Has read-only access to all tables for reporting purposes.

# Data Insertion

The script inserts sample data into the following tables:

`book_language`
`publisher`
`author`
`book`
`book_author`
`address_status`
`country`
`order_status`
`shipping_method`

# Data Retrieval and Analysis Queries

The script includes example queries for data retrieval and analysis, such as:

Filtering books by language (IsiXhosa, IsiZulu, Setswana).
Calculating the total stock value of books per publisher.
Listing shipping methods and their costs.

# Group Collaboration
Group Members: 
Adeleke Elijah Sunday
Kibet Mary Jeptepkeny
Sinothando Johnson 
