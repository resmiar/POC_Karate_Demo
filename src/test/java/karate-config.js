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

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  karate.configure('retry', { count: 10, interval: 5000 });
  return config;
}