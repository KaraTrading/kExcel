import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/home/home_screen.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'login_bloc.dart';
import 'login_bloc_event.dart';

class LoginScreen extends BaseScreen<LoginBloc> {
  final UserEntity? user;

  const LoginScreen({this.user, super.key});

  @override
  AppBar? get appBar =>
      user != null ? AppBar(title: Text('editProfile'.translate)) : null;

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(LoginEventInit(user));
    return DataLoadBlocBuilder<LoginBloc, List<CompanyEntity>?>(
        noDataView: const NoItemWidget(),
        bloc: getBloc,
        builder: (BuildContext context, List<CompanyEntity>? entities) {
          Future.delayed(const Duration(milliseconds: 50), () {
            if (getBloc.isEditProfile == false && getBloc.user != null) {
              _routeHome(context);
            }
          });
          final TextEditingController nameController =
              TextEditingController(text: getBloc.user?.name);
          final TextEditingController titleController =
              TextEditingController(text: getBloc.user?.title);
          final TextEditingController emailController =
              TextEditingController(text: getBloc.user?.email);
          CompanyEntity? company;
          if (getBloc.user != null) {
            company = getBloc.companies
                .firstWhere((element) => element.id == getBloc.user!.companyId);
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'fullName'.translate,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'jobTitle'.translate,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'email'.translate,
                    ),
                  ),
                  const SizedBox(height: 25),
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 4),
                      border: const OutlineInputBorder(gapPadding: 1),
                      labelText: 'company'.translate,
                    ),
                    child: Autocomplete(
                      initialValue: TextEditingValue(text: company?.name ?? ''),
                      onSelected: (CompanyEntity entity) => company = entity,
                      displayStringForOption: (CompanyEntity entity) =>
                          entity.name,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return getBloc.companies
                            .where(
                              (CompanyEntity entity) =>
                                  (entity.name.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase(),
                                      )),
                            )
                            .toList();
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      if (company != null) {
                        getBloc.user = UserEntity(
                          id: 0,
                          name: nameController.text,
                          email: emailController.text,
                          title: titleController.text,
                          companyId: company!.id,
                        );
                        callEvent(
                          LoginEventAddingDone(getBloc.user!),
                        );
                        _routeHome(context);
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text('save'.translate)),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        });
  }

  _routeHome(BuildContext context) async {
    if (getBloc.isEditProfile) {
      Navigator.of(context).pop(getBloc.user);
    } else {
      return await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }
}
