require 'test_helper'

class JigsControllerTest < ActionController::TestCase
  setup do
    @jig = jigs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jigs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jig" do
    assert_difference('Jig.count') do
      post :create, jig: { cleaning_charge: @jig.cleaning_charge, name: @jig.name, repair_charge: @jig.repair_charge }
    end

    assert_redirected_to jig_path(assigns(:jig))
  end

  test "should show jig" do
    get :show, id: @jig
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jig
    assert_response :success
  end

  test "should update jig" do
    patch :update, id: @jig, jig: { cleaning_charge: @jig.cleaning_charge, name: @jig.name, repair_charge: @jig.repair_charge }
    assert_redirected_to jig_path(assigns(:jig))
  end

  test "should destroy jig" do
    assert_difference('Jig.count', -1) do
      delete :destroy, id: @jig
    end

    assert_redirected_to jigs_path
  end
end
