require "mongo"

#salvar log na pasta ao invéz de salvar no terminal qnd toda cucumber
Mongo::Logger.logger = Logger.new("./logs/mongo.log")

#código criado para deletar usuário cadastrado no BD antes de criar um novo cadastrado
#ness código não será usuado, pois usuário já foi cadastrado.
class Mongodb
  attr_accessor :client, :users, :equipos

  def initialize
    @client = Mongo::Client.new(CONFIG["mongo"])
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger
    @client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipo(name, email)
    user_id = get_user(email)
    @equipos.delete_many({ name: name, user: user_id })
  end
end
