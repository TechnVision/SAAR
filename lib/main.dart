import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myapp.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseSetUp();
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

firebaseSetUp() async {
  try {
    await Firebase.initializeApp(
      options: Platform.isAndroid
          ? const FirebaseOptions(
              apiKey: 'AIzaSyBc97PEtwh429lhxw_JmyScK0PB1EcsWtU',
              appId: '1:943405664949:android:ff95b2c7f433fce2608cfc',
              messagingSenderId: '943405664949',
              projectId: 'saar-7faab',
            )
          : const FirebaseOptions(
              apiKey: 'AIzaSyCvmf8fMZ2niI1kLuc6ThWkhE6ttWscsCY',
              appId: '1:943405664949:android:ff95b2c7f433fce2608cfc',
              messagingSenderId: '943405664949',
              projectId: 'saar-7faab',
            ),
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      return null;
    } else {
      rethrow;
    }
  } catch (e) {
    rethrow;
  }
}
