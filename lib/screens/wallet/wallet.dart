import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guomobile/asset/imageclass.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/appbars/appbar.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/forgotpassword/resetpass.dart';
import 'package:provider/provider.dart';
import '../../../hooks/buttons/buttons.dart';
import '../../../hooks/dialog/showmessage.dart';
import '../../../hooks/text/text.dart';
import '../../../providers/callfunctions/providerbloc.dart';
import '../../../services/accountbloc.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: guoAppBar(context, "My Wallet"),

      bottomNavigationBar: bottomNavDash(context, isWallet: true),
    );
  }
}
