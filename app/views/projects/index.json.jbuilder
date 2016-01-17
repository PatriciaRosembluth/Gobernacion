json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :address, :canton, :province, :departament, :latitude, :longitude, :aop_type_id, :companty_id
  json.url project_url(project, format: :json)
end
