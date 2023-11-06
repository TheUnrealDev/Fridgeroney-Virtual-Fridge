import 'package:flutter/material.dart';
import 'package:fridgeroney/models/auth_model.dart';
import 'package:fridgeroney/pages/sign_up_page.dart';
import 'package:provider/provider.dart';

import '../widgets/user_credentials_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _warnIncorrectLoginInfo = false;

  @override
  Widget build(BuildContext context) {
    AuthModel authModel = context.read<AuthModel>();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 173, 189, 255),
            Color.fromARGB(255, 52, 229, 255)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Please Log In!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
                  child: UserCredentialsForm(
                      formKey: _formKey,
                      emailController: _emailController,
                      passController: _passController),
                ),
                Visibility(
                  visible: _warnIncorrectLoginInfo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "The username or password is incorrect!",
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Future<bool> success = authModel.signIn(
                          _emailController.value.text,
                          _passController.value.text);
                      success.then(
                        (value) => {
                          setState(
                            () {
                              _warnIncorrectLoginInfo = !value;
                            },
                          )
                        },
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text("LOGIN"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Do not have an account? Create one!',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
