module Main exposing (main, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Http


type Model
    = Failure
    | Loading
    | Success String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://raw.githubusercontent.com/lambda-study-group/lambdinha-bot/master/jokes.json"
        , expect = Http.expectString GotText
        }
    )


type Msg
    = GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ div [ class "navbar navbar-inverse navbar-fixed-top" ]
            [ div [ class "container-fluid" ]
                [ div [ class "navbar-header" ]
                    [ a [ class "navbar-brand", href "#" ] [ text "(λstudy.group)" ]
                    ]
                ]
            ]
        , case model of
            Failure ->
                text "Meu pensamento não funcinou"

            Loading ->
                text "Pensando numa piada..."

            Success fullText ->
                pre [] [ text fullText ]
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
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
