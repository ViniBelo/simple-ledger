module Api
  module V1
    class Account
      include Mongoid::Document
      include Mongoid::Timestamps
      include Api::V1::Directions

      field :name, type: String

      field :direction, type: String
      field :balance, type: BSON::Decimal128
      validates :name, presence: true
      validates :direction, inclusion: { in: VALUES }, presence: true
      validates :balance, numericality: { greater_than_or_equal_to: 0 }
    end
  end
end
