* create tag

# Version, Screenshots and Description

* version.txt
* version in snapcraft.yml
* pubspec
* Changelog
* fastlane

# F-droid

```
flutter build apk --release --flavor=fdroid
```

# Playstore

* remove donation url's

```
flutter build apk --release --flavor=playstore --split-per-abi
flutter build appbundle --flavor=playstore 
```

# Windows

```
flutter build windows
flutter pub run msix:create
```

# Linux

```
github action
snapcraft upload --release=stable lifehq.snap 
```

# IOS

```
CodeMagic
upload runner.app.zip
```

# MacOs

```
on Mac
flutter build macos
archive
create-dmg
upoad
```
