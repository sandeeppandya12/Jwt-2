class PasswordsController < ApplicationController
    def forgot
        @user = User.find_by(email: params[:email])
        if @user.present?
          @user.generate_password_token! #generate pass token
          UsersMailer.with(user: @user).forgot.deliver_now
          @user.update(reset_password_token: @user.reset_password_token)
          render json: {message: "otp sent successfully!"}, status: :ok
        else
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
        end
      end
      def reset
        token = params[:reset_password_token]
        @user = User.find_by(email: params[:email])
        # @user.update(reset_password_token: token)
        return render json: {message:  "reset password token not match "} unless @user.reset_password_token ==  params[:reset_password_token]
        if @user.present? && @user.password_token_valid?
            if  params[:user][:new_password] == params[:user][:confirm_password]
             @user.update(password: params[:user][:new_password],confirm_password: params[:user][:confirm_password])
             return render json: {message:  "passwords changed successfully "}
            else
                render json: {message:  "not matched both passwords"}
            end
        else
            render json: {error:  "Link not valid or expired. Try generating a new link."}, status: 404
        end
      end
end