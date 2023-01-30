class User::ProfileController < User::AccountController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    update_method = params.dig(:user, :password).present? ? :update : :update_without_password

    if @user.public_send(update_method, user_params)
      flash.now[:notice] = 'User profile has been updated'

      sign_in @user, bypass: true if params.dig(:user, :password).present?

      render formats: :turbo_stream
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, 
                                 :avatar, :avatar_cache,
                                 :password, :password_confirmation)
  end
end
