module Main exposing (..)

import Browser
import CombinatorsAnimated
    exposing
        ( combinatorsBackground
        )
import Contents
import Css exposing (..)
import Css.Global exposing (body, global)
import Css.Media as Media exposing (only, screen, withMedia)
import Elements
    exposing
        ( HeaderSize(..)
        , contentWrapperStyled
        , githubIcon
        , headerTitle
        , lambdaLogoLarge
        , lambdaLogoMedium
        , lambdaLogoSmall
        , languageWrapper
        , linkDefault
        , linkText
        , navigationIcon
        , repositoryContainer
        , spanStyled
        , textStyled
        )
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import StyleGuide as Theme



-- TODO: refact this module


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            , backgroundColor Theme.color.background
            ]
        ]


lambdaTitleXLarge =
    headerTitle XLarge Contents.title


lambdaTitleLarge =
    headerTitle Large Contents.title


lambdaSeparator =
    div
        [ css
            [ Css.width (px 120)
            , backgroundColor Theme.color.primary
            , Css.height (px 4)
            , margin3 (rem 1.5) (rem 0) (rem 3)
            ]
        ]
        []


homeParagraphStyled =
    styled textStyled
        [ Theme.textSize.large
        , textAlign center
        , Theme.breakpoint.tablet [ Theme.textSize.medium ]
        ]


lambdaDescription =
    contentWrapperStyled
        [ css
            [ padding (rem 4)
            , backgroundColor Theme.color.backgroundAlpha
            , Theme.breakpoint.tablet [ padding (rem 1) ]
            ]
        ]
        [ homeParagraphStyled []
            [ text Contents.description ]
        , homeParagraphStyled []
            [ text Contents.invite
            , linkDefault Contents.telegramLinkData
            , text "."
            ]
        ]


homeContent =
    div
        [ css
            [ displayFlex
            , justifyContent center
            , flexDirection column
            , alignItems center
            , padding3 (rem 6) (rem 0) (rem 0)
            , maxWidth (px 720)
            , boxSizing borderBox
            , margin auto
            , zIndex (int 2)
            , position relative
            , Theme.breakpoint.tablet [ maxWidth (px 520) ]
            ]
        ]
        [ lambdaLogoLarge
        , lambdaTitleXLarge
        , lambdaSeparator
        , lambdaDescription
        ]


homeSection : Model -> Html msg
homeSection model =
    section
        [ css [ position relative, minHeight (vh 100) ] ]
        [ combinatorsBackground model.combinators
        , homeContent
        ]


languageContainer languages =
    div
        [ css
            [ minWidth (px 240)
            , maxWidth (px 720)
            , minHeight (rem 8)
            , displayFlex
            , Theme.breakpoint.tablet [ minHeight (rem 6) ]
            , flex (int 1)
            , justifyContent spaceBetween
            ]
        ]
        (List.map languageWrapper languages)


languagesSection =
    section
        [ css
            [ displayFlex
            , padding2 (rem 12) (rem 2)
            , maxWidth (px 1440)
            , overflow Css.hidden
            , flexWrap Css.wrap
            , Css.width (pct 100)
            , Theme.breakpoint.tablet [ padding2 (rem 2) (rem 1) ]
            ]
        ]
        [ div [ css [ padding4 (rem 0) (rem 3) (rem 0) (rem 1) ] ] [ lambdaLogoSmall ]
        , languageContainer (Tuple.first Contents.languages)
        , languageContainer (Tuple.second Contents.languages)
        ]


repositoriesList =
    List.map repositoryContainer Contents.repositories


repositoriesSection =
    section
        [ css
            [ displayFlex
            , flexWrap Css.wrap
            , justifyContent spaceAround
            ]
        ]
        repositoriesList


footerLinksData =
    [ { icon = navigationIcon
      , link = Contents.telegramLinkData
      }
    , { icon = githubIcon
      , link = Contents.githubLinkData
      }
    ]


footerLink { icon, link } =
    div [ css [ displayFlex, padding3 (rem 2) (rem 1) (rem 0) ] ]
        [ icon
        , div [ css [ paddingLeft (rem 1.5) ] ]
            [ spanStyled
                [ css
                    [ Theme.textSize.large
                    , Theme.breakpoint.tablet [ Theme.textSize.medium ]
                    ]
                ]
                [ linkText link ]
            ]
        ]


lambdaFooter =
    footer
        [ css
            [ -- TODO: create some styles for flex*
              displayFlex
            , flexDirection column
            , alignItems center
            , justifyContent center
            , padding2 (rem 3) (rem 0)
            , backgroundColor Theme.color.footer
            ]
        ]
        -- Split this elements
        [ div [ css [ displayFlex ] ]
            [ lambdaLogoMedium
            , div [ css [ paddingLeft (rem 2) ] ] [ lambdaTitleLarge ]
            ]
        , div [ css [ displayFlex, justifyContent spaceAround ] ]
            (List.map
                footerLink
                footerLinksData
            )
        ]



-- MODEL


type alias Model =
    { combinators : CombinatorsAnimated.Model
    }



-- MSG


type Msg
    = UpdateCombinators CombinatorsAnimated.Msg



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( { combinators =
            CombinatorsAnimated.initModel
      }
    , Cmd.map UpdateCombinators CombinatorsAnimated.init
    )



-- VIEW


view : Model -> Browser.Document msg
view model =
    { title = Contents.title
    , body =
        List.map toUnstyled
            [ globalCss
            , homeSection model
            , languagesSection
            , repositoriesSection
            , lambdaFooter
            ]
    }



-- UPDATE


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



-- SUBSCRIPTIONS


subscriptions model =
    Sub.map UpdateCombinators
        (CombinatorsAnimated.subscriptions model.combinators)



-- MAIN


main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
