import 'package:flutter/material.dart';

class NamePassword {
  final String name;
  final String password;

  const NamePassword({this.name, this.password});
}

const NamePassword example1 = NamePassword(name: "şifre", password: "1561dsa56d");
const NamePassword example2 = NamePassword(name: "şifre2", password: "1adsdsa");
const NamePassword example3 = NamePassword(name: "şifre3", password: "bbb1fdgdfgfxd");
const List<NamePassword> listExample = [example1, example2, example3];
