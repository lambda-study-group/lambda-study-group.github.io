module Main exposing (main, view)

import Html exposing (..)
import Html.Attributes exposing (..)


view model =
    div []
        [ div [ class "navbar navbar-inverse navbar-fixed-top" ]
            [ div [ class "container-fluid" ]
                [ div [ class "navbar-header" ]
                    [ a [ class "navbar-brand", href "#" ] [ text "(λstudy.group)" ]
                    ]
                ]
            ]
        , div [ class "jumbotron" ]
            [ h1 [] [ text "Sejem bem vindos ao lambda study group!" ]
            , img
                [ src "assets/logo.png"
                , width 300
                , alt "Logo do grupao"
                ]
                [ text "Logo" ]
            , p []
                [ text "Nosso grupão mais top e funcional do "
                , a [ href "https://t.me/lambdastudygroup" ] [ strong [] [ text "telegram" ] ]
                , text "."
                ]
            ]
        ]


main =
    view "dummy model"
