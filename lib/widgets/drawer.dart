import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_view_model_example/service_locator.dart';

class AppDrawer extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Colors.blue,
            child: const DrawerHeader(
              child: Center(
                child: Text(
                  "Riverpod ViewModel Example",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          _RouterTile(
            title: "Counter",
            route: "/counter",
            icon: Icon(Icons.numbers),
          ),
          _RouterTile(
            title: "Preferences",
            route: "/preferences",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

class _RouterTile extends HookConsumerWidget {
  final String title;
  final String route;
  final Widget icon;
  
  _RouterTile({
    required this.title,
    required this.route,
    required this.icon,
  });
 
  @override
  
  Widget build(BuildContext context, WidgetRef ref) {
    final String location = App.router.getCurrentLocation();
    return ListTile(
      leading: icon,
      tileColor: location.contains(route) ? Theme.of(context).highlightColor : null,
      title: Text(title),
      onTap: () {
        App.router.go(route);
      },
    );
  }
}
