json.array!(@verified_lists) do |verified_list|
  json.extract! verified_list, :id, :verification_list_id, :employee_id, :date_of_verification
  json.url verified_list_url(verified_list, format: :json)
end
