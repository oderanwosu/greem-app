import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greem/widgets/navbar_item.dart';

class DashboardScreen extends StatefulWidget {
  Widget child;
  DashboardScreen({required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        onTap: (index) => _onItemTapped(context, index),
        currentIndex: _currentIndex,
      ),
    );
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);
  List<ScaffoldWithNavBarTabItem> tabs = [
    const ScaffoldWithNavBarTabItem(
      icon: Icon(Icons.message),
      label: 'Conversations',
      initialLocation: '/conversations',
    ),
    const ScaffoldWithNavBarTabItem(
      icon: Icon(Icons.person),
      label: 'Friends',
      initialLocation: '/friends',
    ),
    const ScaffoldWithNavBarTabItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
      initialLocation: '/settings',
    ),
  ];

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    }
  }
}
