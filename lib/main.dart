import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guomobile/apptheme/theme.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/providers/validations/validation.dart';
import 'package:guomobile/screens/auth/signup/verificationsuccess.dart';
import 'package:guomobile/screens/onboarding/splashscreen.dart';
import 'package:guomobile/services/accountbloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  runApp(const GuoLaunch());
}

class GuoLaunch extends StatefulWidget {
  const GuoLaunch({Key? key}) : super(key: key);

  @override
  State<GuoLaunch> createState() => _GuoLaunchState();
}

class _GuoLaunchState extends State<GuoLaunch> {
  @override
  Widget build(BuildContext context) {
    return const GuoLaunch2();
  }
}

class GuoLaunch2 extends StatefulWidget {
  static final navKey = GlobalKey<NavigatorState>();
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  static _GuoLaunch2State? of(BuildContext context) =>
      context.findAncestorStateOfType<_GuoLaunch2State>();
  const GuoLaunch2({Key? key}) : super(key: key);

  @override
  State<GuoLaunch2> createState() => _GuoLaunch2State();
}

class _GuoLaunch2State extends State<GuoLaunch2> {
  ThemeMode myTheme = ThemeMode.light;
  bool isLight = true;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: GuoLaunch2.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ProviderBloc>(
                create: (context) => ProviderBloc()),
            ChangeNotifierProvider<AccountBloc>(
                create: (context) => AccountBloc()),
            ChangeNotifierProvider<ValidationBloc>(
                create: (context) => ValidationBloc()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: GuoLaunch2.navKey,
            themeMode: myTheme,
            darkTheme: AppTheme.darkMode,
            theme: AppTheme.lightMode,
            home: Vsuccess(),
          ),
        );
      },
    );
  }

  void changeTheme(ThemeMode tMode) {
    setState(() {
      myTheme = tMode;
    });
  }
}
