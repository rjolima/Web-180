require_relative "routes/signup"
require_relative "libs/mongo"

describe "Post /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Pitty", email: "pitty@gmail.com", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24 #Id de caracteres do mongoDB
      # puts result.parsed_response["_id"]
      # puts result.parsed_response.class
    end
  end

  context "usuario ja existe" do
    before(:all) do
      #dado que tenho um novo usuário
      payload = { name: "joao", email: "joao@gmail.com", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      #e o email desse usuário já foi cadastrado no sistema
      Signup.new.create(payload) # uma vez para cadastrar e a outra pra validar que já foi cadastrado

      #quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end

    it "valida status code 409" do
      #então retorna 409
      expect(@result.code).to eql 409
    end
    it "deve retonar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end
  # nome é obrigatório
  # email é obrigatório
  # pass é obrigatório
end
