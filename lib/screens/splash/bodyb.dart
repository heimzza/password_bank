import 'package:flutter/material.dart';
import 'package:password_safe/blocs/safe_card_bloc.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: safeCardBloc.getCards(),
    );
  }
}