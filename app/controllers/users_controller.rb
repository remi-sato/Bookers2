class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
    redirect_to new_session_path, notice:"Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
  end

  def show
    @user=User.find(params[:id])
  end
  
  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

end

private

def user_params
  params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :image, :introduction)
end

end
