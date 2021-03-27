require "httparty"
#classe base vai importar as propriedades do http party
class BaseService
  include HTTParty
  base_uri "http://rocklov-api:3333"
end
