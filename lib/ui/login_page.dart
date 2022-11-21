import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ups_flutter_app/services/network_service.dart';
import 'package:ups_flutter_app/store/visibility_store/visibility_store.dart';
import 'package:ups_flutter_app/ui/home_page.dart';
import 'package:ups_flutter_app/utils/encryptor.dart';
import 'package:ups_flutter_app/utils/secure_storage.dart';
import 'package:ups_flutter_app/utils/theme_helper.dart';
import '../model/response/user_login.dart';
import '../provider/dark_theme_provider.dart';
import '../store/form_store/form_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  FormStore formStore = FormStore();
  VisibilityStore visibilityStore = VisibilityStore();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    Widget _entryField(String title, TextEditingController controller,
        {bool isPassword = false}) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: themeChange.darkTheme
                    ? Color(0xfff3f3f4)
                    : Color.fromARGB(255, 1, 1, 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (isPassword)
              Observer(
                  builder: ((context) => TextField(
                      style: TextStyle(
                        color: themeChange.darkTheme
                            ? Color(0xfff3f3f4)
                            : Color.fromARGB(255, 1, 1, 20),
                      ),
                      controller: controller,
                      onChanged: (value) => formStore
                          .setPassword(textEditingControllerPassword.text),
                      obscureText: formStore.isVisibile,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              formStore.isVisibile
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: themeChange.darkTheme
                                  ? Color(0xfff3f3f4)
                                  : Color.fromARGB(255, 1, 1, 20),
                            ),
                            onPressed: () =>
                                formStore.setVisibility(!formStore.isVisibile),
                          ),
                          border: InputBorder.none,
                          fillColor: themeChange.darkTheme
                              ? Color.fromARGB(255, 1, 1, 20)
                              : Color(0xfff3f3f4),
                          filled: true))))
            else
              Observer(
                  builder: ((context) => TextField(
                      controller: controller,
                      onChanged: (value) =>
                          formStore.setEmail(textEditingControllerEmail.text),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: themeChange.darkTheme
                              ? Color.fromARGB(255, 1, 1, 20)
                              : Color(0xfff3f3f4),
                          filled: true))))
          ],
        ),
      );
    }

    void _onSubmitLogin() {
      formStore.loginAction();
      if (formStore.isValid) {
        visibilityStore.setSelected(false);
        NetworkService networkService = NetworkService(UserLogin(
            email: textEditingControllerEmail.text,
            password:
                Encryptor.generateMd5(textEditingControllerPassword.text)));
        networkService.networkGetToken().then((user) {
          visibilityStore.setSelected(true);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => HomePageScreen(
                        user: user,
                      ))));
        }, onError: (error, stackTrace) {
          visibilityStore.setSelected(true);
          Fluttertoast.showToast(msg: "Errore nella login");
        });
      }
    }

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: Text(
              'Bentornato su'.toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
            alignment: Alignment.centerLeft,
          ),
          Align(
            child: Row(
              children: [
                Text(
                  'TalkAndProfit',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 44,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '.',
                  style: TextStyle(
                      color: ThemeHelper.primaryElement,
                      fontSize: 44,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            height: 50,
          ),
          _entryField('Email', textEditingControllerEmail),
          _entryField('Password', textEditingControllerPassword,
              isPassword: true),
          SizedBox(
            height: 30,
          ),
          Observer(
              builder: ((context) => SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeHelper.primaryElement),
                      icon: Observer(
                          builder: (context) => visibilityStore.isVisible
                              ? Icon(
                                  Icons.login,
                                  color: Colors.white,
                                )
                              : Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )),
                      label: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: visibilityStore.isVisible &&
                              formStore.password.isNotEmpty &&
                              formStore.email.isNotEmpty
                          ? _onSubmitLogin
                          : null))))
        ],
      ),
    ));
  }
}
