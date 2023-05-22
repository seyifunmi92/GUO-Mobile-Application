import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/containers/container.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:guomobile/screens/auth/changepassword/changepass.dart';
import 'package:guomobile/screens/settings/paymentsettings.dart';
import 'package:provider/provider.dart';

import '../../hooks/appbars/appbar.dart';
import 'notification.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: guocolor.offWhite,
      appBar: guoAppBar(context, "Settings", showElevation: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
        child: Column(
          children: [
            sbHeight(mqHeight(context, .03)),
            containSet(
              context,
              "Password",
              "Update your password",
              Icons.lock_outline,
              onT: () => mynextScreen(context, ChangePass()),
            ),
            sbHeight(mqHeight(context, .017)),
            containSet(context, "Notifications",
                "Change your notification preferences", Icons.notifications,
                onT: () => mynextScreen(context, Not())),
            sbHeight(mqHeight(context, .017)),
            containSet(
              context,
              "Payment Validations",
              "Change your payment preferences",
              Icons.credit_card_outlined,
              onT: () => Provider.of<ProviderBloc>(context, listen: false)
                  .showPaymentDialog(context),
            ),
            sbHeight(mqHeight(context, .017)),
            containSet(context, "Help", "Reach out to us", Icons.help_outlined),
          ],
        ),
      ),
    );
  }
}
