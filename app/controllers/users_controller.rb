class UsersController < ApplicationController

  # GET /users
  def index
    result = UserService.new.index

    render json: result[:user]
  end

  # GET /users/1
  def show
    result = UserService.new(params).show
    if result.success?
      render json: result[:user]
    else
      render json: result[:errors], status: :unprocessable_entity
    end
  end

  # POST /users
  def create
    result = UserService.new(user_params).create
    if result.success?
      render json: result[:user] , status: :created
    else
      render jeson: result[:errors], status: :unprocessable_entity
    end

  end

  # PATCH/PUT /users/1
  def update
    result = UserService.new(user_update_params).update
    if result.success?
      render json: result[:user]
    else
      render json: result[:errors], status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    result = UserService.new(params).destroy
    if result.success?
      render json: result[:destroy_message]
    else
      render json: result[:errors], status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


  def user_update_params
    params.permit(:id,:fname, :lname, :email, :username, :birthday, :type_id)
  end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:fname, :lname, :email, :username, :birthday, :type_id,:password)
    end
end
