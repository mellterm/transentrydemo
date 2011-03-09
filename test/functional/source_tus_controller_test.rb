require 'test_helper'

class SourceTusControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => SourceTu.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    SourceTu.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    SourceTu.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to source_tu_url(assigns(:source_tu))
  end

  def test_edit
    get :edit, :id => SourceTu.first
    assert_template 'edit'
  end

  def test_update_invalid
    SourceTu.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SourceTu.first
    assert_template 'edit'
  end

  def test_update_valid
    SourceTu.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SourceTu.first
    assert_redirected_to source_tu_url(assigns(:source_tu))
  end

  def test_destroy
    source_tu = SourceTu.first
    delete :destroy, :id => source_tu
    assert_redirected_to source_tus_url
    assert !SourceTu.exists?(source_tu.id)
  end
end
