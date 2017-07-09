#!/bin/bash
KEVIN="Kevin Sum"
PROJECT_FILE=Project.xcodeproj/project.pbxproj

function set_organizer_if_need() {
	if grep -Fq "$KEVIN" $PROJECT_FILE ; then
		echo -n "Organization Name: "
		read ORGANIZER
		sed -i '' "s/$KEVIN/$ORGANIZER/g" $PROJECT_FILE
	fi
}

set_organizer_if_need

echo "/////////////////////////"
echo "//  CocoaPods Install  //"
echo "/////////////////////////"
pod install