require 'rails_helper'

RSpec.describe WorkerFeedback, type: :model do
  before(:each) do
    @hirer = Hirer.create!(
      email: 'test@mail.com',
      password: '123456789'
    )
    @worker = Worker.create!(
      email: 'test@mail.com',
      password: '123456789'
    )
  end

  it 'validates score' do
    feedback = WorkerFeedback.new(
      hirer: @hirer,
      worker: @worker,
      comment: 'comentario',
      score: 10
    )

    expect(feedback.save).to eq(false)

  end
end
