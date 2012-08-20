# Retorna o conteúdo do artigo retirando o padrão "<p>RESUMO</p>"
def conteudo_do_artigo(conteudo)
  conteudo.gsub("<p>RESUMO</p>", "")
end

# Retorna um resumo do artigo baseado em todo conteúdo
# antes do padrão "<p>RESUMO</p>"
def resumo_do_artigo(conteudo)
  conteudo.split("<p>RESUMO</p>")[0]
end