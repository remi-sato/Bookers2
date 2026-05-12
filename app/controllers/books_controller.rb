class BooksController < ApplicationController

  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
  end

  def create
    @book=Book.new(book_params)
    @book.user=current_user

    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to books_path
    else
      render:index,status: :unprocessable_entity
    end
  end

  private
   def book_params
    params.require(:book).permit(:title, :body)
   end 
    
end
