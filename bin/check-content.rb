# frozen_string_literal: true

require 'yaml'

config = YAML.safe_load_file('_config.yml')
cv = YAML.safe_load_file('_data/cv.yml').fetch('cv')
socials = YAML.safe_load_file('_data/socials.yml')
abort 'CV and contact emails disagree' unless cv['email'] == socials['email']
abort 'Site and CV names disagree' unless cv['name'].start_with?([config['first_name'], config['last_name']].join(' '))
abort 'Invalid email' unless socials['email'].match?(/\A[^\s@]+@[^\s@]+\.[^\s@]+\z/)

routes = { 'about' => '/', 'research' => '/research/', 'publications' => '/publications/', 'cv' => '/cv/', 'contact' => '/contact/' }
routes.each do |name, route|
  source = File.read("_pages/#{name}.md")
  front = YAML.safe_load(source.split(/^---\s*$\n?/)[1])
  abort "Wrong permalink for #{name}" unless front['permalink'] == route
end

gem_plugins = File.read('Gemfile').split('group :jekyll_plugins do', 2).last.scan(/gem '([^']+)'/).flatten
configured_plugins = config.fetch('plugins').map { |name| name == 'jekyll/scholar' ? 'jekyll-scholar' : name }
abort 'Gemfile / _config.yml plugin lists disagree' unless gem_plugins.sort == configured_plugins.sort
abort 'Photograph missing' unless File.exist?('assets/img/profile-portrait.jpg')
abort 'Bibliography missing' unless File.exist?('_bibliography/papers.bib')
puts 'Content OK: identity, contact, five routes, plugin activation, photograph, bibliography.'
