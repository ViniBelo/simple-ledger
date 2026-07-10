class Transfer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :amount, type: BSON::Decimal128
  validates :amount, presence: true, numericality: { greater_than: 0 }

  DIRECTIONS = %w[credit debit].freeze
  field :direction, type: String
  validates :direction, inclusion: { in: DIRECTIONS }, presence: true
end
