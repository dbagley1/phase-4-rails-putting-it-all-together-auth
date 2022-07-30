class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    if @user
      render json: @user.slice(:id, :username, :image_url, :bio)
    else
      render json: { error: 'You must be logged in' }, status: 401
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
        if @user.save
        session[:user_id] = @user.id
        render json: @user, status: :created, location: @user
      else
        render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: session[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:user, :username, :password, :password_confirmation, :bio, :image_url)
    end
end
