import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_management/Bloc/Cubit.dart';

import 'Screen/HomeScreen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context)  =>AppCubit()..CreateDatabase(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
  }

}

