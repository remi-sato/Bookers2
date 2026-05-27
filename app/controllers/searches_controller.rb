class SearchesController < ApplicationController
 before_action :require_login

 def search
  @range = params[:range]
  @word = params[:word]

  if @range == "User"
   @users = User.looks(params[:search],params[:word])
  else
   @books = Book.looks(params[:search],params[:word])
  end
 end
end
