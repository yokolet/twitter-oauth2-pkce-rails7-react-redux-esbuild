const authEndpoint = 'https://twitter.com/i/oauth2/authorize';

const client_id = "REw3QnZQeVlBek81S0VOdTBBT0Y6MTpjaQ";
const redirect_uri = "http://www.localhost:3000/oauth/twitter";

export const getTwitterOauthUrl = (): string => {
  // temporarily uses static code verifier and challenge
  let code_challenge = "WeI7ul0uzUr0Zv89EPknzv4iNqmQuEysEtkWan7P3FA";
  let state = "state"; // generateRandomString(16);
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
