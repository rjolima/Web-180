Dado("Login com {string} e {string}") do |email, password|
  @email = email #criar variável e-mail para ter acesso ao metodo que está em outro lugar

  @login_page.open
  @login_page.with(email, password)

  # checkpoint para garantir que estamos no Dashboard
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesso o formulario de cadastro de anúncios") do
  @dash_page.goto_equipo_form
end

Dado("que eu tenho o seguinte equipamento:") do |table| #@ no @anuncio cria uma váriavel de instância ou um variável global
  @anuncio = table.rows_hash

  Mongodb.new.remove_equipo(@anuncio[:nome], @email)
end

Quando("submeto o cadastro desse item") do
  @equipos_page.create(@anuncio)
end

Então("devo ver esse item no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então("deve conter a mensagem de alerta: {string}") do |expect_alert|
  expect(@alert.dark).to have_text expect_alert #have_text contem a mesagem de alerta
end

# Remover anúncios

Dado("que eu tenho um anúncio indesejado:") do |table|
  user_id = page.execute_script("return localStorage.getItem('user')") #retornar o código Java Script, na chave user local storage

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")
  #código que vai cadastrar o unúcio via api no projeto para automação Web,
  #usando http party para fazer integração com API para cosumir e preparar massa de teste mais rápida
  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  EquiposService.new.create(@equipo, user_id) #para consumir o serviço equipos

  visit current_path #vai atualizar a página para exibir o item que acabou de ser cadastrado via API
end

Quando("eu solicito a exclusão desse item") do
  @dash_page.request_removal(@equipo[:name])
  sleep 1 # think time (como se fosse um tempo para pensar de vai deletar)
end

Quando("confirmo a exclusão") do
  @dash_page.confirm_removal
end

Quando("não confirmo a solicitação") do #quando e o mas fazem parte da ação
  @dash_page.cancel_removal
end

Então("não devo ver esse item no meu Dashboard") do
  expect(
    @dash_page.has_no_equipo?(@equipo[:name])
  ).to be true
end

Então("esse item deve permancer no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @equipo[:name] #name inglês criado no formato do @equipo
end
