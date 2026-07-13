require "rails_helper"

RSpec.describe Api::V1::Accounts::CreateAccountService, type: :service do
  describe "#call" do
    it "creates an account with valid params" do
      service = described_class.new("name", "credit", 0)
      result = service.call
      expect(result[:success]).to be_truthy
      expect(result[:account]).to be_present
      expect(result[:account].direction).to eq("credit")
    end

    it "returns errors for invalid params" do
      service = described_class.new("name", "invalid", -1)
      result = service.call
      expect(result[:success]).to be_falsey
      expect(result[:errors]).to be_present
    end
  end
end
