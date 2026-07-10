require "test_helper"

class Transfers::DebitTransferServiceTest < ActiveSupport::TestCase
  test "creates a debit transfer" do
    fake_transfer_class = Class.new do
      attr_reader :direction, :amount

      def initialize(direction:, amount:)
        @direction = direction
        @amount = amount
      end

      def save
        true
      end

      def errors
        {}
      end
    end

    with_constant_replaced(Object, :Transfer, fake_transfer_class) do
      result = Transfers::DebitTransferService.new(50.5).call

      assert result[:success]
      assert_instance_of fake_transfer_class, result[:transfer]
      assert_equal "debit", result[:transfer].direction
      assert_equal 50.5, result[:transfer].amount.to_f
    end
  end

  test "returns validation errors for invalid amount" do
    fake_transfer_class = Class.new do
      attr_reader :errors

      def initialize(direction:, amount:)
        @direction = direction
        @amount = amount
        @errors = { amount: [ "must be greater than 0" ] }
      end

      def save
        false
      end
    end

    with_constant_replaced(Object, :Transfer, fake_transfer_class) do
      result = Transfers::DebitTransferService.new(0).call

      assert_not result[:success]
      assert result[:errors].present?
      assert_includes result[:errors][:amount], "must be greater than 0"
    end
  end
end
