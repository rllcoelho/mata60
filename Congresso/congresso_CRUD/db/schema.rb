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

  create_table "artigos", primary_key: "numero", force: :cascade do |t|
    t.string  "titulo",                  limit: 45, null: false
    t.integer "sessao_timestamp",        limit: 4,  null: false
    t.integer "sessao_congresso_codigo", limit: 4,  null: false
  end

  add_index "artigos", ["numero"], name: "numero_UNIQUE", unique: true, using: :btree
  add_index "artigos", ["sessao_timestamp", "sessao_congresso_codigo"], name: "fk_artigo_sessao1_idx", using: :btree

  create_table "autores", id: false, force: :cascade do |t|
    t.integer "participante_cpf", limit: 4, null: false
    t.integer "congresso_codigo", limit: 4, null: false
    t.integer "artigo_numero",    limit: 4, null: false
  end

  add_index "autores", ["artigo_numero"], name: "fk_autor_artigo1_idx", using: :btree
  add_index "autores", ["congresso_codigo"], name: "fk_autor_congresso1_idx", using: :btree

  create_table "congressos", primary_key: "codigo", force: :cascade do |t|
    t.string "nome",           limit: 45,  null: false
    t.string "local",          limit: 100, null: false
    t.date   "dataRealizacao",             null: false
    t.string "editora",        limit: 45,  null: false
    t.string "tema",           limit: 45,  null: false
  end

  add_index "congressos", ["codigo"], name: "codigo_UNIQUE", unique: true, using: :btree

  create_table "convidados", id: false, force: :cascade do |t|
    t.integer "congresso_codigo", limit: 4, null: false
    t.integer "participante_id",  limit: 4, null: false
  end

  add_index "convidados", ["participante_id"], name: "fk_convidados_participante1_idx", using: :btree

  create_table "corpoAvaliadores", primary_key: "congresso_codigo", force: :cascade do |t|
  end

  create_table "gruposTrabalho", primary_key: "codigo", force: :cascade do |t|
    t.string "assunto", limit: 45, null: false
  end

  add_index "gruposTrabalho", ["codigo"], name: "codigo_UNIQUE", unique: true, using: :btree

  create_table "gruposTrabalho_congressos", id: false, force: :cascade do |t|
    t.integer "grupoTrabalho_codigo", limit: 4, null: false
    t.integer "congresso_codigo",     limit: 4, null: false
  end

  add_index "gruposTrabalho_congressos", ["congresso_codigo"], name: "fk_grupoTrabalho_congresso_congresso1_idx", using: :btree

  create_table "julgamentos", primary_key: "artigo_numero", force: :cascade do |t|
    t.string "aceito", limit: 45
  end

  create_table "membroCorpoDeAvaliadoresCongresso", id: false, force: :cascade do |t|
    t.integer "participante_cpf",                  limit: 4, null: false
    t.integer "corpoAvaliadores_congresso_codigo", limit: 4, null: false
  end

  add_index "membroCorpoDeAvaliadoresCongresso", ["corpoAvaliadores_congresso_codigo"], name: "fk_membroCorpoDeAvaliadoresCongresso_corpoAvaliadores1_idx", using: :btree
  add_index "membroCorpoDeAvaliadoresCongresso", ["participante_cpf"], name: "fk_corpoDeAvaliadores_avaliador_participante1_idx", using: :btree

  create_table "membrosComiteOrganizador", id: false, force: :cascade do |t|
    t.integer "congresso_codigo", limit: 4, null: false
    t.integer "participante_cpf", limit: 4, null: false
  end

  add_index "membrosComiteOrganizador", ["congresso_codigo"], name: "fk_integraComiteOrganizador_congresso1_idx", using: :btree
  add_index "membrosComiteOrganizador", ["participante_cpf"], name: "fk_integraComiteOrganizador_participante1_idx", using: :btree

  create_table "membrosComitePrograma", id: false, force: :cascade do |t|
    t.integer "congresso_codigo1", limit: 4, null: false
    t.integer "participante_cpf",  limit: 4, null: false
  end

  add_index "membrosComitePrograma", ["congresso_codigo1"], name: "fk_comitePrograma_congresso1_idx", using: :btree
  add_index "membrosComitePrograma", ["participante_cpf"], name: "fk_comitePrograma_participante1_idx", using: :btree

  create_table "membrosGrupoTrabalho", id: false, force: :cascade do |t|
    t.integer "grupoTrabalho_codigo", limit: 4, null: false
    t.integer "participante_cpf",     limit: 4, null: false
  end

  add_index "membrosGrupoTrabalho", ["grupoTrabalho_codigo"], name: "fk_grupoTrabalho_membro_grupoTrabalho1_idx", using: :btree
  add_index "membrosGrupoTrabalho", ["participante_cpf"], name: "fk_grupoTrabalho_membro_participante1_idx", using: :btree

  create_table "opinioes", id: false, force: :cascade do |t|
    t.integer "artigo_numero",                     limit: 4,   null: false
    t.string  "resumoOpniao",                      limit: 275
    t.integer "corpoAvaliadores_congresso_codigo", limit: 4,   null: false
  end

  add_index "opinioes", ["artigo_numero"], name: "fk_opiniao_artigo1_idx", using: :btree
  add_index "opinioes", ["corpoAvaliadores_congresso_codigo"], name: "fk_opiniao_corpoAvaliadores1_idx", using: :btree

  create_table "participantes", force: :cascade do |t|
    t.integer "cpf",        limit: 4,   null: false
    t.string  "cep",        limit: 45,  null: false
    t.integer "numero_fax", limit: 4,   null: false
    t.string  "nome",       limit: 45,  null: false
    t.string  "sobrenome",  limit: 100, null: false
  end

  add_index "participantes", ["cpf"], name: "idparticipante_UNIQUE", unique: true, using: :btree
  add_index "participantes", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "sessoes", id: false, force: :cascade do |t|
    t.integer "timestamp",        limit: 4,  null: false
    t.integer "congresso_codigo", limit: 4,  null: false
    t.string  "horario",          limit: 45
    t.integer "moderador_cpf",    limit: 4,  null: false
  end

  add_index "sessoes", ["congresso_codigo"], name: "fk_sessao_congresso1_idx", using: :btree
  add_index "sessoes", ["moderador_cpf"], name: "fk_sessao_participante1_idx", using: :btree

  create_table "telefones", primary_key: "participante_id", force: :cascade do |t|
    t.integer "numero", limit: 4, null: false
  end

  add_foreign_key "artigos", "sessoes", column: "sessao_congresso_codigo", primary_key: "congresso_codigo", name: "fk_artigo_sessao1"
  add_foreign_key "artigos", "sessoes", column: "sessao_timestamp", primary_key: "timestamp", name: "fk_artigo_sessao1"
  add_foreign_key "autores", "artigos", column: "artigo_numero", primary_key: "numero", name: "fk_autor_artigo1"
  add_foreign_key "autores", "congressos", column: "congresso_codigo", primary_key: "codigo", name: "fk_autor_congresso1"
  add_foreign_key "autores", "participantes", column: "participante_cpf", primary_key: "cpf", name: "fk_autor_participante1"
  add_foreign_key "convidados", "congressos", column: "congresso_codigo", primary_key: "codigo", name: "fk_convidados_congresso1"
  add_foreign_key "convidados", "participantes", primary_key: "cpf", name: "fk_convidados_participante1"
  add_foreign_key "corpoAvaliadores", "congressos", column: "congresso_codigo", primary_key: "codigo", name: "fk_corpoAvaliadores_congresso1"
  add_foreign_key "gruposTrabalho_congressos", "congressos", column: "congresso_codigo", primary_key: "codigo", name: "fk_grupoTrabalho_congresso_congresso1"
  add_foreign_key "gruposTrabalho_congressos", "gruposTrabalho", column: "grupoTrabalho_codigo", primary_key: "codigo", name: "fk_grupoTrabalho_congresso_grupoTrabalho1"
  add_foreign_key "julgamentos", "artigos", column: "artigo_numero", primary_key: "numero", name: "fk_julgamento_artigo1"
  add_foreign_key "membroCorpoDeAvaliadoresCongresso", "corpoAvaliadores", column: "corpoAvaliadores_congresso_codigo", primary_key: "congresso_codigo", name: "fk_membroCorpoDeAvaliadoresCongresso_corpoAvaliadores1"
  add_foreign_key "membroCorpoDeAvaliadoresCongresso", "participantes", column: "participante_cpf", primary_key: "cpf", name: "fk_corpoDeAvaliadores_avaliador_participante1"
  add_foreign_key "membrosComiteOrganizador", "congressos", column: "congresso_codigo", primary_key: "codigo", name: "fk_integraComiteOrganizador_congresso1"
  add_foreign_key "membrosComiteOrganizador", "participantes", column: "participante_cpf", primary_key: "cpf", name: "fk_integraComiteOrganizador_participante1"
  add_foreign_key "membrosComitePrograma", "congressos", column: "congresso_codigo1", primary_key: "codigo", name: "fk_comitePrograma_congresso1"
  add_foreign_key "membrosComitePrograma", "participantes", column: "participante_cpf", primary_key: "cpf", name: "fk_comitePrograma_participante1"
  add_foreign_key "membrosGrupoTrabalho", "gruposTrabalho", column: "grupoTrabalho_codigo", primary_key: "codigo", name: "fk_grupoTrabalho_membro_grupoTrabalho1"
  add_foreign_key "membrosGrupoTrabalho", "participantes", column: "participante_cpf", primary_key: "cpf", name: "fk_grupoTrabalho_membro_participante1"
  add_foreign_key "opinioes", "artigos", column: "artigo_numero", primary_key: "numero", name: "fk_opiniao_artigo1"
  add_foreign_key "opinioes", "corpoAvaliadores", column: "corpoAvaliadores_congresso_codigo", primary_key: "congresso_codigo", name: "fk_opiniao_corpoAvaliadores1"
  add_foreign_key "sessoes", "congressos", column: "congresso_codigo", primary_key: "codigo", name: "fk_sessao_congresso1"
  add_foreign_key "sessoes", "participantes", column: "moderador_cpf", primary_key: "cpf", name: "fk_sessao_participante1"
  add_foreign_key "telefones", "participantes", primary_key: "cpf", name: "fk_telefone_participante1"
end
