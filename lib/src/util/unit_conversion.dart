/// Unit Distance Conversion
extension UnitConversions on num {
  /// Metric Units
  double get millimetersToMeters => this / 1000.0;

  /// Meter To Millimeters
  double get metersToMillimeters => this * 1000.0;

  /// Centimeter to Meters
  double get centimetersToMeters => this / 100.0;

  /// Metres to Centimeters
  double get metersToCentimeters => this * 100.0;

  /// Decimeters to Meters
  double get decimetersToMeters => this / 10.0;

  /// Meters to Decimeters
  double get metersToDecimeters => this * 10.0;

  /// Kilometers to Meters
  double get kilometersToMeters => this * 1000.0;

  /// Meters to Kilometers
  double get metersToKilometers => this / 1000.0;

  /// Imperial Units

  /// Inches to Centimeters
  double get inchesToCentimeters => this * 2.54;

  /// Centimeters to Inches
  double get centimetersToInches => this / 2.54;

  /// Feet to Meters
  double get feetToMeters => this * 0.3048;

  /// Meters to Feet
  double get metersToFeet => this / 0.3048;

  /// Yards to Meters
  double get yardsToMeters => this * 0.9144;

  /// Meters to Yards
  double get metersToYards => this / 0.9144;

  /// Miles to KiloMeters
  double get milesToKilometers => this * 1.60934;

  /// KiloMeters to Miles
  double get kilometersToMiles => this / 1.60934;

  /// Nautical Units

  /// Nautical Miles to Kilometers
  double get nauticalMilesToKilometers => this * 1.852;

  /// Kilometers to Nautical Miles
  double get kilometersToNauticalMiles => this / 1.852;

  /// Astronomical Units

  /// Astronomical to Meters
  double get astronomicalUnitsToMeters => this * 149597870700.0;

  /// Meters to Astronomical
  double get metersToAstronomicalUnits => this / 149597870700.0;

  /// Light Years

  /// Light Years to Meters
  double get lightYearsToMeters => this * 9.461e15;

  /// Meters to Light Years
  double get metersToLightYears => this / 9.461e15;

  /// Parsecs

  /// Parsecs To Meters
  double get parsecsToMeters => this * 3.086e16;

  /// Meters to Parsecs
  double get metersToParsecs => this / 3.086e16;

  /// Micrometers To Meters
  double get micrometersToMeters => this / 1e6;

  /// Meters To Micrometers
  double get metersToMicrometers => this * 1e6;

  /// NanoMeters To Meters
  double get nanometersToMeters => this / 1e9;

  /// Meters To Nanometers
  double get metersToNanometers => this * 1e9;

  /// Picometers To Meters
  double get picometersToMeters => this / 1e12;

  ///Meters to PicoMeters
  double get metersToPicometers => this * 1e12;

  /// Femtometers To Meters
  double get femtometersToMeters => this / 1e15;

  /// Meters To FemtoMeters
  double get metersToFemtometers => this * 1e15;

  /// Attometers To Meters
  double get attometersToMeters => this / 1e18;

  /// Meters To Attometers
  double get metersToAttometers => this * 1e18;

  /// Square Meters to Square Kilometers
  double get squareMetersToSquareKilometers => this / 1e6;

  /// Square KiloMeters to Square Meters
  double get squareKilometersToSquareMeters => this * 1e6;

  /// Meters To Square Kilometers
  double get metersToSquareKilometers => this * this / 1e6;
}


// void main() {
//   double distanceInMeters = 5000.0;
//   print('Distance in meters: $distanceInMeters');
//   print('Distance in kilometers: ${distanceInMeters.metersToKilometers}');
//   print('Distance in centimeters: ${distanceInMeters.metersToCentimeters}');
// }
