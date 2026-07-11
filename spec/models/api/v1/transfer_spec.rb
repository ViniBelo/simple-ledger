require "rails_helper"

RSpec.describe Api::V1::Transfer, type: :model do
  describe "validations" do
    it "is valid with a positive amount and direction" do
      transfer = described_class.new(direction: "credit", amount: 1)
      expect(transfer).to be_valid
    end

    it "is invalid without amount" do
      transfer = described_class.new(direction: "credit")
      expect(transfer).not_to be_valid
      expect(transfer.errors[:amount]).to be_present
    end

    it "is invalid with non-positive amount" do
      transfer = described_class.new(direction: "debit", amount: 0)
      expect(transfer).not_to be_valid
      expect(transfer.errors[:amount]).to be_present
    end
  end
end
