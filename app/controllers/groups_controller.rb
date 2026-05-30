class GroupsController < ApplicationController

 before_action :require_login
 before_action :set_group, only: [:show, :edit, :update]
 before_action :ensure_correct_user, only: [:edit, :update]

 def new 
  @group = Group.new
 end

 def create
  @group = Group.new(group_params)
  @group.owner_id = current_user.id
  if @group.save
   redirect_to groups_path
  else
   render "new"
  end 
 end

 def index
  @groups = Group.all
  @user = current_user
 end

 def show
  @group = Group.find(params[:id])
  @owner_user = User.find(@group.owner_id)
  @users = @group.users
 end

 def edit
 end

 def update
  if @group.update(group_params)
   redirect_to groups_path
  else
   render "edit"
  end
 end

 private

 def set_group
  @group = Group.find(params[:id])
 end

 def group_params
  params.require(:group).permit(:name, :introduction, :group_image)
 end

 def ensure_correct_user
  Rails.logger.info "DEBUG group=#{@group.inspect}"
  Rails.logger.info "DEBUG user=#{current_user.inspect}"

  return if current_user.nil?

  if @group.owner_id.to_s != current_user.id.to_s
    redirect_to groups_path
  end
end

end
