require_relative "base_service"

class EquiposService < BaseService #vai herdar da classe base services
  def create(equipo, user_id)
    return self.class.post(
             "/equipos",
             body: equipo,
             headers: {
               "user_id": user_id,
             },
           )
  end

  def booking(equipo_id, user_locator_id) # equipo ID do anuciante e do locatário
    return self.class.post(
             "/equipos/#{equipo_id}/bookings",
             body: { date: Time.now.strftime("%d/%m/%Y") }.to_json,
             headers: {
               "content-type": "application/json", #informar no cabeçalho qual tipo de informação que será enviada para API
               "user_id": user_locator_id,
             },
           )
  end
end
