import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart';
import '../models/song.dart';
import 'repository.dart';

class FirebaseRepository implements Repository {
  late final FirebaseFirestore? firestore;

  FirebaseRepository() {
    initialize();
  }

  @override
  Future<void> createCategory(String uid, Category category) async {
    try {
      await firestore!
          .collection('users')
          .doc(uid)
          .collection('categories')
          .doc(category.name)
          .set({'subcats': category.subcats});
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  Future<void> createLib(String uid) async {
    try {
      await firestore!.collection('users').doc(uid).set({});
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  Future<void> createSong(String uid, Song song) async {
    try {
      final map = song.toMap();
      map.remove('id');
      await firestore!
          .collection('users')
          .doc(uid)
          .collection('songs')
          .add(map);
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  Future<void> editCategory(
    String uid,
    Category category, {
    String? oldName,
  }) async {
    try {
      if (oldName == null) {
        await firestore!
            .collection('users')
            .doc(uid)
            .collection('categories')
            .doc(category.name)
            .set({'subcats': category.subcats});
      } else {
        await firestore!
            .collection('users')
            .doc(uid)
            .collection('categories')
            .doc(category.name)
            .set({'subcats': category.subcats});
        await firestore!
            .collection('users')
            .doc(uid)
            .collection('categories')
            .doc(oldName)
            .delete();
      }
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  Future<void> editSong(String uid, Song song) async {
    try {
      final data = song.toMap();
      data.remove('id');
      await firestore!
          .collection('users')
          .doc(uid)
          .collection('songs')
          .doc(song.id)
          .update(data);
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  Future<void> exportLib({
    required String name,
    required List<Category> categories,
    required List<Song> songs,
  }) async {
    try {
      final data = <String, dynamic>{};
      data.addAll(
        {
          'categories': categories.map((element) => element.toJson()).toList(),
          'songs': songs.map((element) => element.toJson()).toList(),
        },
      );
      await firestore!.collection('libs').doc(name).set(data);
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories(String uid) async {
    try {
      final snapshot = await firestore!
          .collection('users')
          .doc(uid)
          .collection('categories')
          .get();
      final docs = snapshot.docs;
      final categories = <Category>[];
      for (var doc in docs) {
        final data = doc.data();
        data.addAll({'name': doc.id});
        categories.add(Category.fromMap(data));
      }
      return categories;
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  Future<List<Song>> getSongs(String uid) async {
    try {
      final snapshot = await firestore!
          .collection('users')
          .doc(uid)
          .collection('songs')
          .orderBy('title')
          .get();
      final docs = snapshot.docs;
      final songs = <Song>[];
      for (var doc in docs) {
        final data = doc.data();
        data.addAll({'id': doc.id});
        songs.add(Song.fromMap(data));
      }
      return songs;
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  Future<void> importLib(String uid, String name) async {
    try {
      final snapshot = await firestore!.collection('libs').doc(name).get();
      final data = snapshot.data()!;
      final categories =
          (data['categories'] as List<String>).map((e) => Category.fromJson(e));
      final currentCategories = await getCategories(uid);
      for (var category in categories) {
        if (currentCategories.any((e) => e.name == category.name)) {
          final newSubcats = currentCategories
              .firstWhere((e) => e.name == category.name)
              .subcats;
          for (var other in category.subcats) {
            if (!newSubcats.contains(other)) {
              newSubcats.add(other);
            }
          }
          await editCategory(uid, category.copyWith(subcats: newSubcats));
        } else {
          await createCategory(uid, category);
        }
      }
      final songs = data['songs'] as List<String>;
      for (var element in songs) {
        final song = Song.fromJson(element);
        await createSong(uid, song);
      }
    } catch (e) {
      if (firestore == null) {
        throw Exception("Firestore isn't initialized");
      }
      rethrow;
    }
  }

  @override
  void initialize() {
    try {
      firestore = FirebaseFirestore.instance;
    } catch (e) {
      if (firestore == null) {
        rethrow;
      } else {
        log('Firestore already initialized');
      }
    }
  }
}
