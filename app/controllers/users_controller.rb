class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def index
    @users = User.all
  end
  
  def new
  end

  def show
    @user = User.find(params[:id])
  end
  
end
