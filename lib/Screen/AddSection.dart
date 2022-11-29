import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_management/Bloc/Cubit.dart';
import 'package:notes_management/Bloc/States.dart';
import 'package:notes_management/Component/component.dart';

class AddSection extends StatelessWidget{
  var title=TextEditingController();
  var des=TextEditingController();
  var image=TextEditingController();
  var fromkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(
     listener: (context,state){},
     builder: (context,state){
       var cubit=AppCubit.get(context);
       return Scaffold(
         appBar: AppBar(
           title: Text('Add Section',
             style: TextStyle(color: Colors.white),),
           centerTitle: true,
         ),
         body: Center(
           child: SingleChildScrollView(
             padding: EdgeInsets.all(10),
             physics: BouncingScrollPhysics(),
             child: Form(
               key: fromkey,
               child: Column(
                 children: [
                   BuiltTextField(
                       label: 'Title',
                       type: TextInputType.text,
                       controller: title,
                       prefix:Icons.title
                   ),
                   SizedBox(height: 20,),
                   BuiltTextField(
                       label: 'Description',
                       type:TextInputType.text ,
                       controller: des,
                       prefix: Icons.description_outlined
                   ),
                   SizedBox(height: 20,),
                   MaterialButton(
                     padding: EdgeInsets.all(8),
                     onPressed: (){
                       cubit.getImage();
                     },
                     color: Colors.black,
                     child: Text('Get Image',
                       style: TextStyle(
                           color: Colors.white
                       ),),
                     shape: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5)
                     ),
                   ),
                   cubit.imageData ==null?
                       Container(
                         margin: EdgeInsets.all(1),
                         height: 15,
                         child: Text('Please Upload Image'),
                       ):CircleAvatar(
                     radius: 40,
                     backgroundImage: FileImage(cubit.imageData!),
                   ),
                   ElevatedButton(
                       onPressed: (){
                         if(fromkey.currentState!.validate() && cubit.imageData !=null){
                           cubit.insertDatabase(title: title.text, image:cubit.imageData!.path, des: des.text);
                           Navigator.pop(context);
                         }
                       },
                       child: Text("Submit"),
                   )

                 ],
               ),
             ),
           ),
         ),
       );
     },

   );
  }
  
}