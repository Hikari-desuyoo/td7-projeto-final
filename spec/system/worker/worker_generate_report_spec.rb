require 'rails_helper'

describe 'Worker requests(and receives) overview report' do
    it 'successfully' do
        worker = create(:worker)
        projects = create_list(:project, 3)
        closed_projects = create_list(:project, 3, :closed)
        ten_star_project = create(
            :project_application, 
            :ten_star_project
        )
        byebug
    end
end