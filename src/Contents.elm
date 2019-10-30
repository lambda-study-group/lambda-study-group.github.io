module Contents exposing (..)

-- Todo
-- Fix typos


title =
    "Lambda study group!"


description =
    """
    O intuito do grupo é a participação coletiva de todos e o aprendizado de
    cada um. No grupo do telegram você pode tirar duvidas, sugerir projetos e
    conversar sobre temas relacionados a programação funcional Para praticar
    temos alguns repositórios em que você pode resolver alguns exercicios.
    """


invite =
    "Entre no nosso grupo do "


telegramLinkData =
    { url = "https://t.me/lambdastudygroup"
    , label = "Telegram"
    }


githubLinkData =
    { url = "https://github.com/lambda-study-group/telegram-bot"
    , label = "GitHub"
    }


languages =
    ( [ { label = "OCaml"
        , rot = 15
        , scale = 1
        , translate = ( 0, -5 )
        }
      , { label = "SML"
        , rot = -15
        , scale = 1.3
        , translate = ( -30, 15 )
        }
      , { label = "Erlang"
        , rot = -5
        , scale = 1.2
        , translate = ( -30, 15 )
        }
      , { label = "F#"
        , rot = -2
        , scale = 1.4
        , translate = ( -20, -5 )
        }
      , { label = "Elixir"
        , rot = 10
        , scale = 1.3
        , translate = ( -20, 20 )
        }
      ]
    , [ { label = "Clojure"
        , rot = -7
        , scale = 1.18
        , translate = ( 10, 0 )
        }
      , { label = "Elm"
        , rot = 15
        , scale = 1.4
        , translate = ( 10, 10 )
        }
      , { label = "Scala"
        , rot = -20
        , scale = 1.2
        , translate = ( 10, 0 )
        }
      , { label = "Scheme"
        , rot = -4
        , scale = 1.3
        , translate = ( -30, 20 )
        }
      , { label = "Haskell"
        , rot = 10
        , scale = 1.5
        , translate = ( -20, 15 )
        }
      ]
    )


projects =
    { title = "Projetos Atuais"
    , content =
        [ [ "https://github.com/lambda-study-group/telegram-bot"
          , "Telegram Bot"
          ]
        , [ "https://github.com/lambda-study-group/awesome-functional-studies"
          , "Juntar conteudo academico e pratico de várias linguagens em um awesome"
          ]
        , [ "https://github.com/lambda-study-group/dicionario-termos-funcionais"
          , "Dicionario de tradução de termos funcionais"
          ]
        , [ "https://github.com/lava-jato-the-game/lava_jato"
          , "Desenvolvimento do jogo da Lava Jato com Phoenix(Absinthe) / ClojureScript"
          ]
        ]
    }


exercices =
    { title = "Resolução de Exercicios"
    , content =
        [ [ "https://github.com/lambda-study-group/desafios"
          , "Desafios"
          ]
        , [ "https://github.com/lambda-study-group/sicp"
          , "Exercicios do livro SICP em várias linguagens diferentes"
          ]
        , [ "https://github.com/lambda-study-group/hacker-rank"
          , "Exercicios da trilha de programação funcional do HackerRank"
          ]
        , [ "https://github.com/lambda-study-group/exercism"
          , "Exercicios de linguagens funcionais no Exercism"
          ]
        ]
    }


translations =
    { title = "Traduções"
    , content =
        [ [ "https://github.com/lambda-study-group/Functional-Light-JS"
          , "Tradução do Functional Light Programming"
          ]
        ]
    }


toLinkData list =
    case list of
        [ url, label ] ->
            { url = url, label = label }

        _ ->
            { url = "", label = "" }


convertRepository ({ content } as data) =
    { title = data.title, content = List.map toLinkData content }


repositories =
    List.map convertRepository [ projects, exercices, translations ]
