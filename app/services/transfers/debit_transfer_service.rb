module Transfers
  class DebitTransferService
    def initialize(amount)
      @amount = amount
    end

    def call
      transfer = Transfer.new(direction: "debit", amount: @amount)

      unless transfer.save
        return { success: false, errors: transfer.errors }
      end

      { success: true, transfer: }
    end
  end
end
