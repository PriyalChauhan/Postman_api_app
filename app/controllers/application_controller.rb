class ApplicationController < ActionController::API
  # before_action :authenticate_user

  # private
  # def authenticate_user
  #   header = request.headers["Authorization"]
  #   header = header.split(' ').last if header
  #   begin
  #     @decoded = JwtToken.decode(header)
  #     @current_user = User.find(@decoded[:user_id])
  #   rescue ActitiveRecord::RecordNotFound => e
  #     render json: { errors: e.message }, status: :unauthorized
  #   rescue JWT::DecodeError => eager
  #     render json: { errors: e.message }, status: :unauthorized
  #   end
  # end

  before_action :authorize_request

  private
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
