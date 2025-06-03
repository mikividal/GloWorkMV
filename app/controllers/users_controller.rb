class UsersController < ApplicationController
  def create
    generated_password = Devise.friendly_token.first(12)
    @user = User.new(user_params.merge(password: generated_password))

    if @user.save
      respond_to do |format|
        format.js   # renders create.js.erb
        format.html { redirect_to teams_path, notice: "User created." }
      end
    else
      respond_to do |format|
        format.js   # render error handling JS
        format.html { render :new }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :job_position, :location, :password, :team)
  end
end
