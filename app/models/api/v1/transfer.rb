module Api
  module V1
    class Transfer
      include Mongoid::Document
      include Mongoid::Timestamps
      include Api::V1::Directions

      field :amount, type: BSON::Decimal128
      validates :amount, presence: true, numericality: { greater_than: 0 }

      field :direction, type: String
      validates :direction, inclusion: { in: VALUES }, presence: true
    end
  end
end
