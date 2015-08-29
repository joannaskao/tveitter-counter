# Tveiter Counter

Track a Twitter user's follower count over time. Produces a CSV with a timestamp and follower count at the time. Includes directions for setting up a cron job that runs the Ruby script using an RVM.

#### Requirements
- *Optional*: If you want to regularly track someone's Twitter followers, you should run this on a remote machine that will never turn off. Using an Amazon EC2 box is a good option.
- Install [RVM](https://rvm.io/rvm/install). Do not install RVM if you already use rbenv or a similar program.
- Create/register a new app on [Twitter's app developer dashboard](https://apps.twitter.com/).
- Download/clone this repository. (`git clone git@github.com:joannaskao/tveiter-counter.git`)

#### Directions
First, let's set up the script.
1. Create a [RVM gemset](https://rvm.io/gemsets/creating). You will need a specify a gemset when you set up your cron job. (e.g. `rvm use 2.2.1@tveiter-counter --create`)
2. In `script.rb`, copy and paste your consumer key, consumer secret, access token and access secret from the app you created on the Twitter developer dashboard into *lines 7-10*. Don't share these values.
3. On line 25 of `script.rb`, replace path/to/output.csv with the location of where you want your data dumped. A path from your home folder is recommended (e.g. absolute file path).
4. If you don't want to track @aarontveit, you can specify another Twitter handle on line 13 of `script.rb`.
5. Replace the path in line 4 of `tveiter-counter-cron.sh` with what `rvm env --path -- 2.2.1@tveiter-counter` returns.
6. Replace the path in line 7 of `tveiter-counter-cron.sh` with a path to your `script.rb` file. Absolute file paths are best.
5. Make sure that your .sh file is executable. Run `chmod 400 path/to/tveiter-counter-cron.sh`.

At this point, you should be able to run your shell script. You can test your work by running `sh tveiter-counter-cron.sh` in the folder where your file is located.

If that works, we can move on to writing a cron job so that your machine automatically runs the script at a regular interval.
1. To edit your list of cron jobs, run `crontab -e` from any directory on your machine.
2. You'll want to run your script approximately once every other minute or less frequently. The Twitter API restricts you to 15 calls every 15 minutes. Add `*/2 * * * * /path/to/twitter-tracker-cron.sh` to your crontab file with your specific path to the `twitter-tracker-cron.sh` file.

#### How did the name come about?

The [project](http://joannaskao.com/broadway-beats/tveiter-counter/) initially started as a way to track [Aaron Tveit's](http://www.playbillvault.com/Person/Detail/31840/Aaron-Tveit) rate of Twitter follower gain after he [joined Twitter](http://www.bustle.com/articles/107130-aaron-tveit-finally-gets-twitter-thirsty-musical-theater-nerds-everywhere-rejoice) on [August 27, 2015](https://twitter.com/AaronTveit/status/636953527198334976?ref_src=twsrc%5Etfw). But the script can be modified to track any other Twitter handle by just changing one line of code.

![Aaron Tveit gained nearly 5,000 followers in the two hours after his first tweet, then gained another 8,000 within the first 24 hours of being on Twitter](http://joannaskao.com/broadway-beats/tveiter-counter/images/tveiter-counter.png)