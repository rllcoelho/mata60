# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "atores", primary_key: "identificador", force: :cascade do |t|
    t.string "nomeReal",       limit: 45, null: false
    t.string "dataNascimento", limit: 45
  end

  add_index "atores", ["identificador"], name: "identificador_UNIQUE", unique: true, using: :btree

  create_table "categorias", primary_key: "identificador", force: :cascade do |t|
    t.string "nome", limit: 45, null: false
  end

  add_index "categorias", ["identificador"], name: "identificador_UNIQUE", unique: true, using: :btree
  add_index "categorias", ["nome"], name: "nome_UNIQUE", unique: true, using: :btree

  create_table "clientes", primary_key: "numAssociado", force: :cascade do |t|
    t.string  "nome",      limit: 45, null: false
    t.string  "sobrenome", limit: 45, null: false
    t.integer "CEP",       limit: 4,  null: false
  end

  add_index "clientes", ["numAssociado"], name: "numAssociado_UNIQUE", unique: true, using: :btree

  create_table "emprestimos", primary_key: "instanteLocacao", force: :cascade do |t|
    t.integer "cliente_numAssociado", limit: 4, null: false
    t.integer "fita_numero",          limit: 4, null: false
    t.date    "dataAluguel",                    null: false
    t.integer "preco",                limit: 4, null: false
  end

  add_index "emprestimos", ["cliente_numAssociado"], name: "fk_emprestimo_cliente1_idx", using: :btree
  add_index "emprestimos", ["fita_numero"], name: "fk_emprestimo_fita1_idx", using: :btree
  add_index "emprestimos", ["instanteLocacao"], name: "instanteLocacao_UNIQUE", unique: true, using: :btree

  create_table "estrelatos", id: false, force: :cascade do |t|
    t.integer "filme_identificador", limit: 4, null: false
    t.integer "ator_identificador",  limit: 4, null: false
  end

  add_index "estrelatos", ["ator_identificador"], name: "fk_estrelato_ator1_idx", using: :btree

  create_table "filmes", primary_key: "identificador", force: :cascade do |t|
    t.string  "titulo",         limit: 255, null: false
    t.integer "duracaoLocacao", limit: 4,   null: false
  end

  add_index "filmes", ["identificador"], name: "identificador_UNIQUE", unique: true, using: :btree

  create_table "filmes_has_categorias", id: false, force: :cascade do |t|
    t.integer "filme_identificador",     limit: 4, null: false
    t.integer "categoria_identificador", limit: 4, null: false
  end

  add_index "filmes_has_categorias", ["categoria_identificador"], name: "fk_filme_has_categoria_categoria1_idx", using: :btree
  add_index "filmes_has_categorias", ["filme_identificador"], name: "fk_filme_has_categoria_filme1_idx", using: :btree

  create_table "fitas", primary_key: "numero", force: :cascade do |t|
    t.integer "filme_identificador", limit: 4,  null: false
    t.integer "fita_numero",         limit: 4
    t.string  "disponibilidade",     limit: 45
  end

  add_index "fitas", ["filme_identificador"], name: "fk_fita_filme1_idx", using: :btree
  add_index "fitas", ["fita_numero"], name: "fk_fita_fita1_idx", using: :btree
  add_index "fitas", ["numero"], name: "numero_UNIQUE", unique: true, using: :btree

  create_table "telefones", id: false, force: :cascade do |t|
    t.integer "cliente_numAssociado", limit: 4, null: false
    t.integer "numero",               limit: 4, null: false
  end

  add_foreign_key "emprestimos", "clientes", column: "cliente_numAssociado", primary_key: "numAssociado", name: "fk_emprestimo_cliente1"
  add_foreign_key "emprestimos", "fitas", column: "fita_numero", primary_key: "numero", name: "fk_emprestimo_fita1"
  add_foreign_key "estrelatos", "atores", column: "ator_identificador", primary_key: "identificador", name: "fk_estrelato_ator1"
  add_foreign_key "estrelatos", "filmes", column: "filme_identificador", primary_key: "identificador", name: "fk_estrelato_filme1"
  add_foreign_key "filmes_has_categorias", "categorias", column: "categoria_identificador", primary_key: "identificador", name: "fk_filme_has_categoria_categoria1"
  add_foreign_key "filmes_has_categorias", "filmes", column: "filme_identificador", primary_key: "identificador", name: "fk_filme_has_categoria_filme1"
  add_foreign_key "fitas", "filmes", column: "filme_identificador", primary_key: "identificador", name: "fk_fita_filme1"
  add_foreign_key "fitas", "fitas", column: "fita_numero", primary_key: "numero", name: "fk_fita_fita1"
  add_foreign_key "telefones", "clientes", column: "cliente_numAssociado", primary_key: "numAssociado", name: "fk_telefone_cliente"
end
