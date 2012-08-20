require 'fileutils'

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

def renderiza_teste
  render '_facebook_like_button.html'
end