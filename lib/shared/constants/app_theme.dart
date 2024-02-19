import 'package:flutter/material.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../screens/user screen/user_screen_controller.dart';

class AppTheme extends ChangeNotifier {
  static ThemeData getLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      fontFamily: kDefaultFontFamily,
    );
  }

  AppBar appBarCustom(
    BuildContext context,
    Future<String> userName,
  ) {
    return AppBar(
      centerTitle: true,
      title: FutureBuilder<String>(
        future: userName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              'Olá, ${snapshot.data}!',
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatelessWidget {
  static ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: kDetailColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(150)),
      alignment: Alignment.centerLeft);
  String userName;
  String email;

  NavigationDrawerWidget(this.userName, this.email, {super.key});

  final UserScreenController controller = UserScreenController();

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthScreen * 0.8,
      child: Drawer(
        backgroundColor: kSecondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ListTile(
                leading: Icon(
                  Icons.portrait_rounded,
                  color: kBackgroundColor,
                  size: widthScreen * 0.3,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Container(
                    width: widthScreen * 0.3,
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        userName,
                        style: TextStyle(
                            color: kBackgroundColor,
                            fontSize: heightScreen * 0.027,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                subtitle: Container(
                  width: widthScreen * 0.3,
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      email,
                      style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: heightScreen * kMediumSize,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45, bottom: 20),
              child: Center(
                child: SizedBox(
                  width: widthScreen * 0.5,
                  child: ElevatedButton.icon(
                    style: style,
                    onPressed: () =>
                        Navigator.pushNamed(context, Screens.editProfile),
                    icon: const Icon(
                      Icons.edit_rounded,
                      color: kBackgroundColor,
                    ),
                    label: Center(
                      child: Text(
                        'Editar informações',
                        style: TextStyle(
                            color: kBackgroundColor,
                            fontSize: heightScreen * kMediumSize,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 3,
                  width: widthScreen * 0.7,
                  color: kBackgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      onTap: () =>
                          Navigator.pushNamed(context, Screens.addAnimal),
                      title: Text(
                        'Adicionar animal',
                        style: TextStyle(
                            color: kBackgroundColor,
                            fontSize: heightScreen * kLargeSize,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: widthScreen * 0.73,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 25),
                          child: TextButton(
                              onPressed: () => controller.logoff(context),
                              child: Text(
                                'Sair',
                                style: TextStyle(
                                    color: kBackgroundColor,
                                    fontSize: heightScreen * 0.028),
                              )),
                        ),
                        IconButton(
                            onPressed: () => controller.logoff(context),
                            icon: Icon(
                              Icons.exit_to_app,
                              color: kBackgroundColor,
                              size: widthScreen * 0.082,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
