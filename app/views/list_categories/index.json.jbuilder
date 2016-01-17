json.array!(@list_categories) do |list_category|
  json.extract! list_category, :id, :name
  json.url list_category_url(list_category, format: :json)
end
