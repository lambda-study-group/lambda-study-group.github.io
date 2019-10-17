module CombinatorsAnimated exposing (Model, combinatorsBackground, initModel)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attrs exposing (..)
import StyleGuide as Theme
import Styles
    exposing
        ( backgroundStyle
        , borderPink
        , font
        , linkColor
        , paddingLarge
        , textColor
        , textLarge
        , textMedium
        , textXLarge
        )


type alias Combinator =
    { letter : String
    , delay : Float
    , translate : ( Float, Float )
    , shiftX : Float
    }


type alias Model =
    List Combinator



-- Testing


initModel : List Combinator
initModel =
    [ { letter = "S"
      , delay = 500
      , translate = ( 0, 0 )
      , shiftX = 20
      }
    , { letter = "K"
      , delay = 0
      , translate = ( 0, 0 )
      , shiftX = 80
      }
    ]


combinatorWrapper : Combinator -> Html msg
combinatorWrapper data =
    let
        ( tx, ty ) =
            data.translate

        sx =
            data.shiftX

        label =
            data.letter
    in
    div
        [ css
            [ position absolute
            , bottom (px 0)
            , left (pct sx)
            , textLarge

            -- temporary
            , color Theme.colors.pink
            ]
        ]
        [ text label ]


combinatorsBackground : List Combinator -> Html msg
combinatorsBackground combinatorsList =
    div
        [ css
            [ position absolute
            , Css.width (pct 100)
            , Css.height (pct 100)
            ]
        ]
        (List.map combinatorWrapper combinatorsList)
