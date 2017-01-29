#!/bin/bash

cd /opt/myproject

if [ -f package.json ]; then
    if ! [ -d node_modules ]; then
        npm install
    fi
    npm run devserver
else
    echo "no project found in /opt/myproject :-/"
fi
