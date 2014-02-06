#Rialú
## Server

####Node.js computer control system


##Setup

- Run `npm install`
- Create `server/keys.coffee` with the following:

```coffeescript
module.exports = 
  twitterKey: 'your-twitter-key'
  twitterSecret: 'your-twitter-secret'
```

- Edit `server/config.coffee` to match your setup

- Start the server with `npm start`
- It will be running on port 5000 if no errors were found