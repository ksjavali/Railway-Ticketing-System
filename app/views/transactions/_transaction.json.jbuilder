json.extract! transaction, :id, :transaction_number, :credit_number, :ticket_price, :address, :phone_number, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
