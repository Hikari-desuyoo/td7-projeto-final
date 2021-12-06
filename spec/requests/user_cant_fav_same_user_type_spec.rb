require 'rails_helper'

describe 'cant favorite hirer' do
  it 'successfully if youre a hirer too' do
    hirer = create(:hirer)
    hirer2 = create(:hirer)

    login_as hirer, scope: :hirer

    post "/favorited_hirers/#{hirer2.id}/favorite"

    expect(response).to redirect_to('/workers/sign_in')
  end

  it 'successfully if youre a visitor' do
    create(:hirer)
    hirer2 = create(:hirer)

    post "/favorited_hirers/#{hirer2.id}/favorite"

    expect(response).to redirect_to('/workers/sign_in')
  end
end

describe 'cant favorite worker' do
  it 'successfully if youre a worker too' do
    worker = create(:worker, :complete)
    worker2 = create(:worker, :complete)

    login_as worker, scope: :worker

    post "/favorited_workers/#{worker2.id}/favorite"

    expect(response).to redirect_to('/hirers/sign_in')
  end

  it 'successfully if youre a visitor' do
    create(:worker, :complete)
    worker2 = create(:worker, :complete)

    post "/favorited_workers/#{worker2.id}/favorite"

    expect(response).to redirect_to('/hirers/sign_in')
  end
end
