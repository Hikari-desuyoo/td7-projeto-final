require 'rails_helper'

RSpec.describe Project, type: :model do
    include ActiveSupport::Testing::TimeHelpers
    context 'status' do
        before :each do
            @hirer = Hirer.create!(
                email: 'test@mail.com',
                password: '123456789'
            )
        end

        it 'starts on open by default' do
            @project = Project.create!(
                title: 'titulo',
                description: 'descrição',
                skills_needed: 'habilidades',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer
            )
            expect(@project.status).to eq 'open'
        end

        it 'closes successfully' do
            @project = Project.create!(
                title: 'titulo',
                description: 'descrição',
                skills_needed: 'habilidades',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer
            )
            @project.closed!
            expect(@project.status).to eq 'closed'
        end

        it 'closes successfully on date' do
            @project = Project.create!(
                title: 'titulo',
                description: 'descrição',
                skills_needed: 'habilidades',
                max_pay_per_hour: '123',
                open_until: 5.days.from_now,
                hirer: @hirer
            )
            
            travel 7.day do
                expect(@project.status).to eq 'closed'
            end

        end
    end

end
