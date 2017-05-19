#!/bin/bash --login

SCRIPTPATH=$(dirname $0)

# Do a travis-like validation build and test

gem install bundler
rvm use 2.3.0

export TRAVIS_XCODE_WORKSPACE="$SCRIPTPATH/../KeenClient.xcworkspace"
export TRAVIS_XCODE_SDK=iphonesimulator10.3
export XCODEBUILD_PLATFORM='iOS Simulator'
export XCODEBUILD_SIM_OS=10.3
export XCODEBUILD_DEVICE='iPhone 6'
export XCODEBUILD_ACTION=build

BUILD_SCRIPT="$SCRIPTPATH/test.sh"

export TRAVIS_XCODE_SCHEME=KeenClientFramework
$BUILD_SCRIPT

export TRAVIS_XCODE_SCHEME=KeenSwiftClientExample
$BUILD_SCRIPT

export TRAVIS_XCODE_SCHEME=KeenClient
export XCODEBUILD_ACTION=test
$BUILD_SCRIPT

export TRAVIS_XCODE_SCHEME=KeenClient-Cocoa
export TRAVIS_XCODE_SDK='macosx10.12'
export XCODEBUILD_PLATFORM='OS X'
export XCODEBUILD_ACTION=build
$BUILD_SCRIPT

export TRAVIS_XCODE_WORKSPACE=Examples/KeenClientExampleObjC/KeenClientExampleObjCCocoaPods/KeenClientExampleObjCCocoaPods.xcworkspace
export TRAVIS_XCODE_SCHEME=KeenClientExampleObjCCocoaPods
export TRAVIS_XCODE_SDK=iphonesimulator10.3
export XCODEBUILD_PLATFORM='iOS Simulator'
export XCODEBUILD_ACTION=build
$BUILD_SCRIPT