class Api::V1::AccountsController < ApplicationController
  def create
    response = ::Api::V1::Accounts::CreateAccountService.new(account_params[:name],
                                                             account_params[:direction],
                                                             account_params[:balance]).call

    unless response[:success]
      return render json: { errors: response[:errors] }, status: :unprocessable_entity
    end

    render json: { account: AccountBlueprint.render_as_hash(response[:account]) }, status: :created
  end

  private

  def account_params
    params.require(:account).permit(:name, :direction, :balance)
  end
end
