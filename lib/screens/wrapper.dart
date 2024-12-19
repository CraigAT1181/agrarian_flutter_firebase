import 'package:agrarian/models/user.dart';
import 'package:agrarian/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AgrarianUser?>(context);
    print(user);
    return const Authenticate();
  }
}
