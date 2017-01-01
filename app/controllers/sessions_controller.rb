class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |user|
      if request.format.json?
        data = {
          token: user.authentication_token,
          email: user.email,
          user_id: user.id
        }
        render json: data, status: 201 and return
      end
    end
  end
end
