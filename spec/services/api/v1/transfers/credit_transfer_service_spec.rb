require "rails_helper"

RSpec.describe Api::V1::Transfers::CreditTransferService, type: :service do
  describe "#call" do
    it "creates a credit transfer and returns success" do
      service = described_class.new(1)
      result = service.call
      expect(result[:success]).to be_truthy
      expect(result[:transfer]).to be_present
      expect(result[:transfer].direction).to eq("credit")
    end

    it "returns errors for invalid transfer" do
      service = described_class.new(0)
      result = service.call
      expect(result[:success]).to be_falsey
      expect(result[:errors]).to be_present
    end
  end
end
