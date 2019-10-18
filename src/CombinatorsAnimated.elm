module CombinatorsAnimated exposing
    ( Model
    , Msg(..)
    , combinatorsBackground
    , initAnimation
    , initModel
    , subscriptions
    , update
    )

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
    , delay : Int
    , initialTime : Int
    , translate : ( Float, Float )
    , shiftX : Float
    , hidden : Bool
    }


type alias Model =
    { totalHeight : Float
    , combinators : List Combinator
    }


type Msg
    = Init (Result Browser.Dom.Error ( Time.Posix, Browser.Dom.Element ))
    | Tick Time.Posix


duration =
    9000


setInitialTime currentTime combinator =
    { combinator
        | initialTime = currentTime
    }


updateCombinators : Int -> Float -> Combinator -> Combinator
updateCombinators currentTime totalHeight ({ initialTime, delay, translate } as combinator) =
    let
        elapsed =
            currentTime - initialTime - delay

        ( progress, hidden ) =
            if elapsed < 0 then
                ( 0, True )

            else
                ( Basics.min ((elapsed |> toFloat) / duration) 1.0, False )

        ty =
            totalHeight * progress

        initialTimeNext =
            if progress == 1.0 then
                currentTime

            else
                initialTime
    in
    { combinator
        | initialTime = initialTimeNext
        , translate = Tuple.mapSecond (always ty) translate
        , hidden = hidden
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init result ->
            case result of
                Result.Ok ( timePosix, { element } as el ) ->
                    let
                        currentTime =
                            Time.posixToMillis timePosix
                    in
                    ( { model
                        | totalHeight = element.height
                        , combinators = List.map (setInitialTime currentTime) model.combinators
                      }
                    , Cmd.none
                    )

                Result.Err _ ->
                    ( model, Cmd.none )

        Tick timePosix ->
            let
                currentTime =
                    Time.posixToMillis timePosix

                combinators =
                    List.map
                        (updateCombinators currentTime model.totalHeight)
                        model.combinators
            in
            ( { model
                | combinators = combinators
              }
            , Cmd.none
            )


initAnimation : String -> Cmd Msg
initAnimation parentId =
    Task.attempt
        Init
        (Task.map2 (\r -> \t -> ( t, r )) (getElement parentId) Time.now)


onTick =
    Task.perform Tick Time.now



-- Testing


initModel : Model
initModel =
    { totalHeight = 0
    , combinators =
        [ { letter = "S"
          , delay = 6000
          , initialTime = 0
          , translate = ( 0, 0 )
          , shiftX = 10
          , hidden = True
          }
        , { letter = "K"
          , delay = 100
          , initialTime = 0
          , translate = ( 0, 0 )
          , shiftX = 20
          , hidden = True
          }
        , { letter = "I"
          , delay = 5000
          , initialTime = 0
          , translate = ( 0, 0 )
          , shiftX = 80
          , hidden = True
          }
        , { letter = "W"
          , delay = 2000
          , initialTime = 0
          , translate = ( 0, 0 )
          , shiftX = 90
          , hidden = True
          }
        , { letter = "B"
          , delay = 11000
          , initialTime = 0
          , translate = ( 0, 0 )
          , shiftX = 85
          , hidden = True
          }
        , { letter = "Y"
          , delay = 13000
          , initialTime = 0
          , translate = ( 0, 0 )
          , shiftX = 15
          , hidden = True
          }
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.totalHeight == 0 then
        Sub.none

    else
        onAnimationFrame Tick


combinatorWrapper : Combinator -> Html msg
combinatorWrapper data =
    let
        ( tx, ty ) =
            data.translate

        stx =
            String.fromFloat tx

        sty =
            String.fromFloat -ty

        sx =
            data.shiftX

        label =
            data.letter

        display =
            if data.hidden then
                "none"

            else
                "block"
    in
    div
        [ css
            [ position absolute
            , bottom (px 20)
            , left (pct sx)
            , textXLarge
            , color Theme.colors.combinator
            ]
        , style "transform" ("translate3d(" ++ stx ++ "px," ++ sty ++ "px, 0)")
        , style "transform-origin" "0 0"
        , style "display" display
        ]
        [ text label ]


combinatorsBackground : Model -> Html msg
combinatorsBackground model =
    div
        [ id "home"
        , css
            [ position absolute
            , Css.width (pct 100)
            , Css.height (pct 100)
            ]
        ]
        (List.map combinatorWrapper model.combinators)
