require 'fileutils'

def copia_static
  FileUtils.cp_r 'static/.', 'output/static/'
end

# Gera arquivos meta para css baseados no filtro
def css_meta(filtro = "less")
  nome_do_arquivo = ""
  meta_css = []
  meta_css_final = ""
  @items.each do |i|
    if i[:extension] == filtro
      nome_do_arquivo = i[:filename].sub("content/less/", "").sub(filtro, "css") if i[:extension] == filtro
      if nome_do_arquivo[0] != "_"
        meta_css << nome_do_arquivo
      end
    end
  end
  meta_css.each do |meta|
    meta_css_final << "<link rel='stylesheet' href='#{@config[:css_dir]}#{meta}' media='screen' rel='stylesheet' type='text/css' />\n"
  end
  return meta_css_final
end