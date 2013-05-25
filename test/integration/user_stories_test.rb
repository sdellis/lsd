require 'test_helper'


class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products 

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    acme_drum = products(:acme)
  
    get "/"
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', product_id: acme_drum.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal acme_drum, cart.line_items[0].product_id

    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
        order: {  name: "Dave Thomas",
                  address: "123 The Street",
                  email: "dave@example.com",
                  contact_me: 1
                }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas",     order.name
    assert_equal "123 The Street",  order.address
    assert_equal "dave@example.com",order.email
    assert_equal 1,                 order.contact_me

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal acme_drum, line_item.product_id

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to 
    assert_equal 'Shaun Ellis <shaun@soupconsalon.com>', mail[:from].value
    assert_equal "Lambertville Suitcase Drum Order Confirmation", mail.subject
  end
end
