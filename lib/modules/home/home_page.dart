import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/get_it.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder(
            bloc: getIt.get<HomeController>(),
            builder: (context, state) {
              if (state is ErrorHomeState) {
                return const Center(child: Text('Erro'));
              }
              if (state is SuccessHomeState) {
                final categories = state.categories;
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    var myExpansionTile = ExpansionTile(
                      title: Text(categories[index].name),
                      children: [
                        ListTile(
                          title: const Text('Todas'),
                          onTap: () {
                            
                          },
                        ),
                      ],
                    );
                    for (var sub in categories[index].subcats) {
                      myExpansionTile.children.add(
                        ListTile(
                          title: Text(sub),
                          onTap: () {
                            
                          },
                        ),
                      );
                    }
                    return myExpansionTile;
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Nova música',
        child: const Icon(Icons.add),
      ),
    );
  }
}
