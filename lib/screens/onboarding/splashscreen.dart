import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/providers/sharedstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../../providers/callfunctions/providerbloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  // Provider.of<LocalStorageBloc>(context,listen: false).refreshapp();
    runSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        ImageClass.splash,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,

      ),
    );
  }

  runSplash() {
    Provider.of<ProviderBloc>(context, listen: false).getUserStatus(context);
  }
}
