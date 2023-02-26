import '../../models/category.dart';
import '../../models/song.dart';

abstract class HomeState {}

class LoadingHomeState extends HomeState {}

class SuccessHomeState extends HomeState {
  final List<Song> songs;
  final List<Category> categories;

  SuccessHomeState(this.songs, this.categories);
}

class ErrorHomeState extends HomeState {}
