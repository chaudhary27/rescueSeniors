class ProfilesController < ApplicationController

  before_action :authenticate_user!
  before_action :only_current_user
  # GET to /users/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
    end
  end


  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :age, :height_feet, :height_inches, :phone_number, :contact_email, :health_band)
  end

  def only_current_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless @user == current_user
  end
end
