class SessionsController < ApplicationController
    skip_before_action :login_required, only: %i(new create)
    def new
    end
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user&.authenticate(params[:session][:password])
        log_in(user)
        redirect_to tasks_path, notice: 'Logged in'
      else
        flash.now[:alert] = 'Incorrect email address or password'
        render :new
      end
    end
    def destroy
      session.delete(:user_id)
      flash[:notice] = 'You have been logged out'
      redirect_to new_session_path
    end
  end