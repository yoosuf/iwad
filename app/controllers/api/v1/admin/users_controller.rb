class Api::V1::Admin::UsersController < ApplicationController




  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:prepaid_credit_count)
    end
end
