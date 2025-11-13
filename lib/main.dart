import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'models/task.dart';
import 'screens/login_screen.dart';
import 'screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Back4App
  const keyApplicationId = 'jGviDrINsL2D2AnqjsLl41eVkPIzxrBsRK0ZY8ZU';
  const keyClientKey = 'AlVtl75qiKBbakStqK4YCoqinwmrb9zT0sQFoxSv';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: true,
    registeredSubClassMap: <String, ParseObjectConstructor>{
      'Task': () => Task(),
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: const Color(0xFFE0E5EC),
        lightSource: LightSource.topLeft,
        depth: 8,
        intensity: 0.65,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: const Color(0xFF2E3239),
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.6,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const AuthCheck(),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    setState(() {
      _isLoggedIn = user != null;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: Center(
          child: NeumorphicProgressIndeterminate(),
        ),
      );
    }

    return _isLoggedIn ? const TaskListScreen() : const LoginScreen();
  }
}
