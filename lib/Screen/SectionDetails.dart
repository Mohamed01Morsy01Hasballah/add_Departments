import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_management/Bloc/Cubit.dart';
import 'package:notes_management/Component/component.dart';

import '../Bloc/States.dart';
import 'UpdateSection.dart';

class SectionDetails extends StatelessWidget{
  final int id;
  final String title;
  final String des;
  final String image;
  const SectionDetails({
    required this.title,
    required this.des,
    required  this.image,
    required this.id
});
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(
     listener: (context,state){},
     builder: (context,state){
       var cubit =AppCubit.get(context);
       return  Scaffold(
         appBar: AppBar(
           title: Text('Details',
             style: TextStyle(color: Colors.white),),
           actions: [
             IconButton(
                 onPressed: (){
                   navigatePush(widget: UpdateSection(id: id, title: title, des: des, image: image),context: context);
                 },
                 icon: Icon(
                     Icons.edit,
                   color: Colors.deepOrangeAccent,
                 )
             ),
             IconButton(
                 onPressed: (){
                   cubit.deleteData(id: id);
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                 },
                 icon: Icon(
                     Icons.delete,
                   color:Colors.deepOrangeAccent,
                 )
             )

           ],
         ),
         body: SingleChildScrollView(
           physics: BouncingScrollPhysics(),
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: Column(
               children: [
                 Container(
                   width: double.infinity,
                   height: 110,
                   child: Image.file(
                     File(image),
                     fit: BoxFit.fill,
                   ),
                 ),
                 SizedBox(height: 20,),
                 Text(
                   title,
                   style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.bold
                   ),
                 ),
                 SizedBox(height: 20,),

                 Text(
                   des,
                   style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.bold
                   ),
                 ),


               ],
             ),
           ),
         ),
       );
     },

   );
  }

}