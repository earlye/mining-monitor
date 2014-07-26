This is a simple shell script which checks mining.bitcoin.cz's JSON
api to see if any workers are no longer "alive."  It is designed to
run as a cron job - that is, if you call it, and all of your workers
are alive, it outputs nothing. In other 

Setup 
----- 

1) Install jq somewhere it is accessible in the PATH visible to
cron. On my mac, that location is /usr/bin. 

jq is available here: http://stedolan.github.io/jq/

2) Clone this project into a directory of your choosing.

3) Provide a file in that same directory, named config.sh, which looks
something like this:

```bash
mining_url=https://mining.bitcoin.cz/accounts/profile/json/{some-api-token}
```

4) Add mining-monitor.sh to your crontab. We suggest running it every
half hour, because we don't want to overwhelm the pool's servers, just
get some notification that our mine is hosed.

```cron
*/30 * * * * {path}/mining-monitor.sh
```

5) cron will now send you an email if your cluster ever goes down for
more than a half hour.  You could tighten up your polling if you wish,
but the script doesn't check to see if you've already been notified,
so if you set it to, say, 1 minute, be prepared for spammage if you
have a blackout or something like that. Where that email ends up
depends on how well you have cron configured. If, like me, you can't
be bothered to set it up, it'll show up in your user spool, and you'll
see the mail message the next time you use a terminal.  That's fine
for me, because I spend most of my time in a terminal. If you want
better (like having it go to your gmail or your phone), well, that's
why I went with a cron-based, open-source solution: you can figure out
those parts without my help ;-)

Troubleshooting
---------------

mining-monitor.sh has a line that looks like this:

```bash
data=`curl -s ${mining_url}`
```

Followed by a commented-out section which assigns a different value to
'data'. It can be very helpful to swap those out and play with the
data which jq parses.  Other than that, look at the output and you
should be able to figure out what's wrong.