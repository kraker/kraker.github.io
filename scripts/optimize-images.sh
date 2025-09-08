#!/bin/bash
# Image optimization script for Hugo site
# This script optimizes images for web use while maintaining good quality

set -e

echo "🖼️  Starting image optimization..."

# Create backup directory
mkdir -p ./image-backups
echo "📁 Created backup directory"

# Function to optimize a single image
optimize_image() {
    local input_file="$1"
    local max_width="$2"
    local quality="$3"
    local backup_file="./image-backups/$(basename "$input_file")"
    
    # Create backup if it doesn't exist
    if [ ! -f "$backup_file" ]; then
        cp "$input_file" "$backup_file"
        echo "💾 Backed up: $(basename "$input_file")"
    fi
    
    # Get original size
    local original_size=$(du -h "$input_file" | cut -f1)
    
    # Optimize the image
    magick "$input_file" \
        -resize "${max_width}x${max_width}>" \
        -strip \
        -interlace Plane \
        -quality "$quality" \
        "$input_file"
    
    # Get new size
    local new_size=$(du -h "$input_file" | cut -f1)
    echo "✅ Optimized: $(basename "$input_file") ($original_size → $new_size)"
}

# Function to convert PNG to WebP with JPG fallback for screenshots
optimize_screenshot() {
    local input_file="$1"
    local backup_file="./image-backups/$(basename "$input_file")"
    
    # Create backup if it doesn't exist
    if [ ! -f "$backup_file" ]; then
        cp "$input_file" "$backup_file"
        echo "💾 Backed up: $(basename "$input_file")"
    fi
    
    # Get original size
    local original_size=$(du -h "$input_file" | cut -f1)
    
    # For screenshots, try WebP first
    local webp_file="${input_file%.*}.webp"
    magick "$input_file" \
        -resize "1200x1200>" \
        -strip \
        -quality 85 \
        "$webp_file"
    
    # Also create optimized PNG version
    magick "$input_file" \
        -resize "1200x1200>" \
        -strip \
        -colors 256 \
        "$input_file"
    
    local new_size=$(du -h "$input_file" | cut -f1)
    local webp_size=$(du -h "$webp_file" | cut -f1)
    echo "✅ Optimized screenshot: $(basename "$input_file") ($original_size → $new_size, WebP: $webp_size)"
}

echo ""
echo "🔍 Processing large hero images (>1MB)..."

# Optimize very large images (hero images)
find ./content -name "*.jpg" -o -name "*.jpeg" | while read -r file; do
    size_bytes=$(stat -c%s "$file")
    size_mb=$((size_bytes / 1024 / 1024))
    
    if [ $size_mb -gt 1 ]; then
        echo "Processing large image: $(basename "$file") (${size_mb}MB)"
        optimize_image "$file" 1920 82
    fi
done

echo ""
echo "📸 Processing medium-sized images..."

# Optimize medium images (blog images)
find ./content -name "*.jpg" -o -name "*.jpeg" | while read -r file; do
    size_bytes=$(stat -c%s "$file")
    size_kb=$((size_bytes / 1024))
    size_mb=$((size_bytes / 1024 / 1024))
    
    if [ $size_mb -le 1 ] && [ $size_kb -gt 200 ]; then
        echo "Processing medium image: $(basename "$file") (${size_kb}KB)"
        optimize_image "$file" 1200 80
    fi
done

echo ""
echo "🖥️  Processing screenshots..."

# Optimize PNG screenshots
find ./content -name "*.png" | while read -r file; do
    size_bytes=$(stat -c%s "$file")
    size_kb=$((size_bytes / 1024))
    
    if [ $size_kb -gt 50 ]; then
        echo "Processing screenshot: $(basename "$file") (${size_kb}KB)"
        optimize_screenshot "$file"
    fi
done

echo ""
echo "📊 Optimization complete! Summary:"
echo "📁 Original images backed up to ./image-backups/"
echo "🔍 Before optimization:"
find ./image-backups -type f 2>/dev/null | wc -l | xargs echo "   Files:"
du -sh ./image-backups 2>/dev/null | cut -f1 | xargs echo "   Total size:" || echo "   Total size: (calculating...)"
echo "✨ After optimization:"
find ./content -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" | wc -l | xargs echo "   Files:"
du -sh ./content 2>/dev/null | cut -f1 | xargs echo "   Total content size:" || echo "   Total content size: (calculating...)"

echo ""
echo "🚀 Your images are now optimized for faster web loading!"
echo "💡 Consider updating your markdown files to use WebP images where available."