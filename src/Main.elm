module Main exposing (..)

import Contents
import Css exposing (..)
import Css.Global exposing (body, global)
import Elements
    exposing
        ( HeaderSize(..)
        , contentWrapper
        , githubIcon
        , headerTitle
        , lambdaLogoLarge
        , lambdaLogoMedium
        , linkDefault
        , linkText
        , navigationIcon
        , repositoryContainer
        , spanStyled
        , textStyled
        )
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import StyleGuide as Theme
import Styles exposing (backgroundStyle, paddingLarge, textMedium)


globalCss =
    global
        [ body
            [ padding (px 0)
            , margin (px 0)
            , backgroundStyle
            ]
        ]


lambdaTitleXLarge =
    headerTitle XLarge Contents.title


lambdaTitleLarge =
    headerTitle Large Contents.title


lambdaSeparator =
    div
        [ css
            [ Css.width (px 120)
            , backgroundColor Theme.colors.pink
            , Css.height (px 4)
            , margin3 (rem 1.5) (rem 0) (rem 3)
            ]
        ]
        []


homeParagraph =
    styled textStyled [ textMedium, textAlign center ]


lambdaDescription =
    contentWrapper [ css [ paddingLarge ] ]
        [ homeParagraph []
            [ text Contents.description ]
        , homeParagraph []
            [ text Contents.invite
            , linkDefault Contents.telegramLinkData
            , text "."
            ]
        ]


homeSection =
    section
        [ css
            [ displayFlex
            , justifyContent center
            , flexDirection column
            , alignItems center
            , padding3 (rem 6) (rem 0) (rem 0)
            , maxWidth (px 720)
            , boxSizing borderBox
            , margin auto
            ]
        ]
        [ lambdaLogoLarge
        , lambdaTitleXLarge
        , lambdaSeparator
        , lambdaDescription
        ]


languagesSection =
    section
        [ css [ Css.height (rem 8) ] ]
        []


repositoriesList =
    List.map repositoryContainer Contents.repositories


repositoriesSection =
    section
        [ css
            [ displayFlex
            , flexWrap Css.wrap
            , justifyContent spaceAround
            ]
        ]
        repositoriesList


footerLinksData =
    [ { icon = navigationIcon
      , link = Contents.telegramLinkData
      }
    , { icon = githubIcon
      , link = Contents.githubLinkData
      }
    ]


footerLink { icon, link } =
    div [ css [ displayFlex, padding3 (rem 2) (rem 1) (rem 0) ] ]
        [ icon
        , div [ css [ paddingLeft (rem 1.5) ] ]
            [ spanStyled [ css [ textMedium ] ]
                [ linkText link ]
            ]
        ]


lambdaFooter =
    footer
        [ css
            [ -- TODO: create some styles for flex*
              displayFlex
            , flexDirection column
            , alignItems center
            , justifyContent center
            , padding2 (rem 3) (rem 0)
            , backgroundColor Theme.colors.footer
            ]
        ]
        -- Split this elements
        [ div [ css [ displayFlex ] ]
            [ lambdaLogoMedium
            , div [ css [ paddingLeft (rem 2) ] ] [ lambdaTitleLarge ]
            ]
        , div [ css [ displayFlex, justifyContent spaceAround ] ]
            (List.map
                footerLink
                footerLinksData
            )
        ]


view =
    div
        []
        [ globalCss
        , homeSection
        , languagesSection
        , repositoriesSection
        , lambdaFooter
        ]


main =
    toUnstyled view
