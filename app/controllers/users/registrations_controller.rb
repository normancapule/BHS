class Users::RegistrationsController < Devise::RegistrationsController
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
      render "users/registrations/new"
    end
  end

  def update
    user = params[:user]
    account = user[:account]
    @user = User.find_by_username user[:username]
    @account = @user.account
    user.delete :account
    if @user.update_with_password(user) and @account.update_attributes(account)
      redirect_to root_url
    else
      @errors = true
      clean_up_passwords(@new_user)
      render "users/registrations/edit"
    end
  end
end
