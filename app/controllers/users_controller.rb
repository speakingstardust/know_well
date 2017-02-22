class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :destroy, :update]
  before_action :authenticate_admin!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User account successfully created for #{@user.full_name}."
    else
      render :new
    end
  end

  def edit 

  end

  def update 
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      redirect_to users_path, notice: "User account for #{@user.full_name} successfully updated."
    else
      render :edit
    end
  end

  def show 

  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User account for #{@user.full_name} successfully destroyed."
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, role_ids:[])
  end

  def set_user
    @user = User.find(params[:id])
  end

end
