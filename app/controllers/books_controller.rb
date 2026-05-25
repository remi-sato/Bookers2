class BooksController < ApplicationController
  before_action :require_login
  before_action :correct_book_user, only: [:edit, :update, :destroy]

  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
  end

  def show
    @user=current_user
    @new_book=Book.new
    @book=Book.find(params[:id])
    @book_comment=BookComment.new
  end 

  def create
    @book=Book.new(book_params)
    @book.user=current_user

    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user 
      @books = Book.all  
      render :index,status: :unprocessable_entity
    end
  end  

  def edit  
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to book_path(@book)
    else
     render :edit,status: :unprocessable_entity
    end
  end    


  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end  

  private
   def book_params
    params.require(:book).permit(:title, :body)
   end 

   def correct_book_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
   end
    
end
