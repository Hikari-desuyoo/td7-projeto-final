module Api
  module V1
    class HirersController < Api::V1::ApiController
      def generate_token
        hirer = Hirer.user_by_credentials params[:credentials]

        if hirer.nil?
          render status: :not_found, json: {}
          return
        end

        render status: :ok, json: {
          jwt: hirer.user_jwt
        }
      end
    end
  end
end
