require 'rails_helper'

RSpec.describe ProjectApplicationMailer, type: :mailer do
  context 'new application' do
    it 'should notify hirer' do
      hirer = create(:hirer, email: 'empregador@mail.com')
      worker = create(:worker, name: 'Hikari', surname: 'Luz')
      project = create(:project, title: 'projeto novo', hirer: hirer)
      project_application = create(
        :project_application,
        worker: worker,
        project: project
      )

      mail = ProjectApplicationMailer.notify_new_project_application(project_application.id)

      expect(mail.to).to eq ['empregador@mail.com']
      expect(mail.from).to eq ['nao-responda@hiring.com.br']
      expect(mail.subject).to eq 'Nova proposta para seu projeto'
      expect(mail.body).to include "Seu projeto <strong>'projeto novo'</strong> teve uma proposta nova por Hikari Luz"
    end
  end
end
