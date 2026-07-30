class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_authentication, only: [:edit, :update]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for(@user)
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = Current.user
    @book = Book.new
  end


  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def is_matching_login_user
    unless @user.id == Current.user.id
      redirect_to user_path(Current.user)
    end
  end
  

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image, :introduction)
  end
end
