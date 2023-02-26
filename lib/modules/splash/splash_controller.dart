import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repertory_new/services/get_it.dart';

enum SplashState { loading, logged, unlogged }

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashState.loading) {
    initializeDependencyInjection().then(
      (_) => emit(FirebaseAuth.instance.currentUser == null
          ? SplashState.unlogged
          : SplashState.logged),
    );
  }
}
