json.array!(@clientes) do |cliente|
  json.extract! cliente, :id, :nome, :sobrenome, :CEP
  json.url cliente_url(cliente, format: :json)
end
