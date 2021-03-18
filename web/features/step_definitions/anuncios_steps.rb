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
