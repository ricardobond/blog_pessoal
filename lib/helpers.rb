require 'fileutils'
require 'bitly'

BITLY_USER = "o_2lgho3gh30"
BITLY_API_KEY = "R_139276d28fcb82fcc533f407dc2e9ce1"

def copia_static
  FileUtils.cp_r 'static/.', 'output/static/'
end

# Gera arquivos meta para css baseados na extensão do filtro (ex.: sass, less...)
def load_style_links(filtro = "less")
  nome_do_arquivo = ""
  meta_css_final = ""
  @items.each do |i|
    if i[:extension] == filtro
      nome_do_arquivo = i[:filename].sub("content/less/", "").sub(filtro, "css")
      if !nome_do_arquivo.start_with?("_")
        meta_css_final << "<link rel='stylesheet' href='#{@config[:css_dir]}#{nome_do_arquivo}' media='screen' rel='stylesheet' type='text/css' />\n"
      end
    end
  end
  return meta_css_final
end

def encurtar_url(url_longa = 'http://www.google.com/', opcoes = {}, 
  bitly = Bitly.new(BITLY_USER, BITLY_API_KEY))
  url = bitly.shorten(url_longa)
  return url.short_url
end