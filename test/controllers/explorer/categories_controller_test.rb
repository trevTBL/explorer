require 'test_helper'

module Explorer
  class CategoriesControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should get edit" do
      get :edit
      assert_response :success
    end

    test "should get show" do
      get :show
      assert_response :success
    end

  end
end
