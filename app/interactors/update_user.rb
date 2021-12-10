class UpdateUser
  include Interactor

  def call
    @params = context.permitted_params
    @user = context.current_user

    return if @params[:current_password] && @user.update_with_password(@params)

    return if @user.update(@params)

    context.fail!
  end
end
