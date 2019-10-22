module CombinatorsAnimated exposing
    ( Model
    , Msg(..)
    , combinatorsBackground
    , initModel
    , subscriptions
    , tick
    , update
    )

import Array
import Browser.Dom exposing (getElement)
import Browser.Events exposing (onAnimationFrame)
import Css exposing (..)
import Debug as Dbg
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
import Task
import Time


type alias Combinator =
    { letter : String
    , initialTime : Int
    , position : ( Float, Float )
    , rotate : Float
    , opacity : Float
    }


type alias Model =
    { initialTime : Int
    , curLetter : String
    , curCombinator : Combinator
    , combinators : List Combinator
    }


type Msg
    = Tick Time.Posix


duration =
    2250


ease t =
    let
        x =
            t - 1
    in
    x * x * x + 1


updateCombinators curTime model next others =
    let
        { curCombinator, initialTime } =
            model

        elapsed =
            curTime - initialTime

        progress =
            Basics.min ((elapsed |> toFloat) / duration |> ease) 1.0
    in
    if progress < 1.0 then
        { model
            | curCombinator = { curCombinator | opacity = progress }
            , combinators = { next | opacity = 1 - progress } :: others
        }

    else
        { model
            | curCombinator = { next | opacity = 0 }
            , combinators = others ++ [ { curCombinator | opacity = 1 } ]
            , initialTime = curTime
            , curLetter = next.letter
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick timePosix ->
            let
                currentTime =
                    Time.posixToMillis timePosix

                nextModel =
                    case model.combinators of
                        h :: t ->
                            updateCombinators currentTime model h t

                        _ ->
                            model
            in
            if model.initialTime == 0 then
                ( { model
                    | initialTime = currentTime
                  }
                , Cmd.none
                )

            else
                ( nextModel
                , Cmd.none
                )


tick =
    Task.perform Tick Time.now



-- Testing


initModel : Model
initModel =
    { initialTime = 0
    , curLetter = "I"
    , curCombinator =
        { letter = "I"
        , initialTime = 0
        , position = ( 25, 20 )
        , rotate = 10
        , opacity = 1
        }
    , combinators =
        [ { letter = "K"
          , initialTime = 25
          , position = ( 75, 40 )
          , rotate = 10
          , opacity = 1
          }
        , { letter = "B"
          , initialTime = 25
          , position = ( 20, 40 )
          , rotate = -3
          , opacity = 1
          }
        , { letter = "C"
          , initialTime = 75
          , position = ( 80, 15 )
          , rotate = 25
          , opacity = 1
          }
        , { letter = "W"
          , initialTime = 75
          , position = ( 10, 80 )
          , rotate = -2
          , opacity = 1
          }
        , { letter = "S"
          , initialTime = 25
          , position = ( 60, 10 )
          , rotate = -3
          , opacity = 1
          }
        , { letter = "Y"
          , initialTime = 75
          , position = ( 10, 10 )
          , rotate = -4
          , opacity = 1
          }
        , { letter = "T"
          , initialTime = 25
          , position = ( 80, 80 )
          , rotate = 4
          , opacity = 1
          }
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    onAnimationFrame Tick


combinatorWrapper curLetter { position, rotate, letter, opacity } =
    let
        ( x, y ) =
            position

        curColor =
            if curLetter == letter then
                Theme.colors.pink

            else
                Theme.colors.combinator
    in
    div
        [ css
            [ Css.position absolute
            , top (px 0)
            , left (pct x)
            , top (pct y)
            , fontSize (px 60)
            , color curColor
            , transform (Css.rotate (deg rotate))
            , fontFamilies [ "Rhodium Libre", "serif" ]
            ]
        , style "opacity" (String.fromFloat opacity)
        ]
        [ text letter ]


combinatorsBackground : Model -> Html msg
combinatorsBackground model =
    let
        { curLetter, combinators, curCombinator } =
            model
    in
    div
        [ css
            [ position absolute
            , Css.width (pct 100)
            , Css.height (pct 100)
            ]
        ]
        (List.map
            (combinatorWrapper curLetter)
            (curCombinator :: combinators)
        )
