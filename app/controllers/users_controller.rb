class UsersController < ApplicationController
  # skip_before_action :authenticate_user, only: [:create]
  # before_action :set_user, only: [:show, :update, :destroy]

  # def index
  #   @users = User.all
  #   render json: @user
  # end

  # def show
  #   render json: @user
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     render json: @user
  #   else
  #     render json: { error: "User can not be created" }, status: 400 
  #   end
  # end

  # def update
  #   if @user
  #     @user.update(user_params)
  #     render json: { message: "user updated" }, status: 200
  #   else
  #     render json: { error: "user can not be updated" }, status: 400
  #   end
  # end

  # def destroy
  #   if @user
  #     @user.destroy
  #     render json: { message: "user got deleted" }, status: 200
  #   else
  #     render json: { error: "User can not be deleted" }, status: 400
  #   end
  # end

  # private
  # def set_user
  #   @user = User.find(params[:id])
  # end
  # def user_params
  #   params.require(:user).permit(:user_name, :email, :password)
  # end


  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_user_name])
    # rescue ActiveRecord::RecordNotFound
    #   render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :avatar, :name, :user_name, :email, :password, :password_confirmation
    )
  end

end
