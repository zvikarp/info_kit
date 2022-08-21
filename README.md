# info_kit

[![pub package](https://img.shields.io/pub/v/info_kit.svg)](https://pub.dev/packages/info_kit)

Provides all basic info about your application. App flavor, Version, Device size, Flavor specific environment variables, and more.

## Installation

```bash
flutter pub add info_kit
```

### Examples
Here are small examples that show you how to use the package, there are more examples in the examples folder.

#### Initialization

```dart
InfoKit.init({
  flavorEnabled: true,
  List<InfoFlavor> flavors = DefaultInfoFlavor.flavors,
  InfoFlavor fallbackFlavor = DefaultInfoFlavor.fallbackFlavor,
  List<InfoSize> sizes = DefaultInfoSize.sizes,
  InfoSize fallbackSize = DefaultInfoSize.fallbackSize,
  bool envEnabled = true,
  bool envFlavorEnabled = true,
  bool envFlavorPerPlatformEnabled = true,
  String envFolder = 'env', // set to '' to use the root folder
});
```

#### Available getters

```dart

// size of the device, based on a list of supported sizes
InfoSize size = InfoKit.size;

// origin url on web platform, otherwise an empty string
String origin = InfoKit.origin;

// device's language
Locale locale = InfoKit.locale;

// device platform, (ios app, web app, macos app), etc
InfoPlatform platform = InfoKit.platform;

// device's operating system
InfoOS os = InfoKit.os;

// build flavor
InfoFlavor flavor = InfoKit.flavor;

// if release build or debug
InfoMode mode = InfoKit.mode;

int buildNumber = InfoKit.buildNumber;

String version = InfoKit.version;

String packageName = InfoKit.packageName;

String appName = InfoKit.appName;

```


## Usage

Here are the main "features" of the package:

### Flavor
Provides access to the current flavor of the application.
1. Set the list of supported flavors with the `flavors` parameter. There is a default list of flavors that can be used, but you can add more or create your own.
1. Define the current flavor with a build argument `flutter run --dart-define=flavor=<flavor>` (this package ignores the `--flavor` flag, because that flag is not accessible in web builds).
2. Anywhere in your application, you can access the current flavor with the `flavor` getter.

### Size
1. Wrap the root of your project with a `LayoutBuilder` and use the `constraints` property to get the size.
    ```dart
    LayoutBuilder(
      builder: (context, constraints) {
        InfoKit.setConstrains(constraints);
        return Text('${constraints.maxWidth} x ${constraints.maxHeight}');
      },
    );
    ```
1. The returned size by the `size` getter is one from a list of predefined sizes.
1. There is a default list of sizes that can be used, but you can add more or create your own.

### Env
Set different environment variables for different flavors and different flavors!

1. The file structure should look like this:
    ```
    - env
      - .env
      - .env.flavor1
      - .env.flavor2
      - .env.flavor3
      - ios
        - .env.flavor1
        - .env.flavor2
        - .env.flavor3
      - android
        - .env.flavor1
        - .env.flavor2
        - .env.flavor3
      - web
        - .env.flavor1
        - .env.flavor2
        - .env.flavor3
    ```
1. The merging of the environment variables is done so that the more specific environment variable overrides the less specific environment variable. Don't forget to add the folders as assets to your `pubspec.yaml` file.
1. The variables can now be accessed using the `flutter_dotenv` package.

