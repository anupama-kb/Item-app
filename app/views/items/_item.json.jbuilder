json.extract! item, :id, :name, :rate, :item_category_id, :created_at, :updated_at
json.url item_url(item, format: :json)
