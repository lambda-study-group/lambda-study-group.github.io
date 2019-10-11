module Main exposing (..)

import Contents
import Css exposing (..)
import Css.Global exposing (body, global)
import Elements
    exposing
        ( contentWrapper
        , headerTitle
        , lambdaLogo
        , linkDefault
        , linkText
        , repositoryContainer
        , spanStyled
        , textStyled
        )
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import StyleGuide as Theme
import Styles exposing (paddingLarge, textMedium)


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
            , linkDefault Contents.telegram
            , text "."
            ]
        ]


homeSection =
    section
        [ css
            [ displayFlex
            , justifyContent center
            , flexDirection column
            , alignItems center
            , padding3 (rem 6) (rem 0) (rem 0)
            , maxWidth (px 720)
            , boxSizing borderBox
            , margin auto
            ]
        ]
        [ lambdaLogo
        , lambdaTitle
        , lambdaSeparator
        , lambdaDescription
        ]


languagesSection =
    section
        [ css [ Css.height (rem 8) ] ]
        []


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
