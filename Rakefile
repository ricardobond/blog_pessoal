require "rubygems"
require "bundler/setup"
require "nanoc"
require "nanoc/cli"

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