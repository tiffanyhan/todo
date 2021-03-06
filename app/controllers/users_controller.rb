class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update]
  before_action :authorized_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You're getting baguettes!!!"
      redirect_to root_path
    else
      flash.now[:error] = 'NO BAGUETTES FOR YOU'
      render :new
    end
  end

  def show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "nice try you got it"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def authorized_user
    if params[:id].to_i != current_user.id
      flash[:error] = "You're not allowed to do that!"
      redirect_to root_path
    end
  end
end
