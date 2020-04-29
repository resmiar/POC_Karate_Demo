function fn() {   
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev'; // a custom 'intelligent' default
  }
  var config = { // base config JSON
 
    UrlBase: 'https://github.com/',
    SecondaryUrl: 'https://google.com/',
    healthUrl: 'https://katalon-demo-cura.herokuapp.com',
    apiURL: 'https://gorest.co.in/public-api',
    apiKey:'Bearer MdrA7WFOF1QXqEXmSIOYTUjzOa7Iw0oxUZWz',
    browserName: 'chrome'
  };
  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  // karate.configure('retry', { count: 6, interval: 1000 })
  return config;
}