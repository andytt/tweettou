twitter    = require 'twitter'
nodemailer = require 'nodemailer'

twit = twitter do ->
    {
        consumer_key: ''
        consumer_secret: ''
        access_token_key: ''
        access_token_secret: ''
    }



smtp = nodemailer.createTransport 'Gmail', do ->
    {
        auth: {
            user: '',
            pass: ''
        }
    }

userData = {
    screen_name: ''
}

twit.get '/friends/ids.json', userData, (data) ->
    friends = data.ids
    filterData = {
        follow: friends.join(',')
    }
    filter = ///
        angularjs
        | laravel
        | nodejs
        | php
        | javascript
        | bootstrap
        | jquery
        | fontawesome
    ///

    twit.stream 'statuses/filter', filterData, (stream) ->
        stream.on 'data', (tweet) ->
            lowercase = do tweet.text.toLowerCase
            if filter.test lowercase
                smtp.sendMail {
                    from: ''
                    to: ''
                    subject: 'STTY'
                    text: "#{tweet.user.screen_name}: #{tweet.text}"
                }

