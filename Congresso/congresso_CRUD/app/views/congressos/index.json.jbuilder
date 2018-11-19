json.array!(@congressos) do |congresso|
  json.extract! congresso, :id, :nome, :local, :dataRealizacao, :editora, :tema
  json.url congresso_url(congresso, format: :json)
end
