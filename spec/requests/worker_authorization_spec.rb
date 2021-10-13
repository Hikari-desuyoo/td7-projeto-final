require 'rails_helper'

describe 'Worker' do
    before(:each) do
        Occupation.create!(name: 'dev')

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

        @project_applications = ProjectApplication.create!(
            project: @project,
            worker: @worker
        )

    end

    it 'cannot apply for a project twice' do
        login_as @worker, scope: :worker
        post '/projects/1/project_applications'
        expect(response).to redirect_to(root_path)
    end
end