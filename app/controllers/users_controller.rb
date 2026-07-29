class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      start_new_session_for @user
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
  end
end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @user = Current.user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private
 
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :image, :introduction)
  end
end
