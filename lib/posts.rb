# Retorna o conteúdo do artigo retirando o padrão "<p>RESUMO</p>"
def conteudo_do_artigo(conteudo)
  conteudo.gsub("<p>RESUMO</p>", "")
end

# Retorna um resumo do artigo baseado em todo conteúdo
# antes do padrão "<p>RESUMO</p>"
def resumo_do_artigo(conteudo)
  conteudo.split("<p>RESUMO</p>")[0]
end

# Recebe uma string e tenta convertê-la se possível para uma data
# Seguindo o padrão DD/MM/AAAA
def exibir_data(valor)
  attribute_to_time(valor).strftime("%d/%m/%Y")
end

# A partir dos ítens com o atributo kind: 'article'
# São gerados novos ítens (páginas) contendo os artigos
def paginar_artigos
  artigos_para_paginar = sorted_articles
  grupos_de_artigos = []
  
  until artigos_para_paginar.empty?
    grupos_de_artigos << artigos_para_paginar.slice!(0..@config[:page_size]-1)
  end
  
  novos_itens = []
  grupos_de_artigos.each_with_index do |subartigos, i|
    atributos = {
      :title => "Page #{i}",
      :articles => subartigos,
    }
    novos_itens << Nanoc::Item.new("Artigos #{i}", atributos, "/page/#{i+1}/", {:binary => false} )
  end
  
  novos_itens.each_with_index do |item, i|
    item[:next] = novos_itens[i+1]
    item[:prev] = i == 0 ? nil : novos_itens[i-1]
  end
  
  novos_itens.each do |item|
    @items << item
  end
  
  root = @items.find { |e| e.identifier =~ /index.html/ }
  root[:articles] = grupos_de_artigos[0]
  root[:next] = novos_itens[1]
  
end