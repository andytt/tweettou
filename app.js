var twitter = require('twitter'),
    nodemailer = require('nodemailer');

var twit = new twitter({
        consumer_key: '',
        consumer_secret: '',
        access_token_key: '',
        access_token_secret: ''
    }),
    smtp = nodemailer.createTransport('Gmail', {
        auth: {
            user: '',
            pass: ''
        }
    });

    twit.get('/friends/ids.json', {
        screen_name: ''
    }, function (data) {
        var friends = data.ids,
            filterData = {
                follow: friends.join(',')
            },
            filter = /angularjs|laravel|nodejs|php|javascript|web|design|bootstrap|jquery|fontawesome/;
        twit.stream('statuses/filter', filterData, function(stream) {
            stream.on('data', function(tweet) {
                if (filter.test(tweet.text.toLowerCase())) {
                    smtp.sendMail({
                        from: '',
                        to: '',
                        subject: 'STTY',
                        text: tweet.user.screen_name + ': ' + tweet.text,
                    });
                }
            });
        });
    });


