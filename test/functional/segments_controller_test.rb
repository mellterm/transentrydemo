require 'test_helper'

class SegmentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Segment.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Segment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Segment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to segment_url(assigns(:segment))
  end

  def test_edit
    get :edit, :id => Segment.first
    assert_template 'edit'
  end

  def test_update_invalid
    Segment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Segment.first
    assert_template 'edit'
  end

  def test_update_valid
    Segment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Segment.first
    assert_redirected_to segment_url(assigns(:segment))
  end

  def test_destroy
    segment = Segment.first
    delete :destroy, :id => segment
    assert_redirected_to segments_url
    assert !Segment.exists?(segment.id)
  end
end
