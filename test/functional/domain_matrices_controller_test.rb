require 'test_helper'

class DomainMatricesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => DomainMatrix.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    DomainMatrix.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    DomainMatrix.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to domain_matrix_url(assigns(:domain_matrix))
  end

  def test_edit
    get :edit, :id => DomainMatrix.first
    assert_template 'edit'
  end

  def test_update_invalid
    DomainMatrix.any_instance.stubs(:valid?).returns(false)
    put :update, :id => DomainMatrix.first
    assert_template 'edit'
  end

  def test_update_valid
    DomainMatrix.any_instance.stubs(:valid?).returns(true)
    put :update, :id => DomainMatrix.first
    assert_redirected_to domain_matrix_url(assigns(:domain_matrix))
  end

  def test_destroy
    domain_matrix = DomainMatrix.first
    delete :destroy, :id => domain_matrix
    assert_redirected_to domain_matrices_url
    assert !DomainMatrix.exists?(domain_matrix.id)
  end
end
