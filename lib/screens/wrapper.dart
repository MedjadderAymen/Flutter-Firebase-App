import 'package:brew_crew/models/client.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return either the home or authenticate

    final client = Provider.of<Client>(context);

    
    if(client.uuid.isEmpty){
      print('wrapper to login '+ client.uuid);
      return  Authenticate();
    }else{
      print('wrapper to home '+ client.uuid);
      return Home();
    }
  }
}
