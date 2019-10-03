module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


view model =
    div [] [
        div [ class "navbar navbar-inverse navbar-fixed-top"] [
            div [ class "container-fluid" ] [
                div [ class "navbar-header" ] [
                    a [ class "navbar-brand", href "#" ] [
                        img [
                            src "assets/logo.png"
                            , width 20
                            , alt "Logo do grupao"
                        ] [text "Logo"]]
                ]
            ]
        ],
        div [ class "jumbotron" ]
            [ h1 [] [ text "Lambda study group!" ]
            , p []
                [ text "O intuito do grupo é a participação coletiva de todos e o aprendizado de cada um. No grupo do telegram você pode tirar duvidas, sugerir projetos e conversar sobre temas relacionados a programação funcional Para praticar temos alguns repositórios em que você pode resolver alguns exercicios."]
            , p []
                [ text "Entre no nosso grupo do  "
                , a [href "https://t.me/lambdastudygroup" ] [strong [] [text "telegram"]]
                , text "."]
        ],
        div [ class "project-box"]
            [ div [] 
                [ h4 [] [text "Projetos Atuais 💡"]
                , ul [ class "list-group" ] 
                    [ li [class "list-group-item"] [a [href "https://github.com/lambda-study-group/telegram-bot" ] [strong [] [text "Telegram Bot"]]]
                    , li [class "list-group-item"] [a [href "https://github.com/lambda-study-group/awesome-functional-studies" ] [strong [] [text "Juntar conteudo academico e pratico de várias linguagens em um awesome"]]]
                    , li [class "list-group-item"] [a [href "https://github.com/lambda-study-group/dicionario-termos-funcionais" ] [strong [] [text "Dicionario de tradução de termos funcionais"]]]
                    , li [class "list-group-item"] [a [href "https://github.com/lava-jato-the-game/lava_jato" ] [strong [] [text "Desenvolvimento do jogo da Lava Jato com Phoenix(Absinthe) / ClojureScript"]]]
                    ]
                ]
            , div [] 
                [ h4 [] [text "Resolução de Exercicios"]
                , ul [ class "list-group" ] 
                    [ li [class "list-group-item"] [a [href "https://github.com/lambda-study-group/desafios" ] [strong [] [text "Desafios"]]]
                    , li [class "list-group-item"] [a [href "https://github.com/lambda-study-group/sicp" ] [strong [] [text "Exercicios do livro SICP em várias linguagens diferentes"]]]
                    , li [class "list-group-item"] [a [href "https://github.com/lambda-study-group/hacker-rank" ] [strong [] [text "Exercicios da trilha de programação funcional do HackerRank"]]]
                    , li [class "list-group-item"] [a [href "https://github.com/lambda-study-group/exercism" ] [strong [] [text "Exercicios de linguagens funcionais no Exercism"]]]
                ]]
            , div []
                [ h4 [] [text "Traduções"]
                , ul [ class "list-group" ] 
                [ li [class "list-group-item"] [a [href "https://github.com/lambda-study-group/Functional-Light-JS" ] [strong [] [text "Tradução do Functional Light Programming"]]]
            ]]
        ]
    ]


main =
    view "dummy model"
