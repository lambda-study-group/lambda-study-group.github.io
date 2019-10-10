module Elements exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attrs exposing (..)
import Styles
    exposing
        ( borderPink
        , font
        , linkColor
        , paddingLarge
        , textColor
        , textXLarge
        )


lambdaLogo =
    img [ src "assets/logo.svg", Attrs.width 120 ] []


contentWrapper =
    div
        [ css [ paddingLarge, borderPink ]
        ]


textStyled =
    styled p
        [ margin (px 0)
        , padding (rem 1.2)
        , textColor
        , font
        ]


headerTitle txt =
    h1
        [ css
            [ textColor
            , padding (px 0)
            , margin2 (rem 1.5) (rem 0)
            , textXLarge
            , font
            ]
        ]
        [ text txt ]


link { url, label } =
    a
        [ href url
        , css [ linkColor ]
        ]
        [ text label ]
