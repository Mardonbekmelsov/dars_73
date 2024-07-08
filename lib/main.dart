
import 'package:dars_73/controllers/location_controller.dart';
import 'package:dars_73/firebase_options.dart';
import 'package:dars_73/services/location_service.dart';
import 'package:dars_73/views/screens/main_screen.dart';
import 'package:dars_73/views/screens/warning_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await LocationServices.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return LocationController();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LocationServices.permissionStatus == PermissionStatus.granted? MainScreen():const WarningScreen(),
      ),
    );
  }
}