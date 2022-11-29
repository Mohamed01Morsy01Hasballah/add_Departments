import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_management/Bloc/Cubit.dart';
import 'package:notes_management/Bloc/States.dart';
import 'package:notes_management/Component/component.dart';

import 'HomeScreen.dart';

class UpdateSection extends StatelessWidget{
  final int id;
  final String title;
  final String image;
  final String des;
  UpdateSection({
    required this.id,
    required this.title,
    required this.des,
    required this.image
});
  var text=TextEditingController();
  var desc=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<AppCubit,AppStates>(
    listener: (context,state){},
    builder: (context,state){
      var cubit=AppCubit.get(context);
      text.text=title;
      desc.text=des;
      return Scaffold(
        appBar: AppBar(
          title: Text('Update',
            style: TextStyle(color: Colors.white),),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    BuiltTextField(
                        label: 'Enter Title',
                        type: TextInputType.text,
                        controller: text,
                        prefix: Icons.title
                    ),
                    SizedBox(height: 20,),
                    BuiltTextField(
                        label: 'Enter Title',
                        type: TextInputType.name,
                        controller: desc,
                        prefix: Icons.title
                    ),
                    SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(image)),
                    ),
                    SizedBox(height: 20,),

                    ElevatedButton(
                        onPressed: (){
                          if(formkey.currentState!.validate()){
                            cubit.updateData(id: id, title: text.text, des: desc.text, image: image);
                            Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }
                        },
                        child: Text('Update')
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },

  );
  }

}