class AppConstants {
  static const String appName = 'FarmaFacil';
  static const double ivaPorcentaje = 13.0;
  static const String currencySymbol = 'Bs.';
  
  static const int minWidth = 1280;
  static const int minHeight = 720;
  
  static const Duration sessionTimeout = Duration(hours: 8);
}

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String pos = '/pos';
  static const String productos = '/productos';
  static const String inventario = '/inventario';
  static const String recetas = '/recetas';
  static const String reportes = '/reportes';
  static const String configuracion = '/configuracion';
}