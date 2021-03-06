class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_profile , only: [:show, :edit, :update, :destroy]
  before_action :current_user_scope
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @request = RideRequest.where(:user_id => current_user.id)
    @events = EventList.where(:user_id => current_user.id)
    @confirm = RideRequest.where(:event_list_id => @events)
    if @profile1 = Profile.where(:user_id => current_user.id).first 
    else
      if Profile.exists?(user_id: @profile.id)
      else
        redirect_to new_profile_path
      end
    end
  end

  # GET /profiles/new
  def new
      @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    if Profile.exists?(user_id: current_user.id)
    else
      redirect_to new_profile_path
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:user_id, :first_name, :last_name, :age, :street_address, :city, :state, :zip, :acct_type, :phone_number, :smoker)
    end
  
    def current_user_scope
      current_user
    end
end
