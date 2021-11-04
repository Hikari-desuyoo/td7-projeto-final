require 'rails_helper'

describe 'project feedback shows up on project page' do
    before(:each) do
        @worker = create(:worker, :complete)
        @hirer = create(:hirer)
        @project = create(:project, hirer: @hirer)

        @project_feedback = ProjectFeedback.create!(
            project: @project,
            worker: @worker,
            score: 5,
            comment: 'Projeto muito bom'
        )

        @project.finished!
    end

    it 'successfully' do
        @project.finished!
        
        visit "/projects/#{@project.id}"

        within '.project_feedback' do
            expect(page).to have_content(@project_feedback.worker.get_full_name)
            expect(page).to have_content(@project_feedback.comment)
            expect(page).to have_content('5')
        end

        expect(page.body).to_not include('translation-missing')
        expect(page.body).to_not include('translation missing')
    end


end