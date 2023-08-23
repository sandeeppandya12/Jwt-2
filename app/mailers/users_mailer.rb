class UsersMailer < ApplicationMailer

  default from: 'sandeep@gmail.com'

  def welcome_email
    @user = params[:user]
    #@url  = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def forgot
    @user = params[:user]
    @url  = 'http://localhost:3000/password/forgot'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
  
end

	# def send_forgot_password
	# 	@user= params[:user]
	# 	@url = 'http:/localhost:3000/change_password'
 	# mail(to: @user.email, subject: "link for forget password ")

	# end
