json.array!(@participantes) do |participante|
  json.extract! participante, :id, :cpf, :cep, :numero_fax, :nome, :sobrenome
  json.url participante_url(participante, format: :json)
end
