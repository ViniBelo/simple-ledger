require "rails_helper"

RSpec.describe Api::V1::Account, type: :model do
  describe "validations" do
    it "is valid with a direction and non-negative balance" do
      account = described_class.new(name: "acct", direction: "credit", balance: 0)
      expect(account).to be_valid
    end

    it "is invalid with unknown direction" do
      account = described_class.new(name: "acct", direction: "invalid", balance: 0)
      expect(account).not_to be_valid
      expect(account.errors[:direction]).to be_present
    end

    it "is invalid with negative balance" do
      account = described_class.new(name: "acct", direction: "debit", balance: -1)
      expect(account).not_to be_valid
      expect(account.errors[:balance]).to be_present
    end
  end
end
