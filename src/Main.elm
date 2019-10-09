module Main exposing (..)

import Contents
import Css exposing (..)
import Css.Global exposing (body, global)
import Elements exposing (contentWrapper, headerTitle, lambdaLogo, textStyled)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import StyleGuide as Theme
import Styles exposing (textLarge)


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            , backgroundColor Theme.colors.background
            ]
        ]


lambdaTitle =
    headerTitle Contents.title


lambdaSeparator =
    div
        [ css
            [ Css.width (px 120)
            , backgroundColor Theme.colors.pink
            , Css.height (px 4)
            ]
        ]
        []


lambdaDescription =
    div [] []


homeSection =
    section
        [ css
            [ displayFlex
            , justifyContent center
            , flexDirection column
            , alignItems center
            , padding (rem 6)
            , maxWidth (px 720)
            , boxSizing borderBox
            , margin auto
            ]
        ]
        [ lambdaLogo
        , lambdaTitle
        , lambdaSeparator
        , contentWrapper
            [ textStyled [ css [ textLarge ] ] [ text Contents.description ]
            ]
        ]


languagesSection =
    section [] []


repositoriesSection =
    section [] []


lambdaFooter =
    footer [] []


view =
    div
        []
        [ globalCss
        , homeSection
        , languagesSection
        , repositoriesSection
        , lambdaFooter
        ]


main =
    toUnstyled view
