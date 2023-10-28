class ApiEndPoints {
  static final String baseUrl = 'http://restapi.**.com/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerPhone = 'authaccount/registration';
  final String loginPhone = 'authaccount/login';
}