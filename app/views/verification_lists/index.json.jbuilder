json.array!(@verification_lists) do |verification_list|
  json.extract! verification_list, :id, :name
  json.url verification_list_url(verification_list, format: :json)
end
