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


paddingSmall =
    batch
        [ padding SG.spacing.small
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



-- TODO: try refact this, plz


textXLarge =
    batch [ fontSize SG.textSize.xLarge ]


textLarge =
    batch [ fontSize SG.textSize.large ]


textMedium =
    batch [ fontSize SG.textSize.medium ]


textNormal =
    batch [ fontSize SG.textSize.normal ]


textColor =
    batch [ color SG.colors.text ]


linkColor =
    batch [ color SG.colors.link ]


backgroundStyle =
    batch [ backgroundColor SG.colors.background ]
