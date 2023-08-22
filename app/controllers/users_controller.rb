# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authentication

  def index
    @users = User.all.where("email LIKE ?", "%" + params[:email] + "%").page(params[:page]).per(params[:per_page])
    render json: UserSerializer.new(@users).serializable_hash, status: :ok
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash, status: :ok
    else
      render json: { errors: @user.errors.full_messages }
    end
  end

  def destroy
    # byebug
    if @user.destroy
      render json: { message: 'user deleted succesfully' }
    else
      render json: { errors: @user.errors.full_messages }
    end
  end

  def change_password
    @user = User.find_by(email: params[:email])
    return unless @user.present?

    if @user.password == params[:current_password]
      if params[:user][:new_password] == params[:user][:confirm_password]
        @user.update(password: params[:user][:new_password], confirm_password: params[:user][:confirm_password])
        JWT.encode({ user_id: @user_id }, SECRET, 'HS256')
        # render json: { message: "Password updation successfully" ,user: @user, token: new_token}  , status: :ok
        render json: UserSerializer.new(@user).serializable_hash, status: :ok
      else
        render json: { message: 'Password updation failed' }, status: 401
      end
    else
      render json: { message: 'Password incorrect' }, status: 400
    end
  end

  def forgot_password
    @user = User.find_by(email: params[:email])
    return unless @user.present?

    if params[:user][:new_password] == params[:user][:confirm_password]
      @user.update(password: params[:user][:new_password], confirm_password: params[:user][:confirm_password])
      new_token = JWT.encode({ user_id: @user_id }, SECRET, 'HS256')
      render json: { message: 'Password updation successfully', user: @user, token: new_token }, status: :ok
    else
      render json: { message: 'Password updation failed' }, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:new_password, :confirm_password, :avatar)
  end
end
