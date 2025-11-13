#!/bin/bash

# Script to convert Markdown presentation to PowerPoint
# Usage: ./convert_to_ppt.sh

echo "🎨 Task Manager Presentation Converter"
echo "======================================"

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null
then
    echo "❌ Pandoc is not installed!"
    echo ""
    echo "To install pandoc:"
    echo "  macOS:   brew install pandoc"
    echo "  Linux:   sudo apt-get install pandoc"
    echo "  Windows: Download from https://pandoc.org/installing.html"
    echo ""
    echo "Alternative options:"
    echo "1. Use online converter: https://md2pptx.net/"
    echo "2. Copy content manually to PowerPoint"
    echo "3. Import to Google Slides"
    exit 1
fi

# Convert to PowerPoint
echo "✨ Converting PRESENTATION.md to PowerPoint..."
pandoc PRESENTATION.md -o Task_Manager_Presentation.pptx

if [ $? -eq 0 ]; then
    echo "✅ Success! PowerPoint created: Task_Manager_Presentation.pptx"
    echo ""
    echo "📊 Presentation includes:"
    echo "  - 25 comprehensive slides"
    echo "  - Project overview and features"
    echo "  - Technical implementation details"
    echo "  - UI/UX design explanations"
    echo "  - Key learnings and outcomes"
    echo ""
    echo "💡 Next steps:"
    echo "  1. Open Task_Manager_Presentation.pptx"
    echo "  2. Add screenshots from your app"
    echo "  3. Customize colors and design"
    echo "  4. Add your name and contact info"
else
    echo "❌ Conversion failed!"
    echo "Please check the error message above."
fi
