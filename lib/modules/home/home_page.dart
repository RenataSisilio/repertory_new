import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/get_it.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      body: BlocBuilder(
        bloc: getIt.get<HomeController>(),
        builder: (context, state) {
          if (state is ErrorHomeState) {
            return const Center(child: Text('Erro'));
          }
          if (state is SuccessHomeState) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar.medium(
                  title: const Text('Meu Repertório'),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ],
              body: PageView(
                controller: pageController,
                children: const [
                  HomeView(),
                  Center(child: Text('Favorites')),
                  Center(child: Text('Lists')),
                  Center(child: Text('Settings')),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Nova música',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: pageController,
        builder: (context, _) => NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Lists',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          selectedIndex: pageController.positions.isNotEmpty
              ? pageController.page!.floor()
              : 0,
          onDestinationSelected: (value) => pageController.jumpToPage(value),
          animationDuration: const Duration(milliseconds: 300),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
      ),
    );
  }
}
