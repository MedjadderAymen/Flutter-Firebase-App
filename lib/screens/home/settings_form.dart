import 'package:brew_crew/models/client.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constatns.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values;
  String? _currentName;

  String? _currentSugars;

  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context);

    return StreamBuilder<ClientData>(
      stream: DataBaseService(client.uuid).clientData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ClientData? clientData = snapshot.data!;
          return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _currentName ?? clientData.name,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value!.isEmpty ? 'please enter a name' : null,
                    onChanged: (value) {
                      setState(() {
                        _currentName = value;
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: _currentSugars ?? clientData.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentSugars = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Slider(
                    min: 0,
                    max: 100,
                    divisions: 5,
                    label: _currentStrength.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentStrength = value.round();
                      });
                    },
                    value: (_currentStrength ?? clientData.strength).toDouble(),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DataBaseService(clientData.uid).updateUserData(
                            _currentSugars ?? clientData.sugars,
                            _currentName ?? clientData.name,
                            _currentStrength ?? clientData.strength);

                        Navigator.pop(context);
                      }
                    },
                    child: Text("Update"),
                  ),
                ],
              ));
        } else {
          return Loading();
        }
      },
    );
  }
}
