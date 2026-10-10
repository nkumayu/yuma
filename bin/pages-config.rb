# frozen_string_literal: true

require 'yaml'

# Build-time overrides support both username.github.io and project repositories.
# Set GITHUB_PAGES_URL only when using a custom domain (see docs/DEPLOYMENT.md).
owner, repository = ENV.fetch('PAGES_REPOSITORY').split('/', 2)
abort 'PAGES_REPOSITORY must be owner/repository' unless owner && repository
url = ENV.fetch('GITHUB_PAGES_URL', "https://#{owner}.github.io")
baseurl = if ENV['GITHUB_PAGES_URL'] || repository.downcase == "#{owner.downcase}.github.io"
            ''
          else
            "/#{repository}"
          end
File.write(ARGV.fetch(0, '_config.pages.yml'), { 'url' => url, 'baseurl' => baseurl }.to_yaml)
puts "Pages URL: #{url}#{baseurl}/"
