json.array!(@procedure_types) do |procedure_type|
  json.extract! procedure_type, :id, :name
  json.url procedure_type_url(procedure_type, format: :json)
end
