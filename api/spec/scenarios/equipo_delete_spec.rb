#encoding: utf-8

describe "DELETE /equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "to@mate.com", password: "pwd123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter unico equipo" do
    before(:all) do
      # dado que eu tenho um novo equipamento
      @payload = {
        thumbnail: Helpers::get_thumb("pedais.jpg"),
        name: "Pedais do Tom Morello",
        category: "Áudio e Tecnologia".force_encoding("ASCII-8BIT"),
        #para trabalhar com encondig: utf-8, por causa da acentuação, força uso do encoding
        price: 199,
      }

      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      # e eu tenho o id desse equipamento
      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      # quando faço uma requisição delete por id
      @result = Equipos.new.remove_by_id(@equipo_id, @user_id)
    end

    it "deve retornar 204" do
      expect(@result.code).to eql 204
    end
  end

  context "equipo nao existe" do
    before(:all) do
      @result = Equipos.new.remove_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar 204" do
      expect(@result.code).to eql 204
    end
  end
end
