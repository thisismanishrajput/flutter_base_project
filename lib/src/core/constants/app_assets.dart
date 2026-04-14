/// Centralized asset paths for the application.
///
/// Add all image/icon/lottie/font references here and consume constants
/// instead of hardcoded strings in feature code.
class AppAssets {
  const AppAssets._();

  // Keep all image/vector/lottie/font paths centralized here.
  // Add files under assets/ and reference constants instead of hardcoded paths.
  static const String imagesPath = 'assets/images';
  static const String iconsPath = 'assets/icons';
  static const String lottiePath = 'assets/lottie';

  static const String placeholderImage = '$imagesPath/placeholder.png';
}
