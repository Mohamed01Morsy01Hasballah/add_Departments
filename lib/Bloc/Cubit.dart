import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_management/Bloc/States.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(initialState());
  static AppCubit get(context) =>BlocProvider.of(context);
  var database;
  List<Map> data=[];
  File? imageData;
  void getImage()async{
    final ImagePicker picker=ImagePicker();
    var image =await picker.pickImage(source: ImageSource.gallery);
    final imageTemporary=File(image!.path);
    imageData=imageTemporary;
    emit(ImageState());
  }
  void CreateDatabase(){
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version){
        database.execute('CREATE TABLE data(id INTEGER PRIMARY KEY,title TEXT,des TEXT ,image TEXT) ')
            .then((value){
          print('database created');

        }).catchError((error){
          print('error created Database ${error}');
        });
      },
      onOpen: (database){
        print('Database opended');
        getFromDatabase().then((value) {
          emit(GetDataState());
        }).catchError((error){
          print(error);
        });
      }
    ).then((value) {
      database=value ;
      emit(createdDatabaseSucessState());

    });
  }
   insertDatabase({
    required String title,
     required String image,
     required String des
})async{
 await database.transaction((txn)async{
   data=[];
   await txn.rawInsert('INSERT INTO data (title,des,image) VALUES("$title","$des","$image")').then((value) {
     print('Inserted Successfull');
     getFromDatabase();
     emit(InsertDataState());
   }).catchError((error){
     print('error insert $error');
   });
 });
  }
  Future getFromDatabase()async{
    data=[];
    emit(GetDataLoadingState());
    database.rawQuery('SELECT * FROM data').then((value) {
      value.forEach((element) {
        data.add(element);
      });
      print(data);
      emit(GetDataState());
    });
  }
  void deleteData({
    required int id
})async{
    await database.rawDelete('DELETE FROM data WHERE id=?',[id])
        .then((value){
          emit(DeleteDataState());
          getFromDatabase().then((value) {
            emit(GetDataState());
          }).catchError((error){
            print(error);
          });
    });

}
void updateData({
  required int id,
  required String  title,
  required String des,
  required String image,
})async{
    await database.rawUpdate('UPDATE data SET title=?,des=?,image=? WHERE id=?',
    ['$title','$des','$image',id]).then((value){
      getFromDatabase();
      emit(UpdateDataState());
    }).catchError((error){
      print(error);
    });

}
}