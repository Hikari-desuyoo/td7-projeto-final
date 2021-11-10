Occupation.create(name: 'dev')
Occupation.create(name: 'ux')
Occupation.create(name: 'design')
Occupation.create(name: 'dba')

# email: test1@email.com password: 123456789
worker = FactoryBot.create(:worker, :complete)

# email: test1@email.com password: 123456789
hirer = FactoryBot.create(:hirer)

# email: test2@email.com password: 123456789
hirer2 = FactoryBot.create(:hirer)

# NO APPLICATION
project = FactoryBot.create(:project, hirer: hirer)

# PENDING APPLICATION
project2 = FactoryBot.create(:project, hirer: hirer)
project_application2 = FactoryBot.create(:project_application, worker: worker, project: project2)

# DECLINED APPLICATION
project3 = FactoryBot.create(:project, hirer: hirer)
project_application3 = FactoryBot.create(:project_application, :declined, worker: worker, project: project3)

# ACCEPTED APPLICATION
project4 = FactoryBot.create(:project, hirer: hirer)
project_application4 = FactoryBot.create(:project_application, status: :accepted, worker: worker, project: project4)

# FINISHED PROJECT
project5 = FactoryBot.create(:project, hirer: hirer2)
project_application5 = FactoryBot.create(:project_application, status: :accepted, worker: worker, project: project5)
project5.finished!

# email: test2@email.com password: 123456789
worker2 = FactoryBot.create(:worker, :complete)

# email: test3@email.com password: 123456789
worker3 = FactoryBot.create(:worker)

# email: test2@email.com password: 123456789
hirer2 = FactoryBot.create(:hirer)