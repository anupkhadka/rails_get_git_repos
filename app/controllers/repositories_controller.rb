class RepositoriesController < ApplicationController

  def search
  end

  def github_search
    begin
      @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
        req.params['client_id'] = '4a0f601454f28b13cdc3'
        req.params['client_secret'] = '5dea22f4e83342f7c260d0cfe81c18ee43ddce77'
        req.params['q'] = params[:query]
      end

      body = JSON.parse(@resp.body)
      @repos = body["items"]
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

end
