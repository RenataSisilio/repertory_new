import '../models/category.dart';
import '../models/song.dart';

abstract class Repository {
  Future<void> createCategory(String uid, Category category);
  Future<void> createLib(String uid);
  Future<void> createSong(String uid, Song song);
  Future<void> editCategory(String uid, Category category, {String? oldName});
  Future<void> editSong(String uid, Song song);
  Future<void> exportLib({
    required String name,
    required List<Category> categories,
    required List<Song> songs,
  });
  Future<List<Category>> getCategories(String uid);
  Future<List<Song>> getSongs(String uid);
  Future<void> importLib(String uid, String name);
  void initialize();
}
