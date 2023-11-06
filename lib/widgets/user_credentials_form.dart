import 'package:flutter/material.dart';

class UserCredentialsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passController;

  const UserCredentialsForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passController,
  });

  @override
  State<UserCredentialsForm> createState() => _UserCredentialsFormState();
}

class _UserCredentialsFormState extends State<UserCredentialsForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Input Your Email';
              }
              return null;
            },
            controller: widget.emailController,
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              label: Text(
                'Email',
                style: TextStyle(fontSize: 20),
              ),
              hintText: 'Input Your Email Here...',
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Input Your Password';
              }
              return null;
            },
            controller: widget.passController,
            style: const TextStyle(fontSize: 18),
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              label: const Text(
                'Password',
                style: TextStyle(fontSize: 20),
              ),
              hintText: 'Input Your Password Here...',
              suffix: IconButton(
                onPressed: () {
                  setState(
                    () {
                      _obscurePassword = !_obscurePassword;
                    },
                  );
                },
                icon: Icon(
                  _obscurePassword == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
