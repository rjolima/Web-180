#language: pt

Funcionalidade: Cadastro de Anúncios
    Sendo usuário cadastrado no Rocklov que possui equipamentos musicais
    Quero cadastrar meus equipamentos
    Para que eu possa disponibilizados para locação

    Contexto: Login
        * Login com "rodrigo1@gmail.com" e "pwd123"

    Cenario: Novo equipo

        Dado que acesso o formulario de cadastro de anúncios
            E que eu tenho o seguinte equipamento:
            | thumb     | fender-sb.jpg |
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
        Quando submeto o cadastro desse item
        Então devo ver esse item no meu Dashboard
    
    # Foi usada uma tabela de chave e valor diferente da outra que tem coluna e valor

    Esquema do Cenario: Tentativa de cadastro de anúncios

        Dado que acesso o formulario de cadastro de anúncios
            E que eu tenho o seguinte equipamento:
            | thumb     | <foto>      |
            | nome      | <nome>      |
            | categoria | <categoria> |
            | preco     | <preco>     |
        Quando submeto o cadastro desse item
        Então deve conter a mensagem de alerta: "<saida>"

        Exemplos:
            | foto          | nome              | categoria | preco | saida                                |
            |               | Violao de Nylon   | Cordas    | 150   | Adicione uma foto no seu anúncio!    |
            | clarinete.jpg |                   | Outros    | 250   | Informe a descrição do anúncio!      |
            | mic.jpg       | Microfone Shure   |           | 100   | Informe a categoria                  |
            | trompete.jpg  | Trompete Clássico | Outros    |       | Informe o valor da diária            |
            | conga.jpg     | Gonga             | Outros    | abc   | O valor da diária deve ser numérico! |
            | conga.jpg     | Gonga             | Outros    | 100a  | O valor da diária deve ser numérico! |

