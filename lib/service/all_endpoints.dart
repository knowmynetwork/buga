class Endpoints {
  static String baseUrl =
      'https://buga-travels-api-d7buhygga5b4fcfm.uksouth-01.azurewebsites.net';
  static String loginEndpoint = '$baseUrl/api/v1/Authentication/SignIn';
  static String driverSignUp = '$baseUrl/api/v1/Authentication/DriverSignup';
  static String passengerSignUp =
      '$baseUrl/api/v1/Authentication/PassengerSignup';
  static String getEmailOtp =
      '$baseUrl/api/v1/Authentication/GenerateEmailConfirmationToken';
  static String confirmEmailOtp =
      '$baseUrl/api/v1/Authentication/ConfirmEmailToken';
  static String organizationEndpoint =
      '$baseUrl/api/v1/Component/GetOrganizations';
  static String estateEndpoint = '$baseUrl/api/v1/Component/GetEstates';
  static String universitiesEndpoint =
      '$baseUrl/api/v1/Component/GetUniversities';

  // Driver
  static String addDriverRoutes =
      "$baseUrl/api/v1/Component/AddDriverRoute"; // POST
  static String editDriverRoutes =
      "$baseUrl/api/v1/Component/EditDriverRoute/{id}"; // PATCH
  static String deleteDriverRoutes =
      "$baseUrl/api/v1/Component/EditDriverRoute/{id}"; // DELETE
  static String getDriverRoutes =
      "$baseUrl/api/v1/Component/GetMyDriverRoutes"; // GET
  static String addDriverRoutesithAddress =
      "$baseUrl/api/v1/Component/AddDriverRouteWithAddresses"; // POST

  static String getSavedAddress =
      "$baseUrl/api/v1/Component/GetSavedAddresses"; // GET
  static String addSavedAddress =
      "$baseUrl/api/v1/Component/AddSavedAddress"; // POST
  static String deleteSavedAddress =
      "$baseUrl/api/v1/Component/DeleteSavedAddress/"; // DELETE
  static String editSavedAddress =
      "$baseUrl/api/v1/Component/EditSavedAddress/{addressId}"; // PATCH
}
