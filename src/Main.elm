module Main exposing (..)

import Contents
import Css exposing (..)
import Css.Global exposing (body, global)
import Elements exposing (contentWrapper, headerTitle, lambdaLogo, link, textStyled)
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
            , margin3 (rem 1.5) (rem 0) (rem 3)
            ]
        ]
        []


homeParagraph =
    styled textStyled [ textLarge, textAlign center ]


lambdaDescription =
    contentWrapper
        [ homeParagraph []
            [ text Contents.description ]
        , homeParagraph []
            [ text Contents.invite
            , link Contents.telegram
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
