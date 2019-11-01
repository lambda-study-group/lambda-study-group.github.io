module StyleGuide exposing (breakpoint, color, colorRaw, fontFamily, spacing, textSize)

import Css exposing (fontFamilies, fontSize, hex, px, rem)
import Css.Media as Media exposing (only, screen, withMedia)


colorRaw =
    { primary = "#D872E9"
    , background = "#000000"
    }


color =
    { text = hex "FFFFFF"
    , link = hex "E499F0"
    , linkHover = hex "C770D5"
    , icon = hex "FFFFFF"
    , background = hex colorRaw.background
    , backgroundAlpha = hex "00000042"
    , combinator = hex "36223A"
    , language = hex "C770D5"
    , primary = hex colorRaw.primary
    , footer = hex "1C1C1C"
    }


textSize =
    { small = fontSize (rem 0.75)
    , normal = fontSize (rem 1)
    , medium = fontSize (rem 1.5)
    , large = fontSize (rem 2)
    , xLarge = fontSize (rem 2.5)
    , xxLarge = fontSize (rem 4)
    }


spacing =
    { tiny = rem 0.5
    , small = rem 1
    , medium = rem 2
    , large = rem 3
    , xLarge = rem 4
    }


fontFamily =
    { primary = fontFamilies [ "Ropa Sans", "sans-serif" ]
    , secondary = fontFamilies [ "Rhodium Libre", "serif" ]
    }


breakpoint =
    { tablet = withMedia [ only screen [ Media.maxWidth (px 800) ] ]
    }
