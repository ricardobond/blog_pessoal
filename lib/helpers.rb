require 'fileutils'

def copia_static
  FileUtils.cp_r 'static/.', 'output/static/'
end