import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  icon: Icon(Icons.email),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.black54,
    width: 2.0,
  )),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.blueAccent,
    width: 2.0,
  )),
);
