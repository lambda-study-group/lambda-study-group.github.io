module Styles exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attrs exposing (..)
import StyleGuide as SG



-- I think this file is not necessary :(
-- I'm testing the hierarchy...


paddingLarge =
    batch
        [ padding SG.spacing.large
        ]


borderPink =
    batch
        [ borderWidth (px 2)
        , borderColor SG.colors.pink
        , borderStyle solid
        ]


font =
    batch
        [ fontWeight normal
        , fontFamilies SG.fontFamily
        ]


textXLarge =
    batch [ fontSize SG.textSize.xLarge ]


textLarge =
    batch [ fontSize SG.textSize.large ]


textColor =
    batch [ color SG.colors.text ]


linkColor =
    batch [ color SG.colors.link ]
