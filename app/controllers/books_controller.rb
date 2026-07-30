class BooksController < ApplicationController
  before_action :require_authentication

  def index
    @book = Book.new
    @books = Book.all
    @user = Current.user
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != Current.user
      redirect_to books_path
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user = Current.user
    @book.user_id = Current.user.id
    @books = Book.all
    @user = Current.user
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = Current.user 
      render :index, status: :unprocessable_entity
      render :"users/show", status: :unprocessable_entity
    end
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
