import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/home/profile/profile_bloc.dart';
import 'package:kexcel/presenter/feature/login/login_screen.dart';
import 'package:kexcel/presenter/utils/app_colors.dart';
import 'package:kexcel/presenter/widget/app_button_widget.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'profile_bloc_event.dart';

class ProfileScreen extends BaseScreen<ProfileBloc> {
  const ProfileScreen({super.key});

  @override
  AppBar? get appBar => AppBar(title: Text('profile'.translate));

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(ProfileEventInit());
    return DataLoadBlocBuilder<ProfileBloc, UserEntity?>(
        noDataView: const NoItemWidget(),
        bloc: getBloc,
        builder: (BuildContext context, UserEntity? user) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: colorGreyLite,
                height: 33,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: colorGreyLite,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 33,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                foregroundImage: AssetImage(
                                  getBloc.company!.logoAssetsAddress,
                                ),
                              ),
                              Text(getBloc.user?.name ?? ''),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    menuItem('Edit Profile', () {}, isFirstItem: true),
                    menuItem('About ${getBloc.appName}', () {}),
                    menuItem('Contact', () {}),
                  ],
                ),
              ),
              Column(
                children: [
                  AppButtonWidget('Logout', () {
                    callEvent(ProfileEventLogout());
                    Future.delayed(
                      const Duration(milliseconds: 50),
                      () => _routeLogin(context),
                    );
                  }, iconData: Icons.output_rounded, color: Colors.red),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Version: ${getBloc.version}',
                      style: TextStyle(color: textCaptionColor, fontSize: 10),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  _routeLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}

Widget menuItem(
  String title,
  Function() onPressed, {
  IconData? iconData,
  bool? isFirstItem,
}) {
  return Column(children: [
    if (isFirstItem != true)
      const Divider(
        height: 0.5,
        indent: 80,
        endIndent: 80,
      ),
    AppButtonWidget(title, () => onPressed, width: double.infinity)
  ]);
}