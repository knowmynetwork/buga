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
 static String addDriverRoutes = "/api/v1/Component/AddDriverRoute/driver-routes"; // POST
 static String editDriverRoutes = "/api/v1/Component/EditDriverRoute/driver-routes/{id}"; // PATCH
 static String deleteDriverRoutes = "/api/v1/Component/DeleteDriverRoute/driver-routes/{id}"; // DELETE
 static String getDriverRoutes = "/api/v1/Component/GetMyDriverRoutes/driver-routes"; // GET
 static String addDriverRoutesithAddress = "/api/v1/Component/AddDriverRouteWithAddresses/driver-routes/with-addresses"; // POST

 static String getSavedAddress = "/api/v1/Component/GetSavedAddresses"; // GET
 static String addSavedAddress = "/api/v1/Component/AddSavedAddress"; // POST
 static String deleteSavedAddress = "/api/v1/Component/DeleteSavedAddress/{addressId}"; // DELETE
 static String editSavedAddress = "/api/v1/Component/EditSavedAddress/{addressId}"; // PATCH

}
