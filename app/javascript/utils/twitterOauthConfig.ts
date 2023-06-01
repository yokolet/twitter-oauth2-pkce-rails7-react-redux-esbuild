const authEndpoint = 'https://twitter.com/i/oauth2/authorize';

const client_id = environment.REACT_APP_TWITTER_CLIENT_ID;
const redirect_uri = "http://www.localhost:3000/oauth/twitter";

export const getTwitterOauthUrl = (): string => {
  // temporarily uses static code verifier and challenge
  let code_challenge = "WeI7ul0uzUr0Zv89EPknzv4iNqmQuEysEtkWan7P3FA";
  let state = "state";
  let scope = ["users.read", "tweet.read", "follows.read", "follows.write"].join(" ");
  // @ts-ignore
  let args = new URLSearchParams({
    redirect_uri,
    client_id,
    state,
    response_type: 'code',
    code_challenge,
    code_challenge_method: "S256",
    scope,
  }).toString();
  return `${authEndpoint}?${args}`;
}
