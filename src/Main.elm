module Main exposing (..)

import Browser
import CombinatorsAnimated
    exposing
        ( combinatorsBackground
        )
import Contents
import Css exposing (..)
import Css.Global exposing (body, global)
import Elements
    exposing
        ( HeaderSize(..)
        , contentWrapper
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
import Styles exposing (backgroundStyle, paddingLarge, textMedium)



-- TODO: refact this module


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            , backgroundStyle
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
            , backgroundColor Theme.colors.pink
            , Css.height (px 4)
            , margin3 (rem 1.5) (rem 0) (rem 3)
            ]
        ]
        []


homeParagraph =
    styled textStyled [ textMedium, textAlign center ]


lambdaDescription =
    contentWrapper [ css [ paddingLarge ] ]
        [ homeParagraph []
            [ text Contents.description ]
        , homeParagraph []
            [ text Contents.invite
            , linkDefault Contents.telegramLinkData
            , text "."
            ]
        ]


homeSection : Model -> Html msg
homeSection model =
    section
        [ css [ position relative, minHeight (vh 100) ] ]
        [ combinatorsBackground model.combinators
        , div
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
                ]
            ]
            [ lambdaLogoLarge
            , lambdaTitleXLarge
            , lambdaSeparator
            , lambdaDescription
            ]
        ]


languagesSection =
    section
        [ css
            [ Css.height (rem 10)
            , displayFlex
            , padding2 (rem 12) (rem 2)
            , maxWidth (px 1440)
            , overflow Css.hidden
            , Css.width (pct 100)
            ]
        ]
        [ div [ css [ padding4 (rem 0) (rem 3) (rem 0) (rem 1) ] ] [ lambdaLogoSmall ]
        , div
            [ css
                [ minWidth (px 700)
                , maxWidth (px 1440)
                , displayFlex
                , flex (int 1)
                , justifyContent spaceBetween
                ]
            ]
            (List.map languageWrapper Contents.languages)
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
            [ spanStyled [ css [ textMedium ] ]
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
            , backgroundColor Theme.colors.footer
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


type alias Model =
    { combinators : CombinatorsAnimated.Model
    }


type Msg
    = UpdateCombinators CombinatorsAnimated.Msg


init : () -> ( Model, Cmd Msg )
init _ =
    ( { combinators =
            CombinatorsAnimated.initModel
      }
    , Cmd.map UpdateCombinators CombinatorsAnimated.init
    )


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


update msg model =
    case msg of
        UpdateCombinators msgCombinators ->
            let
                ( combinators, cmdMsg ) =
                    CombinatorsAnimated.update msgCombinators model.combinators
            in
            ( { model | combinators = combinators }, Cmd.map UpdateCombinators cmdMsg )


subscriptions model =
    Sub.map UpdateCombinators
        (CombinatorsAnimated.subscriptions model.combinators)


main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
