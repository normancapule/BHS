class RegistrationsController < Devise::RegistrationsController
  def new
    @new_user = User.new
    @new_account = @new_user.build_account
    @errors = false
  end

  def create
    user = params[:user]
    account = user[:account]
    user.delete :account
    @new_user = User.new user
    @new_account = @new_user.build_account account
    if @new_user.valid? and @new_account.valid?
      @new_user.save
      redirect_to root_url
    else
      @errors = true
      @new_account.valid?
      clean_up_passwords(@new_user)
      render "registrations/new"
    end
  end

  def update

  end
end
