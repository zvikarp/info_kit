import 'package:info_kit/info_kit.dart';

class DefaultInfoFlavor {
  static const List<InfoFlavor> flavors = [
    InfoFlavor('dev'),
    InfoFlavor('qa'),
    InfoFlavor('staging'),
    InfoFlavor('prod'),
  ];

  static const String flavorEnvKey = 'flavor';
  static const InfoFlavor fallbackFlavor = InfoFlavor('prod');
}
