class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
    @user = Current.user
  end


  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id
    @books = Book.all
    @user = Current.user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to @book
    else
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
