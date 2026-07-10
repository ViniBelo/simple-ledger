require "test_helper"

class Transfers::CreditTransferServiceTest < ActiveSupport::TestCase
  setup do
    Transfer.delete_all
  end

  test "creates a credit transfer" do
    result = Transfers::CreditTransferService.new(50.5).call

    assert result[:success]
    assert_instance_of Transfer, result[:transfer]
    assert_equal "credit", result[:transfer].direction
    assert_equal 50.5, result[:transfer].amount.to_f
  end

  test "returns validation errors for invalid amount" do
    result = Transfers::CreditTransferService.new(0).call

    assert_not result[:success]
    assert result[:errors].present?
    assert_includes result[:errors][:amount], "must be greater than 0"
  end
end
