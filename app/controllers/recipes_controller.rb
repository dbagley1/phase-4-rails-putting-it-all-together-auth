class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]
  # before_action :set_user, only: [:index, :create]
  
  # GET /recipes
  def index
    user = User.find_by(id: session[:user_id])
    if user
      recipes = Recipe.all
      render json: recipes
    else
      render json: { errors: ["You must be logged in."] }, status: 401
    end
  end

  # GET /recipes/1
  def show
    render json: @recipe
  end

  # POST /recipes
  def create
    user = User.find_by(id: session[:user_id])
    if user
      @recipe = user.recipes.create(recipe_params)

      if @recipe.save
        render json: @recipe, status: :created, location: @recipe
      else
        render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
      end

    else
      render json: { errors: ["You must be logged in."] }, status: :unauthorized
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def set_user
      @user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.permit(:recipe, :title, :instructions, :minutes_to_complete)
    end
end
