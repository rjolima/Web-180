Dado("que acesso a página de cadastro") do
  @signup_page.open
end

Quando("submeto o seguinte formulário de cadastro:") do |table|

  #log table.hashes
  user = table.hashes.first #vai converte a tabela em um array de dados

  Mongodb.new.remove_user(user[:email])

  @signup_page.create(user)
end
