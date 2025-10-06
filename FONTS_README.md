# Quran Mushaf Fonts

This project uses 604 Quran page-specific fonts (QCF_P001.ttf to QCF_P604.ttf) that are **NOT included in the Git repository** due to their large size (~200MB).

## Where to get the fonts

The fonts are available from the official Quran Complex Font repository.

## Installation

1. Download the QCF2BSMLfonts package
2. Extract all `.ttf` files to: `assets/fonts/QCF2BSMLfonts/`
3. The app will automatically load the appropriate font for each page

## Note for Developers

- Fonts are listed in `.gitignore` and will not be committed
- Keep your local copy of fonts in `assets/fonts/QCF2BSMLfonts/`
- The fonts must be present for the app to display Mushaf pages correctly
