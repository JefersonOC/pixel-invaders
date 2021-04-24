#!/usr/bin/env bash
clear

flutter clean;
flutter upgrade;
flutter packages get;
flutter packages upgrade;

flutter build ios;

echo ""
echo "----------------------------------------------"
echo ""
echo "BUILD COMPLETE"
echo ""
echo "----------------------------------------------"
echo ""
echo "> OPEN XCODE open ios/Runner.xcworkspace"
echo "> UPDATE CODE VERSION AND BUILD > X.X.X"
echo "> CREATE ARCHIVE"
echo "> VALIDATE ARCHIVE"
echo "> UPLOAD ARCHIVE"
echo "> COMMIT CODE"
echo "> CREATE NEW VERSION IN APPLE DEVELOPER"
echo ""
echo "----------------------------------------------"