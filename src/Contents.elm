module Contents exposing (..)

-- Todo
-- Fix typos


title =
    "Lambda study group!"


description =
    """
    O intuito do grupo é a participação coletiva de todos e o aprendizado de
    cada um. No grupo do telegram você pode tirar dúvidas, sugerir projetos e
    conversar sobre temas relacionados à programação funcional. Para praticar
    temos alguns repositórios em que você pode resolver alguns exercicios.
    """


invite =
    "Entre no nosso grupo do "


telegramLinkData =
    { url = "https://t.me/lambdastudygroup"
    , label = "Telegram"
    }


githubLinkData =
    { url = "https://github.com/lambda-study-group"
    , label = "GitHub"
    }


languages =
    ( [ { label = "OCaml"
        , rot = 15
        , scale = 1
        , translate = ( 0, -5 )
        , url = "https://ocaml.org/"
        }
      , { label = "SML"
        , rot = -15
        , scale = 1.3
        , translate = ( -30, 15 )
        , url = "https://en.wikipedia.org/wiki/Standard_ML"
        }
      , { label = "Erlang"
        , rot = -5
        , scale = 1.2
        , translate = ( -30, 15 )
        , url = "https://www.erlang.org/"
        }
      , { label = "F#"
        , rot = -2
        , scale = 1.4
        , translate = ( -20, -5 )
        , url = "https://fsharp.org/"
        }
      , { label = "Elixir"
        , rot = 10
        , scale = 1.3
        , translate = ( -20, 20 )
        , url = "https://elixir-lang.org/"
        }
      ]
    , [ { label = "Clojure"
        , rot = -7
        , scale = 1.18
        , translate = ( 10, 0 )
        , url = "https://clojure.org/"
        }
      , { label = "Elm"
        , rot = 15
        , scale = 1.4
        , translate = ( 10, 10 )
        , url = "https://elm-lang.org/"
        }
      , { label = "Scala"
        , rot = -20
        , scale = 1.2
        , translate = ( 10, 0 )
        , url = "https://www.scala-lang.org/"
        }
      , { label = "Scheme"
        , rot = -4
        , scale = 1.3
        , translate = ( -30, 20 )
        , url = "https://en.wikipedia.org/wiki/Scheme_(programming_language)"
        }
      , { label = "Haskell"
        , rot = 10
        , scale = 1.5
        , translate = ( -20, 15 )
        , url = "https://www.haskell.org/"
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
          , "Juntar conteúdo acadêmico e prático de várias linguagens em um awesome"
          ]
        , [ "https://github.com/lambda-study-group/dicionario-termos-funcionais"
          , "Dicionário de tradução de termos funcionais"
          ]
        , [ "https://github.com/lava-jato-the-game/lava_jato"
          , "Desenvolvimento do jogo da Lava Jato com Phoenix(Absinthe) / ClojureScript"
          ]
        ]
    }


exercices =
    { title = "Resolução de Exercícios"
    , content =
        [ [ "https://github.com/lambda-study-group/desafios"
          , "Desafios"
          ]
        , [ "https://github.com/lambda-study-group/sicp"
          , "Exercícios do livro SICP em várias linguagens diferentes"
          ]
        , [ "https://github.com/lambda-study-group/hacker-rank"
          , "Exercícios da trilha de programação funcional do HackerRank"
          ]
        , [ "https://github.com/lambda-study-group/exercism"
          , "Exercícios de linguagens funcionais no Exercism"
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
