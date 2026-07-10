require "test_helper"

class TransferControllerTest < ActionDispatch::IntegrationTest
  setup do
    host! "www.example.com"
  end

  test "credit creates a serialized transfer" do
    post "/api/v1/transfers/credit", params: { transfer: { amount: 50.5 } }

    assert_response :created

    body = JSON.parse(response.body)
    assert_equal "credit", body.dig("transfer", "direction")
    assert_equal "50.5", body.dig("transfer", "amount")
    assert_predicate body.dig("transfer", "id"), :present?
  end

  test "credit returns validation errors for invalid amount" do
    post "/api/v1/transfers/credit", params: { transfer: { amount: 0 } }

    assert_response :unprocessable_entity

    body = JSON.parse(response.body)
    assert_predicate body["errors"], :present?
  end
end
