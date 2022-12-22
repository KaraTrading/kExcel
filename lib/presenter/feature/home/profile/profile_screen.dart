import 'package:flutter/material.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/feature/home/profile/profile_bloc.dart';
import 'package:kexcel/presenter/feature/login/login_screen.dart';

import 'profile_bloc_event.dart';

class ProfileScreen extends BaseScreen<ProfileBloc> {
  const ProfileScreen({super.key});

  @override
  AppBar? get appBar => AppBar();

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            children: [
              menuItem('Edit Personal Information', () {}, isFirstItem: true),
              menuItem('title2', () {}),
              menuItem('title3', () {}),
            ],
          ),
        ),
        Column(
          children: [
            TextButton(
                onPressed: () {
                  callEvent(ProfileEventLogout());
                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () => _routeLogin(context),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Logout'),
                )),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Version: 1.0.0'),
            )
          ],
        )
      ],
    );
  }

  _routeLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}

Widget menuItem(String title, Function() onPressed,
    {IconData? iconData, bool? isFirstItem}) {
  return Column(
    children: [
      if (isFirstItem != true)
        const Divider(
          height: 0.5,
          indent: 80,
          endIndent: 80,
        ),
      TextButton(
          onPressed: () => onPressed.call(),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text(title)),
            ),
          )),
    ],
  );
}
