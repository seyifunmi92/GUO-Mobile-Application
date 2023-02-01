import 'package:flutter/material.dart';
import 'package:guomobile/main.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  Provider.of<ProviderBloc>(context, listen: false)
                      .setDarkTheme(context);
                  print(GuoLaunch2.of(context)!.isDark);
                });
              },
              child: Text("DarkMode"),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  Provider.of<ProviderBloc>(context, listen: false)
                      .setLightTheme(context);
                });
              },
              child: Text("LightMode"),
            )
          ],
        ),
      ),
    );
  }
}
