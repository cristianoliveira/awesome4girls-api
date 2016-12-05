# frozen_string_literal: true
# This a job worker to sincronize the database with repository
require_relative '../../app'

class SincronizerWorker
  include Sidekiq::Worker

  def perform
    repo = 'cristianoliveira/awesome4girls'
    markdown = GithubClient.from(repo, 'master').request('README.md')
    data = MarkdownParser.to_hash(markdown)

    data.select { |s| s['level'] > 1 }.each do |section|
      if section['level'] == 2
        @section = Section.find_by(title: section['text'])

        unless @section
          @section = Section.create(title: section['text'],
                                    description: section['description'])
        end

      else
        subsection = @section.subsections.find_by(title: section['text'])

        unless subsection
          subsection = @section.subsections.create(
            title: section['text'],
            description: section['description']
          )
        end

        section['items'].each do |item|
          project = subsection.projects.find_by(title: item['link']['text'])

          next if project
          subsection.projects.create(
            title: item['link']['text'],
            description: item['description']
          )
        end
      end
    end
  end
end

# This is an auxiliar way to run this code.
# run it by: `ruby app/workers/syncronizer.rb`
SincronizerWorker.new.perform if __FILE__ == $PROGRAM_NAME
