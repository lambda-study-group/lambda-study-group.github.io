module StyleGuide exposing (colors, fontFamily, spacing, textSize)

import Css exposing (batch, fontFamilies, fontWeight, hex, normal, rem)


colors =
    { text = hex "ffffff"
    , link = hex "e499f0"
    , icon = hex "ffffff"
    , background = hex "000000"
    , combinator = hex "36223A"
    , language = hex "C770D5"
    , pink = hex "d872e9"
    , footer = hex "1C1C1C"
    }



-- Remove rem unit?


textSize =
    { small = rem 0.75
    , normal = rem 1
    , medium = rem 2
    , large = rem 2.5
    , xLarge = rem 4
    }


spacing =
    { tiny = rem 0.5
    , small = rem 1
    , medium = rem 2
    , large = rem 3
    , xLarge = rem 4
    }


fontFamily =
    [ "Ropa Sans", "sans-serif" ]



-- # TODO
-- add breakpoints
