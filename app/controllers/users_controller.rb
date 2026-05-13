class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user=User.new
  end
 
  def create
    @user=User.new(user_params)
    if @user.save
    start_new_session_for @user
    redirect_to books_path, notice:"Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
    end  
  end

  
  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])

    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to books_path(@user)
    else
      render :edit,status: :unprocessable_entity
    end
  end

  def index
    @users=User.all
  end

  def show
    @user=User.find(params[:id])
    @books=@user.book_path(user)
  end 

private

def user_params
  params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image, :introduction)
end

end
