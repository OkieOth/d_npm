A simple debian based image with installed node.js

It expects a react/webpack project in /opt/myproject and a configured entry devserver in packages.json

Something like that ...

``` 
  "scripts": {
    ...
    "devserver": "./node_modules/.bin/webpack-dev-server --inline --hot --config webpack.config.devel.js --content-base public/"
  }
``` 
