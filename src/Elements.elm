module Elements exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attrs exposing (..)
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


lambdaLogo : Int -> Html msg
lambdaLogo width =
    img [ src "assets/logo.svg", Attrs.width width ] []


lambdaLogoLarge =
    lambdaLogo 120


lambdaLogoMedium =
    lambdaLogo 44


contentWrapper =
    styled div
        [ borderPink ]


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


headerTitle : HeaderSize -> String -> Html msg
headerTitle size txt =
    h2
        [ css
            [ textColor
            , padding (px 0)
            , margin2 (rem 1.5) (rem 0)
            , headerSize size
            , font
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
    img [ src srcIcon, Attrs.width 24 ] []


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
                ]
            ]
            [ githubIcon ]
        , div []
            -- TODO: transform the link* in a styled element
            [ spanStyled [ css [ textMedium ] ] [ linkText repoLinkData ]
            ]
        ]



-- TODO: split this element, plz


repositoryContainer { title, content } =
    div [ css [ padding2 (rem 4) (rem 0) ] ]
        -- TODO: add an interation here
        [ contentWrapper
            [ css
                [ display inlineBlock
                , padding2 (rem 1) (rem 2)
                , backgroundStyle
                , marginBottom (rem -2)
                ]
            ]
            [ spanStyled [ css [ textLarge ] ] [ text title ] ]
        , contentWrapper
            [ css
                [ Css.width (px 490)
                , padding3 (rem 3.5) (rem 3) (rem 3)
                , marginLeft (rem 2)
                ]
            ]
            (List.map repositoryRow content)
        ]
