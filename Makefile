.PHONY: clean refresh build-runner build_adb build-apk clean-ios shorebird-patch-android shorebird-patch-ios build-appbundle shorebird-build-apk

shorebird-release-android:
	@echo "Building Shorebird App for Android"
	shorebird release android

shorebird-release-ios:
	@echo "Release Shorebird App for iOS"
	shorebird release ios

shorebird-patch-android:
	@echo "Building Shorebird App for Android"
	shorebird patch android

shorebird-patch-ios:
	@echo "Building Shorebird App for iOS"
	shorebird patch ios

refresh:
	@echo " Getting Dependency"
	flutter pub get
clean-macos:
	@echo " Cleaning the macos code"
	flutter clean
	cd macos && rm -rf Podfile.lock
	cd macos && rm -rf Pods
	flutter pub get
	cd macos && pod install
build-appbundle: refresh
	@echo "Building appbundle"
	flutter build appbundle
build-aab:
	@echo "Getting Dependency"
	flutter pub get
	flutter build appbundle
build-apk: refresh
	@echo "Building apk"
	flutter build apk --split-per-abi --obfuscate --split-debug-info=build/app/outputs/symbols

shorebird-build-apk: refresh
	@echo "Building apk"
	shorebird build apk
build-runner:
	@echo "Build Runner Started"
	dart run build_runner build —delete-conflicting-outputs
build-watch:
	@echo "Build Runner Watch Started"
	dart run build_runner watch --delete-conflicting-outputs
clean:
	@echo "F Cleaning Flutter"
	flutter clean
	flutter pub get