import 'package:flutter/material.dart';
import 'package:fridgeroney/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../widgets/user_credentials_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _warnIncorrectCredentials = false;

  late AuthModel authModel;

  void signUp() {
    if (_formKey.currentState!.validate()) {
      Future<bool> accountCreationSuccess = authModel.signUp(
          _emailController.value.text, _passController.value.text);
      accountCreationSuccess.then(
        (success) => {
          debugPrint(success.toString()),
          if (success)
            {
              Navigator.popUntil(context, (route) => route.isFirst),
            }
          else
            {
              setState(
                () {
                  _warnIncorrectCredentials = true;
                },
              )
            },
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    authModel = Provider.of<AuthModel>(context);

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
                  "Create An Account!",
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
                  visible: _warnIncorrectCredentials,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your email is (invalid or in use) or your password is not strong enough!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: signUp,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text("Create Account"),
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
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Already have an account? Log in!',
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
