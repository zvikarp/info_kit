# info_kit

Provides all the basic info about your application.

## Installation

```bash
flutter pub add info_kit
```

## Usage

Here are the main "features" of the package:

### Flavor
Provides access to the current flavor of the application. The flavor it must be defined as a build argument `flutter run --dart-define=flavor=<flavor>`, and NOT using the `--flavor` flag, because that flag is not accessible in web builds. There is a default list of flavors that can be used, but you can add more or create your own.

### Size
To get the screen size, wrap the root of your project with a `LayoutBuilder` and use the `constraints` property to get the size.
  ```dart
  LayoutBuilder(
    builder: (context, constraints) {
      InfoKit.setSize(constraints.maxWidth, constraints.maxHeight);
      return Text('${constraints.maxWidth} x ${constraints.maxHeight}');
    },
  );
  ```
The returned size by the `size` getter is one from a list of predefined sizes. There is a default list of sizes that can be used, but you can add more or create your own.

### Env
Set different environment variables for different flavors and different flavors!

The file structure should look like this:
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

The merging of the environment variables is done so that the more specific environment variable overrides the less specific environment variable. Don't forget to add the folders as assets to your `pubspec.yaml` file.

The variables can now be accessed using the `InfoKit.env` getter.

### PlatformData
This class allows you to simply define variables based on the platform you are on, for example:
  ```dart
  bool showBackButton = InfoPlatformData(
    fallback: true,
    android: false,
    web: false,
  ).value;
  ```

### Examples
Here are small examples that show you how to use the package.

#### Initialization

```dart
InfoKit.init({
  flavorEnabled: true,
  List<InfoFlavor> flavors = DefaultInfoFlavor.flavors,
  InfoFlavor fallbackFlavor = DefaultInfoFlavor.fallbackFlavor,
  String flavorEnvKey = DefaultInfoFlavor.flavorEnvKey,
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

// size of the device, based on a list of supported sizes.
InfoSize size = InfoKit.size;

// origin url on web platform, otherwise an empty string.
String origin = InfoKit.origin;

// device's language.
Locale locale = InfoKit.locale;

// device platform, (ios app, web app, desktop app), etc.
InfoPlatform platform = InfoKit.platform;

// device's operating system.
InfoOS os = InfoKit.os;

// build flavor.
InfoFlavor flavor = InfoKit.flavor;

// if release build or debug.
InfoMode mode = InfoKit.mode;

int buildNumber = InfoKit.buildNumber;

String version = InfoKit.version;

String packageName = InfoKit.packageName;

String appName = InfoKit.appName;

```

