#!/bin/bash
# Lead Scraper — Find UMKM/local businesses that may need a website
# Sources: Google Maps, Google Search, Instagram (via search)

set -e

cd "$(dirname "$0")/.."
mkdir -p leads

LEADS_FILE="leads/$(date +%Y-%m-%d)-leads.csv"
SEARCH_QUERIES=(
  # Indonesian cities + business types likely to need web presence
  "site:instagram.com UMKM Batam kuliner belum punya website"
  "site:instagram.com usaha rumahan Bandung online"
  "UMKM Jakarta makanan ringan no website"
  "usaha kecil Surabaya frozen food"
  "toko online Medan belum punya website"
  "bisnis rumahan Yogyakarta oleh-oleh"
  "UKM Semarang fashion"
  "usaha rumahan Makassar kerajinan"
  "UMKM Palembang pempek"
  "toko oleh-oleh khas daerah Indonesia"
)

echo "📡 Lead Scraper — $(date)"
echo "========================================"
echo ""

# Init CSV with header
echo "timestamp,source,title,url,snippet" > "$LEADS_FILE"
TOTAL=0

for query in "${SEARCH_QUERIES[@]}"; do
  echo "🔍 Searching: $query"
  
  # Use web search via available source
  # We're building this for the agent to use, so we generate the search commands
  # The actual execution will use OpenClaw's web_search tool
  
  echo "  → queued for search"
  echo ""
done

echo ""
echo "✅ Results saved to: $LEADS_FILE"
echo "📊 Total queries queued: ${#SEARCH_QUERIES[@]}"
echo ""
echo "To run searches, use the OpenClaw web_search tool for each query."
echo "Then pipe results through: scripts/parse-leads.sh"
