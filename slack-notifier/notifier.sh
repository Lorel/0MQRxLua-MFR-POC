#!/bin/bash

# Usage: notifier <message>
# source: https://gist.github.com/dopiaza/6449505 (but modified)


webhook=https://hooks.slack.com/services/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

text=$*

if [[ $text == "" ]]
then
        echo "No text specified"
        exit 1
fi

escapedText=$(echo $text | sed 's/"/\\"/g' | sed "s/'/\\'/g" )
json="{\"text\": \"$escapedText\"}"

curl -X POST --data-urlencode "payload=$json" $webhook
