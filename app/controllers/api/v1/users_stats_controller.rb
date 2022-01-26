module Api
  module V1
    class UsersStatsController < Api::V1::ApiController
      def users_stats
        workers_amount = Worker.count
        hirers_amount = Hirer.count

        render status: :ok, json: {
          workers_amount: workers_amount,
          hirers_amount: hirers_amount
        }
      end
    end
  end
end
