# Hiring
Hiring é uma plataforma Web que permite que freelancers voltados a trabalhos relacionados a tecnologia possam ser contratos para projetos, por pessoas que tenham o interesse de contratá-las. A aplicação é feita usando Ruby on Rails, com Capybara e Rspec para testes, além de algumas [gems adicionais](#extra-gems).
Feito como projeto final para a primeira etapa do TreinaDev, turma 7.

## Setup e instalação
O projeto utiliza Ruby 2.7.0 e Rails 6.1.4.1.
Para preparar o projeto para execução, siga estes passos:
### 1. clonar o repositório
`git clone https://github.com/Hikari-desuyoo/td7-projeto-final`
### 2. instalar as gems
`bundle install`

Uma vez instalado, pode-se usar `rspec` para executar os testes do programa, ou `rails s` para iniciar o servidor.
Também é recomendado analisar o arquivo db/seeds.rb, que contém alguns modelos pré-feitos e contas prontas, para navegar pelo projeto.

## <a name="extra-gems"></a>Gems adicionais utilizadas
### Devise
Usada para gerenciar cadastro de usuários e autenticação.
### FactoryBot
Usada para criar exemplos de models de modo padronizado e enxuto em ambiente de teste.
### FFaker
Usada para geração de models aleatórios
### SimpleCov
Usada para analisar quais partes do projeto estão sendo cobertas pelo código e quais não estão.
### Rubocop
Usada para padronizar a escrita do código.
