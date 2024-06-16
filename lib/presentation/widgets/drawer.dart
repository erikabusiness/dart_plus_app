import 'package:auto_route/auto_route.dart';
import 'package:dart_plus_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/user_data.dart';
import 'clickable_text.dart';

class DrawerWidget extends StatelessWidget {
  final String? userName;
  final String? userEmail;

  const DrawerWidget({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size(100, 100),
            currentAccountPicture: Image.asset("assets/logo.png"),
            accountName: Text(userName!,
                style: const TextStyle(
                  fontSize: 18,
                )),
            accountEmail: Text(userEmail!),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: ClickableText(
              text: 'Sair',
              onClick: () {
                context.read<UserData>().updateUser("", "");
                context.pushRoute(const LoginRoute());
              },
            ),
          ),
        ],
      ),
    );
  }
}
