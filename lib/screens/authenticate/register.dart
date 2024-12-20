import 'package:agrarian/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:agrarian/services/auth.dart';
import 'package:agrarian/shared/widgets/buttons/primary_button.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String userName = '';
  String townName = '';
  String allotmentName = '';
  File? profilePic;

  String error = '';
  bool loading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() => profilePic = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white,
              elevation: 0.0,
              title: const Text('Welcome!'),
              actions: <Widget>[
                const Icon(Icons.person),
                TextButton(
                    onPressed: () => widget.toggleView(),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text('Sign In')),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
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
                          decoration: InputDecoration(hintText: 'Email'),
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
                          decoration: InputDecoration(hintText: 'Password'),
                          validator: (value) => value == null ||
                                  value.length < 6
                              ? 'Please ensure password is at least 6 characters long.'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'User Name'),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter a user name.'
                              : null,
                          onChanged: (val) {
                            setState(() => userName = val);
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Town'),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter your town name.'
                              : null,
                          onChanged: (val) {
                            setState(() => townName = val);
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Allotment'),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter the name of your allotment.'
                              : null,
                          onChanged: (val) {
                            setState(() => allotmentName = val);
                          },
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        GestureDetector(
                          onTap: profilePic == null
                              ? _pickImage
                              : () {
                                  // Optional: show a dialog to confirm removal
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          const Text('Remove Profile Picture'),
                                      content: const Text(
                                          'Are you sure you want to remove the profile picture?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close dialog
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              profilePic =
                                                  null; // Clear the file
                                            });
                                            Navigator.pop(
                                                context); // Close dialog
                                          },
                                          child: const Text('Remove'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // The circular avatar
                              Material(
                                elevation: 5,
                                shape: const CircleBorder(),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: profilePic != null
                                      ? FileImage(profilePic!)
                                      : null,
                                  child: profilePic == null
                                      ? Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                          color: Colors.green[800],
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        PrimaryButton(
                            onPressed: () async {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                final String profilePicPath =
                                    profilePic?.path ?? 'assets/no_image.jpg';
                                dynamic result = await _auth.register(
                                    email,
                                    password,
                                    userName,
                                    townName,
                                    allotmentName,
                                    profilePicPath);

                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Oops, something went wrong! Please try again.';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            text: 'Register'),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ),
                  )),
            ),
          );
  }
}
