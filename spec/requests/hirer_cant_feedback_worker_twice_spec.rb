require 'rails_helper'

describe 'hirer tries to give worker feedback twice' do
    before(:each) do
        @worker = Worker.create!(
            email: 'test2@mail.com',
            password: '123456789',
            name: 'nome2',
            surname: 'sobrenome2',
            birth_date: '2002-06-27'
        )

        @hirer = Hirer.create!(
            email: 'test@mail.com',
            password: '123456789',
            username: 'mister hirer'
        )

        @project = Project.create!(
            title: 'titulo',
            description: 'descrição',
            skills_needed: 'habilidades',
            max_pay_per_hour: '123',
            open_until: 5.days.from_now,
            hirer: @hirer
        )

        @project_application = ProjectApplication.create!(
            project: @project,
            worker: @worker
        )

        @project_application.accepted!
        @project.finished!

        WorkerFeedback.create!(
            hirer: @hirer,
            worker: @worker,
            score: 4
        )

    end
    
    it 'and fails' do
        login_as @hirer, scope: :hirer
        post "/workers/#{@worker.id}/feedbacks", 
        params: {:worker_feedback => { score: 3, comment: 'muito bom'}}
        
        expect(@worker.worker_feedbacks.where(hirer: @hirer).length).to eq(1)
    end
end