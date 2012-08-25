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

def mostrar_nuvem_de_tags
  tamanhos_de_tags = calcula_tamanhos(qtde_de_valores_de_tags)
  teste = [1,2,3]
end

def nuvem_de_tags
  tags = colecao_de_tags
  hash = Hash.new(0)
  final = []
  quantidades = []
  tags.each do |tag|
    hash[tag] += 1
  end
  hash.sort_by { |tag_name, tag_qtde| tag_qtde }
  hash.each do |key, value|
    final << {:tag => key, :qtde => value}
    quantidades << value
  end
  final.sort_by {|key| key[:qtde] }
  quantidades.uniq!.reverse!
  tamanhos = calcula_tamanhos(quantidades.size)
  tam_vs_qtde = {}
  quantidades.each_with_index { |k,i| tam_vs_qtde[k] = tamanhos[i] }
  #return tam_vs_qtde
  final.each do |e|
    e[:tam] = tam_vs_qtde.fetch(e[:qtde])
  end
  return final
end

def calcula_tamanhos(qtde_de_tags_unicas = 4, tam_inicial = 1.00, tam_final = 3.00)
  # PA
  razao = (tam_final - tam_inicial) / (qtde_de_tags_unicas - 1)
  
  numeros = []
  (qtde_de_tags_unicas - 1).times do |i|
    if numeros.empty?
      numeros << format("%.2f",tam_inicial)
    end
    numeros << format("%.2f",tam_inicial + (i+=1)*razao)
  end
  return numeros
end

def colecao_de_tags
  tags_coletadas = []
  artigos = sorted_articles
  artigos.each do |artigo|
    tags_coletadas.concat artigo[:tags]
  end
  return tags_coletadas
end