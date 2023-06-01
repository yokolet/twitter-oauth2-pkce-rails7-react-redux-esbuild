require 'faraday'

CODE_VERIFIER='omjCvT2xQpr0LAznzCNMHDdQ7neFv5jq29LkMZHN0MQPmfXqVs48eDjVg3u0ov3U'
CLIENT_URL='http://localhost:3000'

class OauthController < ApplicationController
  def twitter
    puts("params: #{params}")
    client_id = Rails.application.credentials.twitter.client_id.strip
    client_secret = Rails.application.credentials.twitter.client_secret.strip
    oauthTokenParams = {
      grant_type: 'authorization_code',
      client_id: client_id,
      redirect_uri: 'http://www.localhost:3000/oauth/twitter',
      code: params[:code]
    }
    access_token = getOAuthToken("https://api.twitter.com", "/2/oauth2/token",
                                 client_id, client_secret,
                                 oauthTokenParams)
    data = getUser("https://api.twitter.com", "/2/users/me", access_token)
    createUser(
      {
        username: data['username'],
        name: data['name'],
        provider: User.providers[:twitter],
        pid: data['id']
      }
    )
  end

  private

  def getBasicAuthToken(client_id, client_secret)
    Base64.strict_encode64("#{client_id}:#{client_secret}")
  end

  def getOAuthToken(url, path, client_id, client_secret, oauth_token_params)
    oauth_token_params[:code_verifier] = CODE_VERIFIER
    conn = Faraday.new(
      url: url,
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "Basic #{getBasicAuthToken(client_id, client_secret)}"
      }
    )
    response = conn.post(path, URI.encode_www_form(oauth_token_params))
    puts("response.status: #{response.status.inspect}")
    puts("response.body: #{response.body.inspect}")
    body_obj = JSON.parse(response.body)
    body_obj['access_token']
  end

  def getUser(url, path, access_token)
    conn = Faraday.new(
      url: url,
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "Bearer #{access_token}"
      }
    )
    response = conn.get(path)
    puts("response.status: #{response.status.inspect}")
    puts("response.body: #{response.body.inspect}")
    body_obj = JSON.parse(response.body)
    body_obj['data']
  end

  def createUser(user)
    puts("user: #{user}")
    User.find_or_create_by(user)
  end

end
