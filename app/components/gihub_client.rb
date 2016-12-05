# frozen_string_literal: true
class GithubClient
  def initialize(repo, branch)
    @repo = repo
    @branch = branch
  end

  def request(file)
    uri = URI("https://raw.githubusercontent.com/#{@repo}/#{@branch}/#{file}")
    markdown = Net::HTTP.get uri
    markdown.force_encoding(Encoding::UTF_8).scrub('�')
  end

  def self.from(repo, branch)
    GithubClient.new repo, branch
  end
end
