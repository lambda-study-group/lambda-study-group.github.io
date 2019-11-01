# (λstudy.group)

<p align="center">
  <img src="assets/logo.svg" width="200px" alt="Logo do grupo de estudos">
</p>

:notebook: :pencil2: Repositório do grupo de estudos sobre programação funcional do [Telegram](https://t.me/lambdastudygroup).

## :grey_question: Como funciona

O intuito do grupo é a participação coletiva de todos e o aprendizado de cada um.
No grupo do telegram você pode tirar dúvidas, sugerir projetos e conversar sobre temas relacionados a programação funcional
Para praticar temos alguns repositórios em que você pode resolver alguns exercícios.

## :bulb: Projetos atuais

 - [Telegram Bot](https://github.com/lambda-study-group/telegram-bot)
 - [Juntar conteúdo acadêmico e prético de várias linguagens em um awesome](https://github.com/lambda-study-group/awesome-functional-studies)
 - [Dicionério de tradução de termos funcionais](https://github.com/lambda-study-group/dicionario-termos-funcionais)
 - [Desenvolvimento do jogo da Lava Jato com Phoenix(Absinthe) / ClojureScript](https://github.com/lava-jato-the-game/lava_jato)

### Resolução de Exercícios

 - [Desafios Semanais](https://github.com/lambda-study-group/desafios)
 - [Exercicios do livro SICP em várias linguagens diferentes](https://github.com/lambda-study-group/sicp)
 - [Exercícios da trilha de programação funcional do HackerRank](https://github.com/lambda-study-group/hacker-rank)
 - [Exercícios de linguagens funcionais no Exercism](https://github.com/lambda-study-group/exercism)

### Traduções
- [Tradução do Functional Light Programming](https://github.com/lambda-study-group/Functional-Light-JS)

## :gun: Regras do grupão

- Bom senso
- Intolerância não será tolerada
- Sem spam. Pode postar evento, post etc desde que tenha relação com o grupo
- Podemos bater papo sobre coisas da vida mas se for muito nada a ver apagaremos

## Contribuindo na landing page desse repo

A landing page é feita em elm@0.19.0, para isso você precisa instalar pelo terminal:
```bash
# pela npm
npm install -g elm@0.19.0

# pelo yarn
yarn global add elm@0.19.0
```

Ou por links do windows e mac [aqui](https://guide.elm-lang.org/install.html)

Para contribuir basta mexer no Main.elm e rodar esse comando para gerar um elm.js pimpão:
```bash
elm make src/Main.elm --optimize --output elm.js
```

Você pode usar os scripts abaixo também...

### Scripts com `npm`

Oh, temos um `package.json` no repo :trollface:, calma só há 3 dependências.

Você pode usar o `npm` para executar alguns scripts úteis:

### `npm install`
> Instala as dependências (elm, elm-live, uglify)

### `npm run start`
> Compila e serve a aplicação em modo DEV, usando o [elm-live](https://github.com/wking-io/elm-live)

### `npm run elm:build`
> Só compila o projeto

### `npm run build`
> Compila e depois minifica o bundle com uglify

