json.array!(@companies) do |company|
  json.extract! company, :id, :name, :principal_activity, :nit, :address, :canton, :province, :departament, :phones, :fax, :mailbox
  json.url company_url(company, format: :json)
end
