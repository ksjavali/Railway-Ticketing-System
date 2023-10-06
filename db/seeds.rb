# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    admin = Admin.create!([{ name: 'Admin',username:"admin",email: 'admin@gmail.com',password:"admin", phone_number:1234567890,credit_number: 1234123412341234}])
    user_admin = Passenger.create!([{ name: 'Admin',email: 'admin_dummy@gmail.com',password:"admin", phone_number:1234567890,credit_number: 1234123412341234,is_admin:true}])
