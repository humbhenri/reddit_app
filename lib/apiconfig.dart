class ApiConfig {
  static const ACCESS_TOKEN_URI = 'https://www.reddit.com/api/v1/access_token';
  static const REDIRECT_URI = 'http://www.github.com/humbhenri/reddit_app';
  static const SCOPE = 'identity,mysubreddits,read,save,submit,subscribe,edit';
  static const USER_AGENT = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
  static const AUTH_URI = 'https://www.reddit.com/api/v1/authorize.compact?response_type=code&';
  static const ROOT_URI = 'https://oauth.reddit.com';
}