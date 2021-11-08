require 'rails_helper'

describe 'Visitor' do
  before(:each) do
    Occupation.create!(name: 'dev')
    @worker = create(:worker, :complete)
    @hirer = create(:hirer)

    @project = Project.create!(
      title: 'titulo',
      description: 'descrição',
      skills_needed: 'habilidades',
      max_pay_per_hour: '123',
      open_until: 5.days.from_now,
      hirer: @hirer
        )
  end

  it 'cannot apply for a project' do
    post '/projects/1/project_applications'
    expect(response).to redirect_to(new_worker_session_path)
  end
end
