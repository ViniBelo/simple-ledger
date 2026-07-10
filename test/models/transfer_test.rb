require "test_helper"

class TransferTest < ActiveSupport::TestCase
  setup do
    Transfer.delete_all
  end

  test "is valid with a positive amount and a supported direction" do
    transfer = Transfer.new(amount: 10.25, direction: "credit")

    assert transfer.valid?
  end

  test "is invalid when amount is not positive" do
    transfer = Transfer.new(amount: 0, direction: "credit")

    assert_not transfer.valid?
    assert_includes transfer.errors[:amount], "must be greater than 0"
  end

  test "is invalid when direction is unsupported" do
    transfer = Transfer.new(amount: 10.25, direction: "transfer")

    assert_not transfer.valid?
    assert_includes transfer.errors[:direction], "is not included in the list"
  end
end
