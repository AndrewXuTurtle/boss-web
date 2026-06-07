#!/bin/bash
# Make scripts executable
cd "$(dirname "$0")"
chmod +x scripts/*.sh pipeline/pipeline.sh
echo "✅ Scripts are now executable"
echo ""
echo "📦 LEAD ENGINE — Ready to use"
echo "================================"
echo ""
echo "Quick start:"
echo "  1. Find leads:   scripts/scrape-leads.sh"
echo "  2. Add lead:     pipeline/pipeline.sh add \"Nama\" \"Bisnis\" \"62812...\""
echo "  3. Gen draft:    scripts/generate-demo.sh \"Nama Bisnis\" \"Produk\" \"green\" \"62812...\""
echo "  4. List leads:   pipeline/pipeline.sh list"
echo "  5. Update stage: pipeline/pipeline.sh stage \"Nama\" contacted"
echo "  6. Stats:        pipeline/pipeline.sh stats"
