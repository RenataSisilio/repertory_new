import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/repository.dart';
import 'home_states.dart';

class HomeController extends Cubit<HomeState> {
  HomeController({required this.repository, required this.firebaseAuth})
      : super(LoadingHomeState()) {
    _get();
  }

  final Repository repository;
  final FirebaseAuth firebaseAuth;

  Future<void> _get() async {
    emit(LoadingHomeState());
    try {
      final uid = firebaseAuth.currentUser!.uid;
      final categories = await repository.getCategories(uid);
      final songs = await repository.getSongs(uid);
      emit(SuccessHomeState(songs, categories));
      // emit(SuccessHomeState([], categories));
    } catch (e) {
      emit(ErrorHomeState());
    }
  }
}
