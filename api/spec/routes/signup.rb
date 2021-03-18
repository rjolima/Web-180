require_relative "base_api"

class Signup < BaseApi
  def create(payload)
    #Self - acesso aos objetos da própria classe
    return self.class.post(
             "/signup",
             body: payload.to_json,
             headers: {
               "content-type": "application/json",
             },
           )
  end
end
