# encoding: UTF-8

require "rubygems"
require "bundler/setup"
require "nanoc"
require "nanoc/cli"
require "fileutils"

desc "Limpa o diretório output deletando todos os arquivos"
task :clear do
  if File.exists?('output')
    FileUtils.rm_r 'output/'
    puts "Diretório 'output' removido com sucesso!"
  else
    puts "Diretório 'output' não existe!"
  end
end

desc "Executa um webserver aguardando por atualizações"
task :server do
  Nanoc::CLI.run ["autocompile"]
end

desc "Compila o código fonte"
task :build do
  Nanoc::CLI.run ["compile"]
end

desc "Gera json de dados do github"
task  :github do
  require "octokit"
  require "yajl"
  dados = []
  Octokit.repositories("ricardobond").each do |repositorio|
    dados.push({
      :name => repositorio.name,
      :description => repositorio.description,
      :language => repositorio.language,
      :forks => repositorio.forks,
      :watchers => repositorio.watchers,
      :url => repositorio.url,
      :updated_at => repositorio.updated_at
    })
  end
  json = Yajl::Encoder.encode(data)
  File.open('data/github.json', 'w') do |arquivo|
    arquivo.write(json)
  end
end

namespace :criar do
  
  desc "Gera um template de artigo baseado na data do sistema"
  task :artigo do
    @ymd = Time.now.strftime("%Y/%m/%d")
    dir = @ymd[0..6] # me retorna apenas o ano e o mês da data ex.: 2012/08/
    
    if !ENV['title']
      $stderr.puts "\t[erro] Faltando argumento title.\n\texemplo: rake criar:artigo title='titulo do artigo'"
      exit 1
    end
    
    title =  ENV['title'].gsub(" ", "-")
    path, nome_do_arquivo, full_path = calcula_paths(title)
    
    if File.exists?(full_path)
      puts "Arquivo #{full_path} já existe!"
      exit 1
    end
    
    template_de_artigo = <<EOF
---
created_at: #{@ymd}
excerpt: 
kind: article
publish: true
tags: [misc]
title: "#{title.gsub("-", " ")}"
---

    TODO: Adicionar conteúdo em `#{full_path}.`
EOF
    
    FileUtils.mkdir_p(path) if !File.exists?(path)
    File.open(full_path, 'w') { |f| f.write(template_de_artigo) }
    puts "Arquivo #{full_path} criado com sucesso!"
    
  end
  
  def calcula_paths(titulo)
    path = "content/posts/" + @ymd[0..7]
    nome_do_arquivo = titulo.downcase + ".md"
    [path, nome_do_arquivo, path + nome_do_arquivo]
  end
  
end