This is a simple php script which checks mining.bitcoin.cz's JSON
api to see if any workers are no longer "alive."  It is designed to
run as a cron job - that is, if you call it, and all of your workers
are alive, it outputs nothing.

Setup 
----- 

1) Makes sure you have php version 5.3.28 or higher

2) Do a recursive clone of the github repo:

```bash
git clone --recursive git@github.com:earlye/mining-monitor.git
```

3) Provide a file in the same directory, named config.json, which looks
something like this:

```JSON
{ 
  "mining_urls" : 
    { "{name-1}" : "https://mining.bitcoin.cz/accounts/profile/json/{mining-url-key-1}",
      "{name-2}" : "https://mining.bitcoin.cz/accounts/profile/json/{mining-url-key-2}",
	  /*...*/
	  "{name-n}" : "https://mining.bitcoin.cz/accounts/profile/json/{mining-url-key-n}" }
}
```

4) Add mining-monitor.sh.php to your crontab. We suggest running it
every hour, so we don't want to overwhelm the pool's servers or get
put on a blacklist for trying to do so, but still get some
notification that our mine is hosed.

```cron
0 * * * * {path}/mining-monitor.sh.php
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

History
-------

2014-09-22 - ported to php to get better curl/json support.
