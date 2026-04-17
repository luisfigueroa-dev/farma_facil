import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/pos/pos_screen.dart';
import '../screens/productos/productos_screen.dart';
import '../screens/inventario/inventario_screen.dart';
import '../screens/recetas/recetas_screen.dart';
import '../screens/reportes/reportes_screen.dart';
import '../screens/configuracion/configuracion_screen.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    PosScreen(),
    ProductosScreen(),
    InventarioScreen(),
    RecetasScreen(),
    ReportesScreen(),
    ConfiguracionScreen(),
  ];

  final List<NavigationItem> _navigationItems = const [
    NavigationItem(icon: Icons.dashboard, label: 'Dashboard'),
    NavigationItem(icon: Icons.point_of_sale, label: 'POS'),
    NavigationItem(icon: Icons.inventory_2, label: 'Productos'),
    NavigationItem(icon: Icons.warehouse, label: 'Inventario'),
    NavigationItem(icon: Icons.medical_services, label: 'Recetas'),
    NavigationItem(icon: Icons.bar_chart, label: 'Reportes'),
    NavigationItem(icon: Icons.settings, label: 'Configuración'),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: MediaQuery.of(context).size.width > 1200,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Icon(
                    Icons.local_pharmacy,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  if (MediaQuery.of(context).size.width > 1200)
                    Text(
                      'FarmaFacil',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                ],
              ),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        child: Text(
                          authState.usuario?.username.substring(0, 1).toUpperCase() ?? 'U',
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (MediaQuery.of(context).size.width > 1200)
                        Text(
                          authState.usuario?.username ?? 'Usuario',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          ref.read(authProvider.notifier).logout();
                        },
                        tooltip: 'Cerrar Sesión',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            destinations: _navigationItems
                .map((item) => NavigationRailDestination(
                      icon: Icon(item.icon),
                      label: Text(item.label),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  const NavigationItem({required this.icon, required this.label});
}