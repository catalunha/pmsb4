
List<Middleware<AppState>> createAuthMiddleware(){
final login = _createLoginMiddleware();
final logout = _createLogoutMiddleware();

return combineTy
}