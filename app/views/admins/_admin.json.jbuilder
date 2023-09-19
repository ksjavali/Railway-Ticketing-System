json.extract! admin, :id, :username, :name, :email, :password, :phone_number, :address, :credit_card, :created_at, :updated_at
json.url admin_url(admin, format: :json)
