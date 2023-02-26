import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repertory_new/services/repository.dart';

import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController({required this.repository, required this.firebaseAuth})
      : super(LoadingHomeState()) {
    get();
  }

  final Repository repository;
  final FirebaseAuth firebaseAuth;

  Future<void> get() async {
    emit(LoadingHomeState());
    try {
      final uid = firebaseAuth.currentUser!.uid;
      final categories = await repository.getCategories(uid);
      final songs = await repository.getSongs(uid);
      emit(SuccessHomeState(songs, categories));
    } catch (e) {
      emit(ErrorHomeState());
    }
  }
}
