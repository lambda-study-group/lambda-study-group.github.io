module CombinatorsAnimated exposing
    ( Model
    , Msg(..)
    , combinatorsBackground
    , init
    , initModel
    , subscriptions
    , update
    )

import Array
import Browser.Dom exposing (getElement)
import Browser.Events exposing (onAnimationFrame)
import Css exposing (..)
import Css.Media as Media exposing (only, screen, withMedia)
import Debug as Dbg
import Dict exposing (Dict)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attrs exposing (..)
import Html.Styled.Keyed as Keyed
import Html.Styled.Lazy exposing (lazy, lazy3)
import StyleGuide as Theme
import Task
import Time


type alias Combinator =
    { letter : String
    , delay : Int
    , initialTime : Int
    , position : ( Float, Float )
    , opacity : Float
    }


type alias Model =
    { totalHeight : Float
    , combinators : List Combinator
    }


type Msg
    = Init (Result Browser.Dom.Error ( Time.Posix, Browser.Dom.Element ))
    | Tick Time.Posix


duration =
    9250


lerp start end norm =
    start + norm * (end - start)


maxOpacity =
    0.65


updateCombinator curTime totalHeight combinator =
    let
        { initialTime, opacity, position, delay } =
            combinator

        ( px, _ ) =
            position

        elapsed =
            Basics.max (modBy duration (curTime - initialTime - delay)) 0

        progress =
            Basics.min ((elapsed |> toFloat) / duration) 1.0
    in
    if progress < 1.0 then
        { combinator
            | opacity = ((lerp -maxOpacity maxOpacity progress |> abs) - maxOpacity) |> abs
            , position = ( px, progress * totalHeight )
        }

    else
        { combinator
            | delay = 0
            , opacity = 0
            , initialTime = curTime
            , position = ( px, 0 )
        }


setInitialTime currentTime ({ initialTime } as comb) =
    { comb | initialTime = currentTime }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        combinators =
            model.combinators
    in
    case msg of
        Init result ->
            case result of
                Result.Ok ( timePosix, { element } ) ->
                    let
                        currentTime =
                            Time.posixToMillis timePosix
                    in
                    ( { model
                        | totalHeight = element.height
                        , combinators = List.map (setInitialTime currentTime) combinators
                      }
                    , Cmd.none
                    )

                Result.Err _ ->
                    ( model, Cmd.none )

        Tick timePosix ->
            let
                currentTime =
                    Time.posixToMillis timePosix

                totalHeight =
                    model.totalHeight
            in
            ( { model
                | combinators = List.map (updateCombinator currentTime totalHeight) combinators
              }
            , Cmd.none
            )


init =
    Task.attempt
        Init
        (Task.map2 (\r -> \t -> ( t, r )) (getElement "combinators") Time.now)


tick =
    Task.perform Tick Time.now



-- Testing


initModel : Model
initModel =
    { totalHeight = 0
    , combinators =
        [ { letter = "I"
          , initialTime = 0
          , delay = 5500
          , position = ( 12, 0 )
          , opacity = 0
          }
        , { letter = "K"
          , initialTime = 0
          , delay = 500
          , position = ( 17, 0 )
          , opacity = 0
          }
        , { letter = "B"
          , initialTime = 0
          , delay = 13500
          , position = ( 23, 0 )
          , opacity = 0
          }
        , { letter = "C"
          , initialTime = 0
          , delay = 8500
          , position = ( 29, 0 )
          , opacity = 0
          }
        , { letter = "W"
          , initialTime = 0
          , delay = 10500
          , position = ( 35, 0 )
          , opacity = 0
          }
        , { letter = "S"
          , initialTime = 0
          , delay = 11500
          , position = ( 64, 0 )
          , opacity = 0
          }
        , { letter = "Y"
          , initialTime = 0
          , delay = 7500
          , position = ( 70, 0 )
          , opacity = 0
          }
        , { letter = "T"
          , initialTime = 0
          , delay = 9000
          , position = ( 76, 0 )
          , opacity = 0
          }
        , { letter = "A"
          , initialTime = 0
          , delay = 14500
          , position = ( 83, 0 )
          , opacity = 0
          }
        , { letter = "P"
          , initialTime = 0
          , delay = 2500
          , position = ( 90, 0 )
          , opacity = 0
          }
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    onAnimationFrame Tick


combinatorKeyed combinator =
    ( combinator.letter, combinatorWrapper combinator )


createPreElement c =
    let
        x =
            Tuple.first c.position
    in
    ( x, combinatorStyled x )


preElements =
    Dict.fromList
        (List.map
            createPreElement
            initModel.combinators
        )


combinatorStyled shiftX =
    styled div
        [ Css.position absolute
        , fontSize (px 36)
        , bottom (px -36)
        , left (pct shiftX)
        , color Theme.color.primary
        , Theme.fontFamily.secondary
        , Theme.breakpoint.tablet [ Theme.textSize.medium ]
        ]


combinatorWrapper { position, letter, opacity, delay } =
    let
        ( x, y ) =
            position

        translateStr =
            "translate3d(0px," ++ String.fromFloat -y ++ "px, 0px)"

        element =
            case Dict.get x preElements of
                Just preElement ->
                    preElement

                Nothing ->
                    combinatorStyled x
    in
    element
        [ style "opacity" (String.fromFloat opacity)
        , style "transform" translateStr
        ]
        [ text letter ]


combinatorsContainer =
    Keyed.node "div"
        [ id "combinators"
        , css
            [ position absolute
            , Css.width (pct 100)
            , Css.height (pct 100)
            ]
        ]


combinatorsBackground : Model -> Html msg
combinatorsBackground model =
    let
        { combinators } =
            model
    in
    combinatorsContainer
        (List.map combinatorKeyed combinators)
