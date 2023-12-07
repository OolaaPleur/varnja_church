/// Class for exception, that could be in app.
/// IMPORTANT: NAMING CONVENTION: class name should be part of l10n string
/// key, e.g. 'snackbarCantFetchBoltScootersData' exception is
/// [CantFetchBoltScootersData].
class AppException implements Exception {
  /// Constructor for [AppException].
  const AppException();
}
/// Define a constant for default [AppException] object.
const noException = AppException();

// /// Exception that is thrown when Bolt scooters data can not be downloaded.
// class CantFetchBoltScootersData implements AppException {
//   /// Constructor for [CantFetchBoltScootersData].
//   const CantFetchBoltScootersData();
// }
