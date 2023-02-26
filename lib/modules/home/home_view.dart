import 'package:flutter/material.dart';

import '../../services/get_it.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories =
        (getIt.get<HomeController>().state as SuccessHomeState).categories;
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        var myExpansionTile = ExpansionTile(
          title: Text(categories[index].name),
          children: [
            ListTile(
              title: const Text('Todas'),
              onTap: () {},
            ),
          ],
        );
        for (var sub in categories[index].subcats) {
          myExpansionTile.children.add(
            ListTile(
              title: Text(sub),
              onTap: () {},
            ),
          );
        }
        return myExpansionTile;
      },
    );
  }
}
