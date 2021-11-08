require 'rails_helper'

describe 'cant favorite hirer' do
  before(:each) do
    @hirer = Hirer.create!(
      email: 'test@mail.com',
      password: '123456789',
      username: 'mister hirer'
    )

    @hirer2 = Hirer.create!(
      email: 'test2@mail.com',
      password: '123456789',
      username: 'mister hirer2'
    )
  end

  it 'successfully if youre a hirer too' do
    login_as @hirer, scope: :hirer

    post "/favorited_hirers/#{@hirer2.id}/favorite"

    expect(response).to redirect_to('/workers/sign_in')
  end

  it 'successfully if youre a visitor' do
    post "/favorited_hirers/#{@hirer2.id}/favorite"

    expect(response).to redirect_to('/workers/sign_in')
  end
end

describe 'cant favorite worker' do
  before(:each) do
    @worker = Worker.create!(
      email: 'test1@mail.com',
      password: '123456789',
      name: 'nome1',
      surname: 'sobrenome1',
      birth_date: '2002-06-27'
    )

    @worker2 = Worker.create!(
      email: 'test2@mail.com',
      password: '123456789',
      name: 'nome2',
      surname: 'sobrenome2',
      birth_date: '2002-06-27'
    )
  end

  it 'successfully if youre a worker too' do
    login_as @worker, scope: :worker

    post "/favorited_workers/#{@worker2.id}/favorite"

    expect(response).to redirect_to('/hirers/sign_in')
  end

  it 'successfully if youre a visitor' do
    post "/favorited_workers/#{@worker2.id}/favorite"

    expect(response).to redirect_to('/hirers/sign_in')
  end
end
