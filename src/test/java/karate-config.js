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
    apiKey:'cEc/q1v4hTXyTmYkQHgTtC7n9w9xCOewJU/NDjmQgVTt3cHPtXi1nucADq7mxL/8',
    browserName: 'chrome'
  };

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  karate.configure('retry', { count: 10, interval: 5000 });
  return config;
}