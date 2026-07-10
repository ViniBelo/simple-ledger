require "test_helper"

class TransferControllerTest < ActionDispatch::IntegrationTest
  setup do
    host! "www.example.com"
  end

  test "credit creates a serialized transfer" do
    assert_transfer_created(
      path: "/api/v1/transfers/credit",
      expected_direction: "credit",
      service_constant: :CreditTransferService
    )
  end

  test "debit creates a serialized transfer" do
    assert_transfer_created(
      path: "/api/v1/transfers/debit",
      expected_direction: "debit",
      service_constant: :DebitTransferService
    )
  end

  test "credit returns validation errors for invalid amount" do
    assert_transfer_invalid_amount(
      path: "/api/v1/transfers/credit",
      service_constant: :CreditTransferService
    )
  end

  test "debit returns validation errors for invalid amount" do
    assert_transfer_invalid_amount(
      path: "/api/v1/transfers/debit",
      service_constant: :DebitTransferService
    )
  end

  private

  def assert_transfer_created(path:, expected_direction:, service_constant:)
    transfer = Transfer.new(id: BSON::ObjectId.new, amount: 50.5, direction: expected_direction)

    service_response = { success: true, transfer: transfer }
    fake_service_class = Class.new do
      define_method(:initialize) { |_amount| }
      define_method(:call) { service_response }
    end

    with_constant_replaced(Transfers, service_constant, fake_service_class) do
      post path, params: { transfer: { amount: 50.5 } }
    end

    assert_response :created

    body = JSON.parse(response.body)
    assert_equal expected_direction, body.dig("transfer", "direction")
    assert_equal 50.5, body.dig("transfer", "amount")
    assert_predicate body.dig("transfer", "id"), :present?
  end

  def assert_transfer_invalid_amount(path:, service_constant:)
    service_response = { success: false, errors: { amount: [ "must be greater than 0" ] } }

    fake_service_class = Class.new do
      define_method(:initialize) { |_amount| }
      define_method(:call) { service_response }
    end

    with_constant_replaced(Transfers, service_constant, fake_service_class) do
      post path, params: { transfer: { amount: 0 } }
    end

    assert_response :unprocessable_entity

    body = JSON.parse(response.body)
    assert_predicate body["errors"], :present?
  end
end
