require 'test_helper'

class CongressosControllerTest < ActionController::TestCase
  setup do
    @congresso = congressos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:congressos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create congresso" do
    assert_difference('Congresso.count') do
      post :create, congresso: { dataRealizacao: @congresso.dataRealizacao, editora: @congresso.editora, local: @congresso.local, nome: @congresso.nome, tema: @congresso.tema }
    end

    assert_redirected_to congresso_path(assigns(:congresso))
  end

  test "should show congresso" do
    get :show, id: @congresso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @congresso
    assert_response :success
  end

  test "should update congresso" do
    patch :update, id: @congresso, congresso: { dataRealizacao: @congresso.dataRealizacao, editora: @congresso.editora, local: @congresso.local, nome: @congresso.nome, tema: @congresso.tema }
    assert_redirected_to congresso_path(assigns(:congresso))
  end

  test "should destroy congresso" do
    assert_difference('Congresso.count', -1) do
      delete :destroy, id: @congresso
    end

    assert_redirected_to congressos_path
  end
end
