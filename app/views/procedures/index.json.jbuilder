json.array!(@procedures) do |procedure|
  json.extract! procedure, :id, :state, :start_date, :end_date, :user_id, :project_id
  json.url procedure_url(procedure, format: :json)
end
