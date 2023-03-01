import '../../../models/song.dart';

abstract class CategoryState {}

class LoadingCategoryState extends CategoryState {}

class SuccessCategoryState extends CategoryState {
  final List<Song> songs;

  SuccessCategoryState(this.songs);
}

class ErrorCategoryState extends CategoryState {}
