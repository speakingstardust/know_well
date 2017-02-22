class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :destroy, :update]

  def new

  end

  def create

  end

  def edit 

  end

  def update 

  end

  def show 

  end

  def index
    @users = User.all
  end

  def destroy

  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, roles_attributes: [:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

end
