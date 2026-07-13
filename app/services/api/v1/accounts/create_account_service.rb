module Api
  module V1
    module Accounts
      class CreateAccountService
        def initialize(name, direction, initial_balance)
          @name = name
          @direction = direction
          @balance = initial_balance
        end

        def call
          account = Api::V1::Account.new(
            name: @name,
            direction: @direction,
            balance: @balance
          )

          unless account.save
            return { success: false, errors: account.errors }
          end

          { success: true, account: }
        end
      end
    end
  end
end
