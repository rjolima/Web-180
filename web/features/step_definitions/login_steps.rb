Dado('que acesso a página principal') do
    @login_page.open
end

Quando('submeto minhas credenciais válidas {string} e {string}') do |email, password|
    @login_page.with(email, password)
end