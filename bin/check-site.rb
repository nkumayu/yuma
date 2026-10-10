# frozen_string_literal: true

require 'nokogiri'
require 'pathname'
require 'uri'

destination = File.expand_path(ARGV.fetch(0, '_site'))
baseurl = ARGV.fetch(1, '')
if baseurl.empty? && File.exist?('_config.pages.yml')
  require 'yaml'
  baseurl = YAML.safe_load_file('_config.pages.yml').fetch('baseurl', '')
end
expected = %w[index.html research/index.html publications/index.html cv/index.html contact/index.html 404.html]
errors = []
expected.each do |path|
  errors << "Missing page: #{path}" unless File.file?(File.join(destination, path))
end

Dir.glob(File.join(destination, '**', '*.html')).each do |file|
  document = Nokogiri::HTML(File.read(file))
  errors << "Missing English language: #{file}" unless document.at_css('html')&.[]('lang') == 'en'
  errors << "Missing responsive viewport: #{file}" unless document.at_css('meta[name="viewport"]')
  errors << "Unrendered Liquid: #{file}" if File.read(file).match?(/\{%|\{\{/)
  document.css('[href], [src]').each do |element|
    value = element['href'] || element['src']
    next if value.nil? || value.empty? || value.start_with?('#', '//') || value.match?(/\A[a-z][a-z0-9+.-]*:/i)

    path = URI::DEFAULT_PARSER.unescape(value.split(/[?#]/, 2).first)
    if path.start_with?('/')
      if !baseurl.empty? && path != baseurl && !path.start_with?("#{baseurl}/")
        errors << "Link omits project prefix #{baseurl}: #{value} in #{file}"
        next
      end
      path = path.delete_prefix(baseurl).delete_prefix('/')
      target = File.expand_path(path, destination)
    else
      target = File.expand_path(path, File.dirname(file))
    end
    target = File.join(target, 'index.html') if File.directory?(target)
    errors << "Broken local link: #{value} in #{file}" unless File.file?(target)
  end
end
abort errors.uniq.join("\n") unless errors.empty?
puts "Generated site OK: six pages, English metadata, mobile viewport, rendered Liquid, local links (baseurl=#{baseurl.inspect})."
