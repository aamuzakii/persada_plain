require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Additional info", with: @order.additional_info
    fill_in "Delivery cost", with: @order.delivery_cost
    fill_in "Delivery date", with: @order.delivery_date
    fill_in "Delivery note", with: @order.delivery_note
    fill_in "Order note", with: @order.order_note
    fill_in "Order number", with: @order.order_number
    fill_in "Subtotal", with: @order.subtotal
    fill_in "Total", with: @order.total
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Additional info", with: @order.additional_info
    fill_in "Delivery cost", with: @order.delivery_cost
    fill_in "Delivery date", with: @order.delivery_date
    fill_in "Delivery note", with: @order.delivery_note
    fill_in "Order note", with: @order.order_note
    fill_in "Order number", with: @order.order_number
    fill_in "Subtotal", with: @order.subtotal
    fill_in "Total", with: @order.total
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end
end
