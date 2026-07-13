require "rails_helper"

RSpec.describe "Api::V1::Accounts", type: :request do
  describe "POST /api/v1/accounts" do
    it "creates an account with valid params" do
      post api_v1_accounts_path, params: { account: { name: "a", direction: "credit", balance: 0 } }
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["account"]).to be_present
      expect(json["account"]["direction"]).to eq("credit")
    end

    it "returns unprocessable for invalid params" do
      post api_v1_accounts_path, params: { account: { name: nil, direction: "invalid", balance: -1 } }
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["errors"]).to be_present
    end
  end
end
