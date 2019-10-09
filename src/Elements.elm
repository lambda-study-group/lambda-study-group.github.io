module Elements exposing (..)

import Css exposing (..)
import Html.Styled exposing (div, h1, img, span, styled, text)
import Html.Styled.Attributes as Attrs exposing (css, src)
import Styles exposing (borderPink, colorText, font, paddingLarge, textXLarge)


lambdaLogo =
    img [ src "assets/logo.svg", Attrs.width 120 ] []


contentWrapper =
    div
        [ css [ paddingLarge, borderPink ]
        ]


textStyled =
    styled span [ colorText, font ]


headerTitle txt =
    h1 [ css [ colorText, padding (px 0), textXLarge, font ] ] [ text txt ]
