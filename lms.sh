#!/bin/bash
set -e  

echo "Creating Tutor plugins directory..."
TUTOR_PLUGIN_DIR=$(tutor plugins printroot)
mkdir -p "$TUTOR_PLUGIN_DIR"

echo "Transferring custom plugin to $TUTOR_PLUGIN_DIR"
cp /home/$USER/install_scripts/fro-auth.py "$TUTOR_PLUGIN_DIR/"

echo "Running tutor config save..."
tutor config save \
  --set LMS_HOST="lms.aavaptitechnologies.com" \
  --set CMS_HOST="cms.aavaptitechnologies.com" \
  --set PLATFORM_NAME="Aavapti Technologies" \
  --set CONTACT_EMAIL="yashaswi@afidigitalservices.com" \
  --set ENABLE_HTTPS="true"

echo "Listing Tutor plugins..."
tutor plugins list

echo "Installing pluggy (required for plugin loading)..."
pip install pluggy --break-system-packages

echo "Enabling custom 'fro-auth' plugin..."
tutor plugins enable fro-auth

echo "Building MFE image..."
tutor images build mfe --no-cache

echo "Launching Open edX platform locally..."
tutor local launch --non-interactive

echo "Transferring custom Indigo theme to env/build/openedx/themes..."
THEMES_DIR="/home/$USER/.local/share/tutor/env/build/openedx/themes"
rm -rf "$THEMES_DIR/indigo"
cp -r /home/$USER/install_scripts/indigo "$THEMES_DIR/"

echo "Building Open edX platform image with new theme..."
tutor images build openedx

echo "Restarting Open edX platform with custom theme...""
tutor local stop
tutor local start -d
tutor local restart
echo "Open edX platform is now running with the custom Indigo theme and fro-auth plugin enabled."
