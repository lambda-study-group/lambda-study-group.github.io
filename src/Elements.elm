module Elements exposing (..)

import Css exposing (..)
import Css.Animations as Anim
import Css.Media as Media exposing (only, screen, withMedia)
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
import Svg.Styled exposing (path, svg)
import Svg.Styled.Attributes as SAttr



-- TODO: order the elements  by role
-- TODO: all elements 'styled' must have the name with suffix "Styled"


animFill =
    Anim.property "fill"


animStrokeDash =
    Anim.property "stroke-dashoffset"


lambdaPath =
    path
        [ SAttr.d
            """
            M96.2288 175.903C93.4771 175.656 90.9801 174.95 88.4524 173.706C86.1722
            172.583 83.7337 170.894 82.2695 169.423C78.404 165.538 74.7771 156.848
            71.3677 143.303C70.5909 140.217 70.6454 140.459 65.0711 115.314C59.1808
            88.7429 59.7745 91.3911 59.7072 91.3911C59.679 91.3911 58.9487 92.9947
            58.0843 94.9547C53.2715 105.868 23.4524 173.5 23.3095 173.827L23.1397
            174.216H11.5546C0.554359 174.216 -0.028811 174.21 0.000974841 174.097C0.0182356
            174.032 11.8354 148.556 26.2614 117.483L52.4904 60.986L51.879 57.9313C46.344 
            30.2805 38.3707 17.3861 27.1346 17.9147C24.5923 18.0343 22.4947 18.545 20.3772
            19.5599C16.8106 21.2693 14.0349 24.2964 12.2026 28.4749C10.9769 31.27 10.047
            35.313 9.80621 38.8946C9.78229 39.2503 9.73539 39.5944 9.70198 39.6595C9.64607
            39.7683 9.47173 39.7777 7.51345 39.7777C5.62907 39.7777 5.38094 39.7654 5.34437
            39.67C5.29297 39.5361 5.42786 36.5895 5.56211 34.9136C6.6036 21.9119 10.6542
            11.3301 16.8694 5.37445C19.8707 2.49849 23.3232 0.743773 27.1432 0.152819C28.232
            -0.0156138 30.4887 -0.0521918 31.6269 0.0801439C35.5388 0.534961 38.9592 2.25756
            42.1663 5.38814C44.8003 7.9592 46.9441 11.0496 49.0343 15.2883C51.0227 19.3208
            52.574 23.6106 54.6043 30.6913C57.3609 40.3047 61.1897 56.0816 65.7858 76.765C66.1243
            78.2884 68.3006 88.0132 70.622 98.3757C72.9435 108.738 75.0708 118.254 75.3495
            119.521C78.0345 131.733 80.5405 139.758 83.54 145.748C85.2451 149.154 86.9239
            151.592 88.9544 153.611C91.9745 156.614 95.3501 158.109 99.429 158.25C108.564
            158.566 113.938 152.474 115.473 140.066C115.532 139.583 115.596 139.119 115.613
            139.035L115.646 138.882L117.823 138.899L120 138.917L119.99 140.843C119.947 149.118
            118.533 157.129 116.138 162.663C112.792 170.394 107.436 174.866 100.401 175.805C99.4399
            175.933 97.1579 175.987 96.2288 175.903Z
            """
        , SAttr.fill "#D872E9"
        , SAttr.css
            [ animationName
                (Anim.keyframes
                    [ ( 0, [ animFill "none", animStrokeDash "1000" ] )
                    , ( 80, [ animFill "black" ] )
                    , ( 100, [ animFill "#D872E9", animStrokeDash "0" ] )
                    ]
                )
            , Css.property "stroke-dasharray" "1000"
            , Css.property "animation-duration" "2s"
            , Css.property "animation-timing-function" "ease-in-out"
            , Css.property "stroke" "#D872E9"
            , Css.property "stroke-width" "2px"
            ]
        ]
        []


lambdaSvg width1 width2 =
    svg
        [ SAttr.width "120"
        , SAttr.height "176"
        , SAttr.viewBox "0 -1 120 180"
        , SAttr.css
            [ Css.width (px width1)
            , Css.height auto
            , withMedia
                [ only screen [ Media.maxWidth (px 800) ] ]
                [ Css.width (px width2) ]
            ]
        ]
        [ lambdaPath ]


lambdaLogo : Float -> Float -> Html msg
lambdaLogo width1 width2 =
    img
        [ src "assets/logo.svg"
        , css
            [ Css.width (px width1)
            , withMedia
                [ only screen [ Media.maxWidth (px 800) ] ]
                [ Css.width (px width2) ]
            ]
        ]
        []


lambdaLogoLarge =
    lambdaSvg 120 60


lambdaLogoMedium =
    lambdaSvg 44 18


lambdaLogoSmall =
    lambdaSvg 18 10


contentWrapper =
    styled div
        [ borderPink
        , withMedia
            [ only screen [ Media.maxWidth (px 800) ] ]
            [ Css.borderWidth (px 0) ]
        ]


textStyled =
    styled p
        [ margin (px 0)
        , padding (rem 1.2)
        , textColor
        , font
        ]


spanStyled =
    styled span
        [ textColor, font ]


type HeaderSize
    = Large
    | XLarge


headerSize hsize =
    case hsize of
        Large ->
            batch [ fontSize (px 32) ]

        XLarge ->
            textXLarge


headerSizeSecondary hsize =
    case hsize of
        Large ->
            batch [ fontSize (px 24) ]

        XLarge ->
            batch [ fontSize (px 28) ]


headerTitle : HeaderSize -> String -> Html msg
headerTitle size txt =
    h2
        [ css
            [ textColor
            , padding (px 0)
            , margin2 (rem 1.5) (rem 0)
            , headerSize size
            , font
            , withMedia
                [ only screen [ Media.maxWidth (px 800) ] ]
                [ headerSizeSecondary size ]
            ]
        ]
        [ text txt ]


link color { url, label } =
    a
        [ href url
        , css [ color ]
        ]
        [ text label ]


linkDefault =
    link linkColor


linkText =
    link textColor


icon srcIcon =
    img
        [ src srcIcon
        , css
            [ Css.width (px 24)
            , withMedia
                [ only screen [ Media.maxWidth (px 800) ] ]
                [ Css.width (px 16) ]
            ]
        ]
        []


githubIcon =
    icon "assets/github-feather-icon.svg"



-- Surprise! Don't have telegram icon in the feather icons set. :P


navigationIcon =
    icon "assets/navigation-feather-icon.svg"


repositoryRow repoLinkData =
    div
        [ css
            -- TODO: use the Styles
            [ displayFlex
            , padding2 (rem 1) (rem 0)
            , alignItems center
            ]
        ]
        [ div
            [ css
                -- TODO: Refactor Icon element
                -- TODO: use the StyleGuide
                -- TODO: add an interaction here
                [ paddingRight (rem 3)
                , withMedia
                    [ only screen [ Media.maxWidth (px 800) ] ]
                    [ paddingRight (rem 1.5) ]
                ]
            ]
            [ githubIcon ]
        , div []
            -- TODO: transform the link* in a styled element
            [ spanStyled
                [ css
                    [ textMedium
                    , withMedia
                        [ only screen [ Media.maxWidth (px 800) ] ]
                        [ fontSize (rem 1.5) ]
                    ]
                ]
                [ linkText repoLinkData ]
            ]
        ]



-- TODO: split this element, plz


repositoryContainer { title, content } =
    div
        [ css
            [ padding2 (rem 4) (rem 0)
            , withMedia
                [ only screen [ Media.maxWidth (px 800) ] ]
                [ Css.maxWidth (pct 100) ]
            ]
        ]
        -- TODO: add an interation here
        [ contentWrapper
            [ css
                [ display inlineBlock
                , padding2 (rem 1) (rem 2)
                , backgroundStyle
                , marginBottom (rem -2)
                ]
            ]
            [ spanStyled
                [ css
                    [ textLarge
                    , withMedia
                        [ only screen [ Media.maxWidth (px 800) ] ]
                        [ textMedium ]
                    ]
                ]
                [ text title ]
            ]
        , contentWrapper
            [ css
                [ Css.width (px 490)
                , padding3 (rem 3.5) (rem 3) (rem 3)
                , marginLeft (rem 2)
                , withMedia
                    [ only screen [ Media.maxWidth (px 800) ] ]
                    [ Css.maxWidth (pct 100), padding3 (rem 1.5) (rem 2) (rem 1), marginLeft (rem 0) ]
                ]
            ]
            (List.map repositoryRow content)
        ]


languageWrapper ({ label, rot } as lang) =
    let
        ( tx, ty ) =
            lang.translate
    in
    div
        [ css
            [ color Theme.colors.language
            , transforms
                [ rotate (deg rot)
                , scale lang.scale
                , translate2 (px tx) (px ty)
                ]
            , textLarge
            , Styles.font
            ]
        ]
        [ text label ]
