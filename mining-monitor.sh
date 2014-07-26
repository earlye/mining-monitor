# set mining_url to the "pool account" url here: https://mining.bitcoin.cz/accounts/token-manage/
# set last_share_path to a jq query which will give you the unix timestamp of the last_share entry in your worker pool.  e.g.,: .workers[\"worker-name\"].last_share
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/config.sh

if [ "${notification_sent}" == "1" ]; then
    echo "notification already sent."
fi

data=`curl -s ${mining_url}`
# export data='{
#   "workers": {
#     "test-worker": {
#       "last_share": 1406292647,
#       "score": "513.4673",
#       "hashrate": 566,
#       "shares": 240,
#       "alive": false
#     },
#     "test-worker2": {
#       "last_share": 1406292768,
#       "score": "96686.8344",
#       "hashrate": 97295,
#       "shares": 41184,
#       "alive": true
#     }
#   }
# }'

dead=`echo ${data} | jq -c '[ .workers | to_entries | map(select(.value.alive == false))[].key ]'`

if [ "${dead}" != "[]" ]; then 
    echo "The following clusters are dead: ${dead}"
fi
