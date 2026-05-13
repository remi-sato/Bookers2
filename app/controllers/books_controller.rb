class BooksController < ApplicationController

  def index
    @user=User.find(current_user.id)
    @book=Book.new
    @books=Book.all
  end

  def show
    @user=current_user
    @new_book=Book.new
    @book=Book.find(params[:id])
  end 

  def create
    @book=Book.new(book_params)
    @book.user=current_user

    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book)
    else
      render:index,status: :unprocessable_entity
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
     render :show,status: :unprocessable_entity
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
    
end
