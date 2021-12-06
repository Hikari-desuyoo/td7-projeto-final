require 'rails_helper'

describe 'Hirer' do
  it 'cannot sign in as worker at the same time' do
    hirer = create(:hirer)
    login_as hirer, scope: :hirer
    get '/workers/sign_in'
    expect(response).to redirect_to(root_path)
  end

  it 'cannot sign up as worker at the same time' do
    hirer = create(:hirer)
    login_as hirer, scope: :hirer
    get '/workers/sign_up'
    expect(response).to redirect_to(root_path)
  end
end

describe 'Worker' do
  it 'cannot sign in as hirer at the same time' do
    worker = create(:worker)
    login_as worker, scope: :worker
    get '/hirers/sign_in'
    expect(response).to redirect_to(root_path)
  end

  it 'cannot sign up as hirer at the same time' do
    worker = create(:worker)
    login_as worker, scope: :worker
    get '/hirers/sign_up'
    expect(response).to redirect_to(root_path)
  end
end
