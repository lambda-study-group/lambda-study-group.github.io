module Elements exposing (..)

import Css exposing (..)
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



-- TODO: order the elements  by role
-- TODO: all elements 'styled' must have the name with suffix "Styled"


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
    lambdaLogo 120 60


lambdaLogoMedium =
    lambdaLogo 44 18


lambdaLogoSmall =
    lambdaLogo 18 10


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
