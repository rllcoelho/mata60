json.array!(@filmes) do |filme|
  json.extract! filme, :id, :titulo, :duracaoLocacao
  json.url filme_url(filme, format: :json)
end
