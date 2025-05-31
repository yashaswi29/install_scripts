#!/bin/bash
set -e  

echo "Creating Tutor plugins directory..."
TUTOR_PLUGIN_DIR=$(tutor plugins printroot)
mkdir -p "$TUTOR_PLUGIN_DIR"

echo "Transferring custom plugin to $TUTOR_PLUGIN_DIR"
cp /home/$USER/install_scripts/fro-auth.py "$TUTOR_PLUGIN_DIR/"

echo "Running tutor config save..."
tutor config save \
  --set LMS_HOST="local.openedx.io" \
  --set CMS_HOST="studio.local.openedx.io" \
  --set PLATFORM_NAME="Aavapti Dev Server" \
  --set CONTACT_EMAIL="$USER@afidigitalservices.com" \
  --set ENABLE_HTTPS="false"

echo "Listing Tutor plugins..."
tutor plugins list

echo "Installing pluggy (required for plugin loading)..."
pip install pluggy --break-system-packages

echo "Enabling custom 'fro-auth' plugin..."
tutor plugins enable fro-auth

echo "Building MFE image..."
tutor images build mfe

echo "Launching Open edX platform locally..."
tutor local launch --non-interactive

echo "Transferring custom Indigo theme to env/build/openedx/themes..."
THEMES_DIR="/home/$USER/.local/share/tutor/env/build/openedx/themes"
rm -rf "$THEMES_DIR/indigo"
cp -r /home/$USER/install_scripts/indigo "$THEMES_DIR/"

echo "Building Open edX platform image with new theme..."
tutor images build openedx
