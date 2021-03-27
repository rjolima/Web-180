require_relative "base_api"

class Equipos < BaseApi
  def create(payload, user_id)
    #Self - acesso aos objetos da própria classe
    return self.class.post(
             "/equipos",
             body: payload,
             headers: {
               "user_id": user_id,
             },
           )
  end

  def booking(equipo_id, user_locator_id)
    return self.class.post(
             "/equipos/#{equipo_id}/bookings",
             body: { date: Time.now.strftime("%d/%m/%Y") }.to_json, #strftime formato da data que retorna na tela do Rocklov
             headers: {
               "user_id": user_locator_id,
             },
           )
  end

  def find_by_id(equipo_id, user_id)
    return self.class.get(
             "/equipos/#{equipo_id}",
             headers: {
               "user_id": user_id,
             },
           )
  end

  def list(user_id)
    return self.class.get(
             "/equipos",
             headers: {
               "user_id": user_id,
             },
           )
  end

  def remove_by_id(equipo_id, user_id)
    return self.class.delete(
             "/equipos/#{equipo_id}",
             headers: {
               "user_id": user_id,
             },
           )
  end
end
