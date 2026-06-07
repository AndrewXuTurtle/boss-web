#!/bin/bash
# Quick Demo Site Generator
# Usage: ./scripts/generate-demo.sh "Business Name" "Product/Service" "Color Theme" "WhatsApp Number"
# Example: ./scripts/generate-demo.sh "Toko Makmur Sejahtera" "Sembako & Frozen Food" "green" "6281234567890"

set -e

NAME="${1:-Nama Bisnis}"
PRODUCT="${2:-Produk/Jasa}"
THEME="${3:-green}"
WA="${4:-6281234567890}"

OUTDIR="/Users/infovegetarian/.openclaw/workspace/lead-engine/drafts/$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
mkdir -p "$OUTDIR"

# Get current date for footer
YEAR=$(date +%Y)

echo "🚀 Generating demo site for: $NAME"
echo "   Product: $PRODUCT"
echo "   Theme: $THEME"
echo "   Output: $OUTDIR"

# Map theme colors
case "$THEME" in
  green)    PRIMARY="#1a7a3a"; PRIMARY_DARK="#0f4d24"; ACCENT="#e8a838";;
  blue)     PRIMARY="#1e40af"; PRIMARY_DARK="#0f1d5a"; ACCENT="#f59e0b";;
  red)      PRIMARY="#b91c1c"; PRIMARY_DARK="#7f1d1d"; ACCENT="#fbbf24";;
  orange)   PRIMARY="#c2410c"; PRIMARY_DARK="#7c2d12"; ACCENT="#34d399";;
  purple)   PRIMARY="#7c3aed"; PRIMARY_DARK="#4c1d95"; ACCENT="#fbbf24";;
  *)        PRIMARY="#1a7a3a"; PRIMARY_DARK="#0f4d24"; ACCENT="#e8a838";;
esac

cat > "$OUTDIR/index.html" << HTMLEOF
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>$NAME — $PRODUCT</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; color: #1e293b; line-height: 1.6; }
    .container { max-width: 1100px; margin: 0 auto; padding: 0 20px; }

    .hero {
      padding: 100px 0 60px;
      background: linear-gradient(135deg, $PRIMARY_DARK, $PRIMARY);
      color: white; text-align: center;
    }
    .hero h1 { font-size: 2.5rem; margin-bottom: 12px; }
    .hero p { font-size: 1.15rem; opacity: 0.9; max-width: 500px; margin: 0 auto 24px; }
    .btn {
      display: inline-block; padding: 12px 28px; border-radius: 8px;
      background: white; color: $PRIMARY; text-decoration: none;
      font-weight: 600; transition: 0.2s;
    }
    .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 16px rgba(0,0,0,0.2); }
    .btn-outline {
      background: transparent; color: white; border: 2px solid rgba(255,255,255,0.4);
      margin-left: 8px;
    }
    .btn-outline:hover { border-color: white; background: rgba(255,255,255,0.1); }

    section { padding: 60px 0; }
    .section-title { font-size: 1.8rem; text-align: center; margin-bottom: 32px; }

    .about-content { max-width: 700px; margin: 0 auto; text-align: center; color: #64748b; }

    .products { background: #f8faf8; }
    .product-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
    .product-card {
      padding: 24px; background: white; border-radius: 12px;
      text-align: center; border: 1px solid #e2e8f0; transition: 0.2s;
    }
    .product-card:hover { box-shadow: 0 8px 24px rgba(0,0,0,0.08); transform: translateY(-2px); }
    .product-icon { font-size: 2.5rem; margin-bottom: 12px; }
    .product-card h3 { margin-bottom: 8px; }
    .product-card p { color: #64748b; font-size: 0.9rem; }

    .contact {
      background: linear-gradient(135deg, $PRIMARY_DARK, $PRIMARY);
      color: white; text-align: center;
    }
    .contact h2 { margin-bottom: 12px; }
    .contact p { opacity: 0.9; margin-bottom: 24px; }
    .whatsapp-btn {
      display: inline-flex; align-items: center; gap: 8px;
      padding: 14px 32px; background: #25D366; color: white;
      border-radius: 8px; text-decoration: none; font-weight: 600;
      transition: 0.2s;
    }
    .whatsapp-btn:hover { background: #1da851; transform: translateY(-2px); }

    footer { padding: 24px 0; text-align: center; background: #0f172a; color: #94a3b8; font-size: 0.85rem; }
    .hero-actions { display: flex; gap: 8px; justify-content: center; flex-wrap: wrap; }
    @media (max-width: 480px) {
      .hero h1 { font-size: 1.6rem; }
      .hero-actions { flex-direction: column; align-items: center; }
    }
  </style>
</head>
<body>
  <section class="hero">
    <div class="container">
      <h1>$NAME</h1>
      <p>Melayani $PRODUCT berkualitas untuk Anda dan keluarga.</p>
      <div class="hero-actions">
        <a href="#products" class="btn">Lihat Produk</a>
        <a href="#contact" class="btn btn-outline">Hubungi Kami</a>
      </div>
    </div>
  </section>

  <section id="about">
    <div class="container">
      <h2 class="section-title">Tentang Kami</h2>
      <div class="about-content">
        <p>Selamat datang di <strong>$NAME</strong>. Kami hadir untuk memberikan produk $PRODUCT terbaik dengan kualitas dan pelayanan yang memuaskan.</p>
      </div>
    </div>
  </section>

  <section class="products" id="products">
    <div class="container">
      <h2 class="section-title">Produk Kami</h2>
      <div class="product-grid">
        <div class="product-card">
          <div class="product-icon">⭐</div>
          <h3>Produk 1</h3>
          <p>Deskripsi produk unggulan Anda bisa ditulis di sini.</p>
        </div>
        <div class="product-card">
          <div class="product-icon">⭐</div>
          <h3>Produk 2</h3>
          <p>Deskripsi produk kedua bisa ditambahkan nanti.</p>
        </div>
        <div class="product-card">
          <div class="product-icon">⭐</div>
          <h3>Produk 3</h3>
          <p>Deskripsi produk ketiga sesuai kebutuhan bisnis.</p>
        </div>
      </div>
    </div>
  </section>

  <section class="contact" id="contact">
    <div class="container">
      <h2>Hubungi Kami</h2>
      <p>Pesan sekarang atau tanyakan produk kami via WhatsApp.</p>
      <a href="https://wa.me/$WA?text=Halo%20$NAME%2C%20saya%20tertarik%20dengan%20produk%20Anda" class="whatsapp-btn" target="_blank">
        💬 Chat WhatsApp
      </a>
    </div>
  </section>

  <footer>
    <div class="container">
      <p>&copy; $YEAR $NAME. All rights reserved.</p>
      <p style="margin-top:8px;font-size:0.75rem;">Made with ❤️ by BOSS Web</p>
    </div>
  </footer>
</body>
</html>
HTMLEOF

echo ""
echo "✅ Demo site generated!"
echo "   📁 $OUTDIR/index.html"
echo ""
echo "To deploy to GitHub Pages:"
echo "   1. Create repo: gh repo create [name] --public --source=$OUTDIR --push"
echo "   2. Enable Pages: gh api repos/[user]/[repo]/pages -X POST -f source='{\"branch\":\"main\",\"path\":\"/\"}'"
echo ""
echo "Preview URL: file://$OUTDIR/index.html"
