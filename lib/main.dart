import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fridgeroney/models/auth_model.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:fridgeroney/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final List<CameraDescription> cameras = await availableCameras();
  final CameraDescription mainCam = cameras.first;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthModel>(create: (_) => AuthModel()),
        ChangeNotifierProvider<IngredientModel>(
            create: (_) => IngredientModel()),
      ],
      child: MyApp(mainCamera: mainCam),
    ),
  );
}

class MyApp extends StatelessWidget {
  static late CameraDescription mainCam;

  MyApp({super.key, mainCamera}) {
    mainCam = mainCamera;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Consumer<AuthModel>(builder: (_, auth, __) {
        if (auth.isSignedIn) {
          debugPrint("User Is Logged In!");
          return const HomePage();
        } else {
          debugPrint("User Is Not Logged In");
          return const LoginPage();
        }
      }),
    );
  }
}
