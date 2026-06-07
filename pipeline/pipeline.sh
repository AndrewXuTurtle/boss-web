#!/bin/bash
# Pipeline Manager — Track leads through stages
# Usage: ./pipeline/pipeline.sh [add|list|stage|stats]

cd "$(dirname "$0")"
DB="leads.db"
mkdir -p leads

init_db() {
  if [ ! -f "$DB" ]; then
    echo "timestamp|name|business|wa_number|stage|notes|draft_url" > "$DB"
    echo "✅ Pipeline initialized"
  fi
}

case "${1:-list}" in
  add)
    init_db
    NAME="$2"; BUSINESS="$3"; WA="$4"; NOTES="${5:-}"; DRAFT="${6:-}"
    echo "$(date -u +%Y-%m-%dT%H:%M:%SZ)|$NAME|$BUSINESS|$WA|new|$NOTES|$DRAFT" >> "$DB"
    echo "✅ Added lead: $NAME — $BUSINESS"
    ;;
  
  list)
    init_db
    echo ""
    echo "📋 LEAD PIPELINE"
    echo "=================="
    column -t -s '|' "$DB" 2>/dev/null || cat "$DB"
    echo ""
    echo "Stages: new → drafted → contacted → negotiating → won | lost"
    ;;
  
  stage)
    init_db
    NAME="$2"; NEW_STAGE="$3"
    temp=$(mktemp)
    while IFS='|' read -r ts name biz wa stage notes draft; do
      if [ "$name" = "$NAME" ]; then
        echo "$ts|$name|$biz|$wa|$NEW_STAGE|$notes|$draft" >> "$temp"
      else
        echo "$ts|$name|$biz|$wa|$stage|$notes|$draft" >> "$temp"
      fi
    done < "$DB"
    mv "$temp" "$DB"
    echo "✅ $NAME → $NEW_STAGE"
    ;;
  
  stats)
    init_db
    echo ""
    echo "📊 PIPELINE STATS"
    echo "=================="
    echo "Total leads: $(tail -n +2 "$DB" | wc -l)"
    echo ""
    echo "By stage:"
    tail -n +2 "$DB" | cut -d'|' -f5 | sort | uniq -c | sort -rn
    ;;
  
  *)
    echo "Usage: $0 [add|list|stage|stats] [args...]"
    echo ""
    echo "Commands:"
    echo "  add  NAME BUSINESS WA [notes] [draft_url]"
    echo "  list                           — Show all leads"
    echo "  stage NAME new_stage           — Update lead stage"
    echo "  stats                          — Pipeline statistics"
    ;;
esac
