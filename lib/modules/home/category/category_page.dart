import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/get_it.dart';
import '../home_controller.dart';
import '../home_states.dart';
import 'category_controller.dart';
import 'category_states.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage(this.category, {super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    final homeState = getIt.get<HomeController>().state as SuccessHomeState;
    final controller =
        CategoryController(homeState.categories, homeState.songs);
    controller.select(category);
    return Scaffold(
      body: BlocBuilder(
        bloc: controller,
        builder: (context, state) {
          if (state is ErrorCategoryState) {
            return const Center(child: Text('Erro'));
          }
          if (state is SuccessCategoryState) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar.medium(title: Text(category)),
              ],
              body: SingleChildScrollView(
                child: Column(
                  children: List.from(
                    state.songs.map(
                      (e) {
                        return ListTile(
                          title: Text(e.title),
                          subtitle: Text(e.categories.join(', ')),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
