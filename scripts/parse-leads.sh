#!/bin/bash
# Parse lead results from web_search output into CSV
# Usage: pipe search results into this script

cd "$(dirname "$0")/.."
mkdir -p leads

OUTFILE="leads/$(date +%Y-%m-%d)-parsed.csv"

echo "Parsing leads..."
echo "timestamp,title,url,snippet,source_query,category" > "$OUTFILE"

# Read from stdin (search results)
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
COUNT=0

while IFS= read -r line; do
  # Expecting format: title|url|snippet|query
  # Each line piped in as pipe-separated values
  TITLE=$(echo "$line" | cut -d'|' -f1)
  URL=$(echo "$line" | cut -d'|' -f2)
  SNIPPET=$(echo "$line" | cut -d'|' -f3 | sed 's/"/""/g')
  QUERY=$(echo "$line" | cut -d'|' -f4)
  
  if [ -n "$TITLE" ] && [ -n "$URL" ]; then
    # Categorize
    if echo "$URL" | grep -qi "instagram\|tiktok\|shopee\|tokopedia"; then
      CATEGORY="social_media"
    elif echo "$URL" | grep -qi "maps"; then
      CATEGORY="google_maps"
    else
      CATEGORY="web"
    fi
    
    echo "$TIMESTAMP,\"$TITLE\",\"$URL\",\"$SNIPPET\",\"$QUERY\",$CATEGORY" >> "$OUTFILE"
    COUNT=$((COUNT + 1))
  fi
done

echo "✅ Parsed $COUNT leads to: $OUTFILE"
echo ""
echo "Quick stats:"
cut -d',' -f6 "$OUTFILE" | sort | grep -v "category" | uniq -c | sort -rn
