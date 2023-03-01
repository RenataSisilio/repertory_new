import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/category.dart';
import '../../../models/song.dart';
import 'category_states.dart';

class CategoryController extends Cubit<CategoryState> {
  CategoryController(this.categories, this.songs)
      : super(LoadingCategoryState());

  final List<Category> categories;
  final List<Song> songs;

  void select(String category) {
    emit(LoadingCategoryState());
    try {
      List<Song> selected = [];
      if (categories.any((cat) => cat.name == category)) {
        final cat = categories.firstWhere((cat) => cat.name == category);
        selected = songs
            .where((song) => song.categories.fold(false,
                (previous, test) => previous || cat.subcats.contains(test)))
            .toList();
      } else {
        selected =
            songs.where((song) => song.categories.contains(category)).toList();
      }
      emit(SuccessCategoryState(selected));
    } catch (e) {
      emit(ErrorCategoryState());
    }
  }
}
