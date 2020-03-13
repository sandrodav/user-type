class UsertypesController< ApplicationController
  before_action :set_usertype, only: [:show, :update, :destroy]


  def index
    @user_types = UserType.all
    render json: @user_types.to_json(only: [:id, :name])
  end


  def show
    render json: @user_type.to_json(only: [:id, :name])
  end


  def create
    @user_type = UserType.create(user_type_params)
    if @user_type.save
      render json: @user_type.to_json(only: [:id, :name]), status: :created
    else
      render json: @user_type.errors, status: :unprocessable_entity
    end
  end


  def update
    if @user_type.update(user_type_params)
      render json: @user_type.to_json(only: [:id, :name])
    else
      render json: @user_type.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @user_type.destroy
  end

  private

  def set_usertype
    @user_type = UserType.find(params[:id])
  end

  def user_type_params
    params.require(:usertype).permit(:name)
  end

end
