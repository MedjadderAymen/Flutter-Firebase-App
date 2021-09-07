import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _authService = AuthService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.black54,
              elevation: 0,
              title: Text("Brew Crew"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    child: Icon(
                      Icons.logout,
                    ),
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      await _authService.signOut();
                    },
                  ),
                )
              ],
            ),
          );
  }
}
