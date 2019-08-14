# Desafio Zag - Crawler

Web crawler que percorre e armazena todos os links e assets de um domínio.

Ruby 2.0+

## Dependências 

    gem nokogiri


## Configuração

    $ bundle install

## Uso

    $ ruby crawler.rb http://www.dominio.com.br


## Saída


     Saída via stdout do resultado

     Geração arquivo JSON com resultado: response_crawler.json

Uma lista de adjacências estendida em JSON. O objeto de nível superior é uma matriz, cada filho é um objeto que representa uma página. Cada página tem uma matriz de Links, CSS, JS e Imagens:

    [
      {
        "page": "https://www.zagapp.com.br/fazer-parte-do-zag",
        "links": [
          "https://www.zagapp.com.br/",
          "https://www.zagapp.com.br/recomendar"
        ],
        "css": [
          "https://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700|Montserrat:400,700"
        ],
        "js": [
          "/assets/home/index-ba7dc034c62773b34dd5cc2c06133289c.js",
          "https://www.googletagmanager.com/gtag/js?id=AW-866617796"
        ],
        "images": [
          "/assets/signup/iphone_three_app-21ffe1b23ac5a7358304f4231ade767.png"
        ]
      }
      // ...
    ]

## Comportamento

- Restrito a um único domínio
- Não segue links externos
- Não segue links de subdomínio
- Dado um URL inicial, ele exibe um sitemap (em JSON, veja acima)
- Mapa do site mostra de que assets uma página depende
- Mapa do site mostra links entre páginas
- Saída via stdout do resultado
- Geração arquivo JSON com resultado - `response_crawler.json`
