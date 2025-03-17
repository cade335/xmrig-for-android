# Build XMRig for Android

## Prerequisites
* NodeJS v17.1.0
* [React Native Development Enviroment](https://reactnative.dev/docs/environment-setup)
* Android Studio
* Android 10 SDK 29
* Android SDK Build Tools 29.0.2
* Android NDK 23.0.7599858
* Android SDK Command-line Tools 5.0
* Android SDK Platform-Tools 31.0.3
* CMake

## Build XMRig
This script will compile hwloc, libuv and xmrig for each ABI. The execuable will be copied to `jniLibs` folder in android project.
```
cd xmrig/lib-builder
make install
```

## Build APK
To build the APK for the XMRig for Android project, follow these steps:

1. Ensure you have the necessary tools installed, including Node.js, Yarn, and the Android SDK.
2. Clone the repository and navigate to the project directory.
3. Install the project dependencies by running `yarn install`.
4. Build the native libraries by navigating to the `xmrig/lib-builder` directory and running `make all`.
5. Build the Android project by navigating to the `android` directory and running `./gradlew bundleRelease`.
6. Create the APK from the AAB file using the `bundletool` by running the following commands:
   * `java -jar /path/to/bundletool.jar build-apks --mode=universal --bundle=./android/app/build/outputs/bundle/release/app-release.aab --output=./android/app/build/outputs/bundle/release/app-release.apks`
   * `unzip ./android/app/build/outputs/bundle/release/app-release.apks`
   * `mv universal.apk ./android/app/build/outputs/bundle/release/app-release.apk`
7. Sign the APK using the `sign-android-release` GitHub action or manually with your keystore.
8. The final APK will be located in the `android/app/build/outputs/bundle/release` directory.

For more details, refer to the `android/app/build.gradle` and `android/app/_BUCK` files.

## Run
Clone the repo

`yarn install`

Start meteor server
`yarn start`

If you use nvm - open Android Studio from terminal after running `nvm use`.

Run Android Emulator
`npx react-native run-android`
