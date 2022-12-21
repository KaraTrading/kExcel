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
  const LoginScreen({super.key});

  @override
  AppBar? get appBar => null;

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(LoginEventInit());
    return DataLoadBlocBuilder<LoginBloc, List<CompanyEntity>?>(
        noDataView: const NoItemWidget(),
        bloc: getBloc,
        builder: (BuildContext context, List<CompanyEntity>? entities) {
          if (getBloc.user != null) {
            Future.delayed(
              const Duration(milliseconds: 50),
              () => _routeHome(context),
            );
          }
          final TextEditingController nameController = TextEditingController();
          final TextEditingController titleController = TextEditingController();
          final TextEditingController emailController = TextEditingController();
          CompanyEntity? company;

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
                        callEvent(
                          LoginEventAddingDone(
                            UserEntity(
                              id: 0,
                              name: nameController.text,
                              email: emailController.text,
                              title: titleController.text,
                              companyId: company!.id,
                            ),
                          ),
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
    return await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }
}
