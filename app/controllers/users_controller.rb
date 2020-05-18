class UsersController < ApplicationController
  def show
   @user = User.find(params[:id])
   @book = Book.new
   @books = @user.books.all
  end

  def index
  	 @user = current_user
     @book = Book.new
     @users = User.all
  end

  def edit
  	@user = User.find(params[:id])
    if @user == current_user
       render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
    if  @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
  	    redirect_to user_path(@user.id)
    else
        render :edit
    end
  end

  def following
    @user = User.find(params[:id])
    render 'follow_show'
  end

  def followers
    @user = User.find(params[:id])
    render 'follower_show'
  end

  private 
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

