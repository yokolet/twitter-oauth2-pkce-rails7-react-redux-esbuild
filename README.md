# Twitter OAuth Login with PKCE Example by Rails 7, esbuild, React/Redux Toolkit

This is a proof of concept example of Twitter OAuth Login using authorization code flow PKCE extension.
The client app is built by React/Redux Toolkit.
The server side is a Rails 7 app with esbuild setup.


#### Versions
- Ruby 3.2.2
- Rails 7.0.5

### PKCE (Proof Key for Code Exchange) Overview

Authorization Code Flow is one of OAuth 2.0 grant type.
It is a popular and secure social login method for a legacy, server-rendered web app.
However, it comes to JavaScript rich client application such as SPA (single page app),
the Authorization Code Flow ends up revealing social login's client secret.

The Authorization Code Flow uses both client id and client secret.
The client id is considered not secret while the client secret should be kept secret.
If dotenv like library is used, it's easy not to push the client secret to GitHub repo.
However, built-up or bundled JavaScript file has the client secret as is.
There's no way to avoid that for a JavaScript app since it runs on someone else's browser.

To fix such potentially risky issue, a new extension called Proof Key for Code Exchange (PKCE) has been introduced.
The PKCE uses code verifier and code challenge instead of client secret.
The code verifier is a random string.
The code challenge is generated from code verifier following a specified way.
During authorization process, only code challenge then only code verifier is sent to an authorization endpoint.

With that PKCE extension, SPA can perform a secure social login.

### How Authorization Code Flow with Proof Key for Code Exchange (PKCE) Works

The flow is a bit complicated.
It needs multiple interactions between the client app (SPA), server (Rails) and authorization endpoint (Twitter).
A high level overview of the flow looks like below:

1. SPA shows login button which has a link to social login with the required parameters including code challenge.
2. The web page is redirected to social login page provided by the auth endpoint (Twitter). This might be skipped if the user already logged.
3. The auth endpoint shows a consent page to the user
4. The user clicks the authorize app button.
5. The auth endpoint navigates to the provided redirect url with a code.
6. The server app receives the code.
7. The server app makes an access token request to the auth endpoint with required parameters including the code verifier and returned code.
8. The auth endpoint returns access token to the server.
9. The server app makes another request to the auth endpoint to get a user profile using the access token.
10. Lastly, the server redirects to the client url with access token.

With above process, while the client app has the valid access token, the user is considered authenticated.

### How to use the app

- Create your app and get your client id and secret at https://developer.twitter.com/en/portal/dashboard
- Run `bundle install`
- Run `yarn install`
- Copy app/assets/javascripts/settings.js-EXAMPLE to app/assets/javascripts/settings.js and write your client id
- Run `EDITOR=vim rails credentials:edit` and write your own secret and id
    ```yml
    secret_key_base: YOUR-SECRET-BASE
    jwt_secret: YOUR-JWT-SECRET-HERE
    twitter:
      client_id: YOUR-CLIENT-ID-HERE
      client_secret: YOUR-CLIENT-SECRET-HERE
    ```
- Run `bin/dev`
- Visit http://localhost:3000/

### Simplified Process

- The code verifier and code challenge are hardcoded.
  - Those two should be generated in every authorization process
  - Both SPA and Rails app needs code verifier
  - Only SPA needs code challenge
- The access token is not saved in the client app
- Logged in status is not kept -- needs to authorize app every time
- UI is minimum


