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
import Html.Styled.Keyed as Keyed
import Html.Styled.Lazy exposing (lazy)
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
    , position : ( Float, Float )
    , rotate : Float
    , transition : Bool
    , opacity : Float
    }


type alias Model =
    { initialTime : Int
    , curCombinator : Combinator
    , preCombinator : Combinator
    , combinators : List Combinator
    }


type Msg
    = Tick Time.Posix


duration =
    3250


ease t =
    let
        x =
            t - 1
    in
    x * x * x + 1


lerp start end norm =
    start + norm * (end - start)


updateCombinators curTime model next others =
    let
        { curCombinator, initialTime, preCombinator } =
            model

        elapsed =
            curTime - initialTime

        progress =
            Basics.min ((elapsed |> toFloat) / duration |> ease) 1.0
    in
    if progress < 1.0 then
        { model
            | curCombinator = { curCombinator | opacity = lerp 0.2 1 progress }
            , preCombinator = { preCombinator | opacity = lerp 1 0.2 progress }
            , combinators = { next | opacity = lerp 1 0.4 progress } :: others
        }

    else
        { model
            | curCombinator =
                { next
                    | opacity = 0.4
                    , transition = True
                }
            , preCombinator = { curCombinator | opacity = 1, transition = True }
            , combinators = others ++ [ { preCombinator | opacity = 1, transition = False } ]
            , initialTime = curTime
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
    , curCombinator =
        { letter = "I"
        , position = ( 25, 10 )
        , transition = True
        , rotate = 10
        , opacity = 0.3
        }
    , preCombinator =
        { letter = "K"
        , position = ( 85, 40 )
        , transition = True
        , rotate = 10
        , opacity = 1
        }
    , combinators =
        [ { letter = "B"
          , position = ( 10, 40 )
          , transition = False
          , rotate = -3
          , opacity = 1
          }
        , { letter = "C"
          , position = ( 80, 15 )
          , transition = False
          , rotate = 25
          , opacity = 1
          }
        , { letter = "W"
          , position = ( 15, 80 )
          , transition = False
          , rotate = -2
          , opacity = 1
          }
        , { letter = "S"
          , position = ( 70, 10 )
          , transition = False
          , rotate = -3
          , opacity = 1
          }
        , { letter = "Y"
          , position = ( 15, 15 )
          , transition = False
          , rotate = -4
          , opacity = 1
          }
        , { letter = "T"
          , position = ( 80, 80 )
          , transition = False
          , rotate = 4
          , opacity = 1
          }
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    onAnimationFrame Tick


combinatorKeyed combinator =
    ( combinator.letter, lazy combinatorWrapper combinator )


combinatorWrapper { position, rotate, letter, opacity, transition } =
    let
        ( x, y ) =
            position

        curColor =
            if transition == True then
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
            , fontSize (px 48)
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
        { combinators, curCombinator, preCombinator } =
            model
    in
    Keyed.node "div"
        [ css
            [ position absolute
            , Css.width (pct 100)
            , Css.height (pct 100)
            ]
        ]
        (List.map
            combinatorKeyed
            (curCombinator :: preCombinator :: combinators)
        )
