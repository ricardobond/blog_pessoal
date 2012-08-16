# Template de blog usando nanoc

[nanoc3](http://nanoc.stoneship.org/) blog starter kit. Sob a licença FreeBSD.

## Instalação

Utilizando o terminal:

    % gem install bundler
    % git clone git://github.com/mgutz/nanoc3_blog.git your_blog
    % cd your_blog
    % bundle install

## Visualizando o blog.

Compilando o blog.

    # compila todos os arquivos sob o diretório content/* e copia todos sob static/* para o diretório output/
    % nanoc compile

    # roda o servidor de preview com suporte à autocompilação por requisição (Basta dar refresh na página para seu código ser recompilado)
    % nanoc autocompile

Visualize seu blog em `http://localhost:3000`

## Adicionando Conteúdo

Edit the Markdown file created by running this command:

    # Gera um post novo
    % rake criar:artigo title='Hello world'

Visualize seu post após compilar o site.


### Adicionando Arquivos estáticos

Coloque os arquivos estáticos no diretório `static/`. `static/*` será copiado para o diretório `output/` após a compilação.


## Configuração

Edite os seguintes arquivos:

    config.yaml
    atom.xml.haml

### Comentários

DISQUS permite que usuários possam fazer comentários em seu blog estático! Registre-se [DISQUS](http://disqus.com) para usar o serviço. Você precisa inserir o shortname do seu blog cadastrado no DISQUS em `disqus_shortname` no arquivo `config.yaml`.
Para desabilitar o recurso é só comentar a linha `disqus_shortname` no mesmo arquivo.


## Deploy

Copie tudo que está no diretório `output/*` para o folder público do seu repositório.

## Convenções

Os posts gerados a partir do comando `rake criar:post title="Título do post"` são organizados automaticamente em diretórios baseado na data em que o post foi gerado.

    # e.x.: Estes arquivos vão para o mesmo diretório /output
    # Data do sistema de exemplo: 22/08/2012
    %rake criar:post title='Meu primeiro post' #=> /posts/2012/08/Meu-primeiro-post.html.haml
    

Arquivos podem utilizar facilmente a convenção de nomes do framework Rails! A primeira parte da extensão é mantida no arquivo final, a segunda parte determina o template compilador do arquivo.

    sitemap.xml.haml #=> generate sitemap.xml usando o processador HAML!

Se uma extensão simples for utilizada, então assume-se que são arquivos CSS e HTML simples!

    .less #=> .css
    .* #=> .html