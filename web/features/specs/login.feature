#language: pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais válidas "rodrigo1@gmail.com" e "pwd123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenário: tentar logar
        Dado que acesso a página principal
        Quando submeto minhas credenciais válidas "<email_input> " e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input       | senha_input | mensagem_output                  |
            | rodrigo@gmail.com | 1234567     | Usuário e/ou senha inválidos.    |
            | rlima@404.com     | pwd1245     | Usuário e/ou senha inválidos.    |
            | rodrigo#gmail.com | pwd123      | Oops. Informe um email válido!   |
            |                   | pwd123      | Oops. Informe um email válido!   |
            | rodrigo@gmail.com |             | Oops. Informe sua senha secreta!  |
