json.array!(@purchases) do |purchase|
  json.extract! purchase, :amount, :quantity, :user_id, :is_active
  json.url purchase_url(purchase, format: :json)
end
