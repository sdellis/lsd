require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Lambertville Suitcase Drum Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["shaun@soupconsalon.com"], mail.from
    assert_match /1 x Acme Herringbone/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Lambertville Suitcase Drum Order Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["shaun@soupconsalon.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Acme Herringbone<\/td>/, mail.body.encoded
  end

end
