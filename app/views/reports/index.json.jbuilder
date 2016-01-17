json.array!(@reports) do |report|
  json.extract! report, :id, :title, :antecedent, :description, :conclusion, :recommendation, :Procedure_id
  json.url report_url(report, format: :json)
end
