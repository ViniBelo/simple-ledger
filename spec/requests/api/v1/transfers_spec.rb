require "rails_helper"

RSpec.describe "Api::V1::Transfers", type: :request do
  describe "POST /api/v1/transfers/credit" do
    it "creates a credit transfer and returns created" do
      post credit_transfer_api_v1_transfers_path, params: { transfer: { amount: 1 } }
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["transfer"]).to be_present
      expect(json["transfer"]["direction"]).to eq("credit")
    end

    it "returns unprocessable for invalid transfer" do
      post credit_transfer_api_v1_transfers_path, params: { transfer: { amount: 0 } }
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["errors"]).to be_present
    end
  end

  describe "POST /api/v1/transfers/debit" do
    it "creates a debit transfer and returns created" do
      post debit_transfer_api_v1_transfers_path, params: { transfer: { amount: 1 } }
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["transfer"]).to be_present
      expect(json["transfer"]["direction"]).to eq("debit")
    end

    it "returns unprocessable for invalid transfer" do
      post debit_transfer_api_v1_transfers_path, params: { transfer: { amount: 0 } }
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["errors"]).to be_present
    end
  end
end
