require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe ProjectApplicationMailerWorker, type: :worker do
  
    it "should respond to #perform" do
        expect(ProjectApplicationMailerWorker.new).to respond_to(:perform)
    end
    describe 'ProjectApplicationMailerWorker' do
        before do
            Sidekiq::Extensions.enable_delay!
            Sidekiq::Worker.clear_all
        end

        it 'should enqueue a Email job' do
            project_application = create(
                :project_application
            )

            h = JSON.generate({ project_application_id: project_application.id})

            assert_equal 0, Sidekiq::Queues["default"].size
            ProjectApplicationMailerWorker.perform_async(h, 1)
            assert_equal 1, Sidekiq::Queues["default"].size
            Sidekiq::Worker.drain_all
            assert_equal 0, Sidekiq::Queues["default"].size
        end
    end
end
