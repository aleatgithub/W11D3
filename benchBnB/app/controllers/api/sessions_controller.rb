class Api::SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      login!(@user)
      render show
    else
      # render json: @user.errors.full_messages, status: 422
      render json: "errors from sign in", status: 422
    end
  end

  def destroy
    if current_user
      logout!
      render json: {}
    else
      render json: "errors from sign out"
    end
  end

end
