import 'package:agrarian/services/auth.dart';
import 'package:agrarian/shared/constants.dart';
import 'package:agrarian/shared/loading.dart';
import 'package:agrarian/shared/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:agrarian/shared/widgets/buttons/primary_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green[900],
              foregroundColor: Colors.white,
              elevation: 0.0,
              title: const Text('Sign In'),
              actions: <Widget>[
                const Icon(Icons.person),
                TextButton(
                    onPressed: () => widget.toggleView(),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text('Register')),
              ],
            ),
            body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                fontSize: 14.0, color: Colors.grey[500])),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter an email address.'
                            : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(_isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontSize: 14.0, color: Colors.grey[500])),
                        validator: (value) => value == null || value.length < 6
                            ? 'Please ensure password is at least 6 characters long.'
                            : null,
                        obscureText: !_isPasswordVisible,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryButton(
                              onPressed: () async {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.signIn(email, password);

                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'Oops, something went wrong! Check your email and password are correct and try again.';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              text: 'Sign in'),
                          SizedBox(
                            width: 12.0,
                          ),
                          SecondaryButton(
                              onPressed: () async {
                                setState(() => loading = true);
                                dynamic result = await _auth.signInAnon();

                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Oops, something went wrong! Please try again.';
                                    loading = false;
                                  });
                                }
                              },
                              text: 'Guest')
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                )),
          );
  }
}
