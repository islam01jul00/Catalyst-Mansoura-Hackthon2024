import 'package:flutter/material.dart';
import 'package:gdg_app/app.dart';
import 'package:gdg_app/core/cached_helper/secure_cache.dart';
import 'package:gdg_app/core/utils/locator.dart';
// import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CachedSecure.init();
  setup();
  // await Hive.initFlutter();
  // Hive.registerAdapter(CachedSecureAdapter());
  // await Hive.openBox('testBox');
  runApp(const MyApp());
}
