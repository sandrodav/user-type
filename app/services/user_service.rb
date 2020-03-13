class UserService
  def initialize(params = nil )
    @params = params
    @errors = []
  end
  def create
    user = User.create(@params)
    return OpenStruct.new(success?: false, user: nil, errors: user.errors) unless user.present?
    OpenStruct.new(success?: true, user: user.as_json(only: [:id, :username,:fname,:lname,:active,:type_id]), errors: user.errors )
  end

  def show
    user = find_user
    if @errors.empty?
      result(user)
    else
      return  OpenStruct.new(success?: false, user: nil , errors: "Coud'not find user")
    end
  end

  def index
    users = User.all
    OpenStruct.new(success?: true, user: users.as_json(only: [:id,:email, :username,:fname,:lname,:active,:type_id]), errors: nil)
  end

  def update
    user = find_user
    return  OpenStruct.new(success?: false, user: nil , errors: user.errors ) unless user.update(@params)
    result(user)
  end

  def destroy
    user = find_user
    if @errors.empty?
      return  OpenStruct.new(success?: false, user: nil , errors: "user.errors" ) unless user.destroy
      OpenStruct.new(success?: true, destroy_message: "User destroyed", errors: user.errors)
    else
      return  OpenStruct.new(success?: false, user: nil , errors: "Coud'not find user")
    end

  end



  private


  def find_user
    User.find(@params[:id])

  rescue => e
    @errors << e
  end

  def result(par)
    OpenStruct.new(success?: true, user: par.as_json(only: [:id,:email ,:username,:fname,:lname,:active,:type_id]), errors: par.errors )

  end

end