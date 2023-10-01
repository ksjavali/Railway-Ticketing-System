# Online Rail Ticket Application

Please send an email to sshastr4@ncsu.edu if application is not running on VCL.

## Link to deployed application:
The application is deployed on this link:<br>  http://152.7.177.10:8080/


## Admin Credentials:
* Email: admin@gmail.com
* Password: admin

## Ruby version:
* 3.0.2

## Rails version: 
* 6.1.7

## Getting started:
### Clone the repository:
```
git clone https://github.ncsu.edu/ksjavali/CSC-517-Program2
```

### Go to the directory:
```
cd CSC-517_Program2
```

### Install required Gems:
```
bundle install
```
### Run database migration on your system:
```
rails db:migrate
```
### Run seed for the setting up required data:
```
rails db:seed
```
### Run the rails server:
```
rails server
```
## Database structure:

<img width="925" alt="Screenshot 2023-09-30 at 7 07 47 PM" src="https://media.github.ncsu.edu/user/26587/files/bf361145-a1fb-4cb7-942f-803e7bbf4d49">

## Components:
### Admin
<b>Attributes:</b>
* Username
* Name
* Email
* Password
* Phone number
* Address
* Credit number

<b>Functionalities:</b>

* Authentication:<br> Log in with a username (or email) and password.
* Profile Management:<br> Edit their own profile (except for ID, username, and password).
* Train Management:<br> View all available trains on the website. <br>List trains by specific departure or termination stations.<br>
* User Management:<br> View all users signed up for the website.
* Review Management:<br>List reviews written by a specific user.<br>
List reviews written for a specific train.<br>
* Passenger Management:<br> Create, view, edit, and delete passengers.
* Train Management:<br>Create, view, edit, and delete trains.
* Ticket Management:<br>Create, view, edit, and delete tickets.
* Review Management:<br>Create, view, edit, and delete reviews.


### Passenger
<b>Attributes:</b>

* ID
* Username
* Name
* Email
* Password
* Phone number
* Address
* Credit-card information (fake)


<b>Functionalities:</b>

* Authentication: <br>Sign up for a new account,<br>Log in with a username (or email) and password.
* Profile Management: <br>Edit their own profile (excluding ID).<br>Delete their own account.
* Train Booking:<br>View upcoming trains with available seats. <br>List trains with an average rating above a certain threshold.<br>List trains by specific departure or termination stations.<br>Book a train.<br>Cancel a ticket.<br>Check their trip history.<br>
* Review Management:<br>Write and edit their own train reviews.<br>List reviews written by a specific user.<br>List reviews written for a specific train.

### Train
<b>Attributes:</b>

* ID
* Train number
* Departure station
* Termination station
* Departure date
* Departure time
* Arrival date
* Arrival time
* Ticket price
* Train capacity (maximum seats available)
* Number of seats left


<b>Functionalities:</b>

* Train Management: <br>Admin can create, view, edit, and delete trains.<br>
* Ticket Booking:<br>Passengers can book a train.<br>

### Ticket
<b>Attributes:</b>

* ID
* Passenger ID
* Train ID
* Confirmation Number


<b>Functionalities:</b>
* Ticket Booking:<br>Passengers can book a train.<br>

### Review
<b>Attributes:</b>

* Passenger ID
* Train ID
* Rating (1 – 5)
* Feedback

<b>Functionalities:</b>

* Review Management:<br>Passengers can write and edit their own train reviews.<br>Admin can create, view, edit, and delete reviews.<br>
* Review Listing:<br>List reviews written by a specific user.<br>List reviews written for a specific train.<br>

### Extra credit:
Implement a search function for the admin to use. The input is the train number; the search result is a list of users who booked this train: Done

### Contibutors:
1. [Akshat Saxena](https://github.ncsu.edu/asaxen24)
2. [Kritika Javali](https://github.ncsu.edu/ksjavali)
3. [Skanda Shastry](https://github.ncsu.edu/sshastr4)
