import 'package:agrarian/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:agrarian/shared/constants.dart';
import 'package:agrarian/services/auth.dart';
import 'package:agrarian/shared/widgets/buttons/primary_button.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:agrarian/services/geonames.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GeoNamesService _geoNamesService = GeoNamesService();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _locationController = TextEditingController();

  List<String> _suggestions = [];

  void _fetchSuggestions(String input) async {
    if (input.isEmpty) {
      if (mounted) {
        setState(() => _suggestions = []);
      }
      return;
    }

    try {
      final results = await _geoNamesService.getLocations(input);

      if (mounted) {
        setState(() => _suggestions = results);
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

  String email = '';
  String password = '';
  String userName = '';
  String location = '';
  String bio = '';
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
              backgroundColor: Colors.green[900],
              foregroundColor: Colors.white,
              elevation: 0.0,
              title: const Text('Register'),
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
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[500])),
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
                          decoration: textInputDecoration.copyWith(
                              hintText: 'User Name',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[500])),
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
                            controller: _locationController,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Location',
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[500])),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter your location.'
                                : null,
                            onChanged: _fetchSuggestions),
                        const SizedBox(
                          height: 10.0,
                        ),
                        if (_locationController.text.isNotEmpty &&
                            _suggestions.isNotEmpty)
                          Stack(children: [
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _suggestions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(_suggestions[index]),
                                      onTap: () {
                                        _locationController.text =
                                            _suggestions[index];
                                        setState(() {
                                          location = _suggestions[index];
                                          _suggestions = [];
                                        });
                                      },
                                    );
                                  }),
                            ),
                          ]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'About you',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[500])),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Tell us something about yourself.'
                              : null,
                          onChanged: (val) {
                            setState(() => bio = val);
                          },
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        InkWell(
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
                                          color: Colors.green[900],
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
                                    location,
                                    bio,
                                    profilePicPath);

                                if (result == null) {
                                  if (mounted) {
                                    setState(() {
                                      error =
                                          'Oops, something went wrong! Please try again.';
                                      loading = false;
                                    });
                                  }
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
