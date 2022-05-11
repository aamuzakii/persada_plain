require "test_helper"

class ProductsOrderedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @products_ordered = products_ordereds(:one)
  end

  test "should get index" do
    get products_ordereds_url
    assert_response :success
  end

  test "should get new" do
    get new_products_ordered_url
    assert_response :success
  end

  test "should create products_ordered" do
    assert_difference("ProductsOrdered.count") do
      post products_ordereds_url, params: { products_ordered: { qty_ordered: @products_ordered.qty_ordered } }
    end

    assert_redirected_to products_ordered_url(ProductsOrdered.last)
  end

  test "should show products_ordered" do
    get products_ordered_url(@products_ordered)
    assert_response :success
  end

  test "should get edit" do
    get edit_products_ordered_url(@products_ordered)
    assert_response :success
  end

  test "should update products_ordered" do
    patch products_ordered_url(@products_ordered), params: { products_ordered: { qty_ordered: @products_ordered.qty_ordered } }
    assert_redirected_to products_ordered_url(@products_ordered)
  end

  test "should destroy products_ordered" do
    assert_difference("ProductsOrdered.count", -1) do
      delete products_ordered_url(@products_ordered)
    end

    assert_redirected_to products_ordereds_url
  end
end
