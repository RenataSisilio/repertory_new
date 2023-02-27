import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import '../firebase_options.dart';
import '../modules/home/home_controller.dart';
import 'firebase_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencyInjection() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'renatasisilio.arca@gmail.com', password: '123456');
  getIt.registerSingleton<FirebaseRepository>(
    FirebaseRepository(FirebaseFirestore.instance),
  );
  getIt.registerSingleton<HomeController>(
    HomeController(
        firebaseAuth: FirebaseAuth.instance,
        repository: getIt.get<FirebaseRepository>()),
  );
}
