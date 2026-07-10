module Api
  module V1
    class TransfersController < ApplicationController
      def credit
        response = Transfers::CreditTransferService.new(transfer_params[:amount])
                                                   .call()

        unless response[:success]
          return render json: { errors: response[:errors] }, status: :unprocessable_entity
        end

        render json: { transfer: ::TransferBlueprint.render_as_hash(response[:transfer]) }, status: :created
      end

      private

      def transfer_params
        params.require(:transfer).permit(:amount)
      end
    end
  end
end
