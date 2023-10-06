FactoryBot.define do
    factory :admin do
      name { "Admin User" }
      email { "admin@example.com" }
      password { "password" }
      phone_number { "1234567890" }
      address { "Admin Address" }
      credit_number { "1234567890123456" }
    end
  end