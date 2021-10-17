require 'rails_helper'

describe 'worker tries to give project feedback twice' do
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

        ProjectFeedback.create!(
            worker: @worker,
            project: @project,
            score: 4
        )

    end
    
    it 'and fails' do
        login_as @worker, scope: :worker
        post "/projects/#{@project.id}/feedbacks", 
        params: {:project_feedback => { score: 3, comment: 'muito bom'}}
        
        expect(@project.project_feedbacks.where(worker: @worker).length).to eq(1)
    end
end