module Main exposing (..)

import Browser
import CombinatorsAnimated exposing (combinatorsBackground)
import Contents
import Css exposing (..)
import Css.Global exposing (body, global)
import Elements
    exposing
        ( ContentHome
        , HeaderSize(..)
        , footerSection
        , githubIcon
        , homeContent
        , languagesSection
        , navigationIcon
        , repositoriesSection
        )
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import StyleGuide as Theme


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            , backgroundColor Theme.color.background
            ]
        ]


homeSection : CombinatorsAnimated.Model -> ContentHome -> Html msg
homeSection combinators contents =
    section
        [ css [ position relative, minHeight (vh 100) ] ]
        [ combinatorsBackground combinators
        , homeContent contents
        ]


contentHome =
    { title = Contents.title
    , groupLink = Contents.telegramLinkData
    , textInvite = Contents.invite
    , description = Contents.description
    }


footerLinksData =
    [ { icon = navigationIcon
      , link = Contents.telegramLinkData
      }
    , { icon = githubIcon
      , link = Contents.githubLinkData
      }
    ]



-------------------------------------------------------------------------------
-- MODEL
-------------------------------------------------------------------------------


type alias Model =
    { combinators : CombinatorsAnimated.Model
    }



-------------------------------------------------------------------------------
-- MSG
-------------------------------------------------------------------------------


type Msg
    = UpdateCombinators CombinatorsAnimated.Msg



-------------------------------------------------------------------------------
-- INIT
-------------------------------------------------------------------------------


init : () -> ( Model, Cmd Msg )
init _ =
    ( { combinators =
            CombinatorsAnimated.initModel
      }
    , Cmd.map UpdateCombinators CombinatorsAnimated.init
    )



-------------------------------------------------------------------------------
-- VIEW
-------------------------------------------------------------------------------


preUnstyled =
    List.map toUnstyled
        [ globalCss
        , languagesSection Contents.languages
        , repositoriesSection Contents.repositories
        , footerSection footerLinksData Contents.title
        ]


view : Model -> Browser.Document msg
view { combinators } =
    { title = Contents.title
    , body = (toUnstyled <| homeSection combinators contentHome) :: preUnstyled
    }



-------------------------------------------------------------------------------
-- UPDATE
-------------------------------------------------------------------------------


update msg model =
    case msg of
        UpdateCombinators msgCombinators ->
            let
                ( combinators, cmdMsg ) =
                    CombinatorsAnimated.update msgCombinators model.combinators
            in
            ( { model | combinators = combinators }
            , Cmd.map UpdateCombinators cmdMsg
            )



-------------------------------------------------------------------------------
-- SUBSCRIPTIONS
-------------------------------------------------------------------------------


subscriptions model =
    Sub.map UpdateCombinators
        (CombinatorsAnimated.subscriptions model.combinators)



-------------------------------------------------------------------------------
-- MAIN
-------------------------------------------------------------------------------


main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
