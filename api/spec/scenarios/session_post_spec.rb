describe "Post /sessions" do
  context "login com sucesso" do
    before(:all) do #(:all) para rodar uma única vez, para não rodar 2x para o before uma para cada IT
      payload = { email: "rodrigo2@gmail.com", password: "pwd123" }
      @result = Sessions.new.login(payload)
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
  # Todos os dados foram comentados para usar um arquivo do tipo yml (com ruby não usar CSV), sendo assim a lista vem do login.yml
  # examples = [
  #   {
  #     title: "Senha incorreta",
  #     payload: { email: "rodrigo1@gmail.com", password: "pwd456" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "usuario não existe",
  #     payload: { email: "404@gmail.com", password: "pwd123" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "email em branco",
  #     payload: { email: "", password: "pwd456" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "sem o campo email",
  #     payload: { password: "pwd456" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "senha em branco",
  #     payload: { email: "rodrigo1@gmail.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "sem o campo senha",
  #     payload: { email: "rodrigo1@gmail.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  examples = Helpers::get_fixture("login")
  #Helpers vai obter os arquivos do login Yml

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do #(:all) para rodar uma única vez, para não rodar 2x para o before uma para cada IT
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code" do
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuário" do
        expect(@result.parsed_response["error"]).to eql e[:error] #Id de caracteres do mongoDB
        # puts result.parsed_response["_id"]
        # puts result.parsed_response.class
      end
    end
  end
end
