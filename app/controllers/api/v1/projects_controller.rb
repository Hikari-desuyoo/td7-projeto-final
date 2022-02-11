module Api
  module V1
    class ProjectsController < Api::V1::ApiController
      before_action :authenticate_user

      def index
        if @hirer.nil?
          render status: :not_found, json: {}
          return
        end

        render status: :ok, json: { projects: @hirer.projects.as_json(only: %i[title]) }
      end
    end
  end
end
