require_relative "base_api"

class Sessions < BaseApi
  def login(payload)
    #Self - acesso aos objetos da própria classe
    return self.class.post(
             "/sessions",
             body: payload.to_json,
             headers: {
               "content-type": "application/json",
             },
           )
  end
end
