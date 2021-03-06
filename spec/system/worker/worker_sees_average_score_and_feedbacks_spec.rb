require 'rails_helper'

describe 'Logged (complete)Worker' do
  include ActiveSupport::Testing::TimeHelpers

  it 'successfully sees average' do
    Occupation.create!(name: 'dev')

    worker = create(:worker, :complete)
    hirer = create :hirer

    WorkerFeedback.new(
      worker: worker,
      hirer: hirer,
      score: 2,
      comment: 'bom freelancer ;)'
    ).save(validate: false)

    WorkerFeedback.new(
      worker: worker,
      hirer: hirer,
      score: 4
    ).save(validate: false)

    WorkerFeedback.new(
      worker: worker,
      hirer: hirer,
      score: 5
    ).save(validate: false)

    login_as worker, scope: :worker
    visit root_path

    click_on 'worker_profile_button'

    expect(page).to have_css('#worker_details')
    expect(page).to have_content(worker.get_full_name)

    expect(page).to have_css('#average_score', text: '3,67')

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end

  it 'successfully sees feedbacks' do
    Occupation.create!(name: 'dev')

    worker = create(:worker, :complete)
    hirer = create :hirer

    WorkerFeedback.new(
      worker: worker,
      hirer: hirer,
      score: 2,
      comment: 'bom freelancer ;)'
    ).save(validate: false)

    WorkerFeedback.new(
      worker: worker,
      hirer: hirer,
      score: 4
    ).save(validate: false)

    WorkerFeedback.new(
      worker: worker,
      hirer: hirer,
      score: 5
    ).save(validate: false)

    login_as worker, scope: :worker
    visit root_path

    click_on 'worker_profile_button'

    within '#worker_feedbacks' do
      expect(page).to have_content(hirer.username, count: 3) # NÃO ACONTECE NORMALMENTE(3 vezes mesma pessoa)
      expect(page).to have_content('bom freelancer')
      expect(page).to have_content('5')
      expect(page).to have_content('4')
      expect(page).to have_content('2')
    end

    expect(page.body).to_not include('translation-missing')
    expect(page.body).to_not include('translation missing')
  end
end
