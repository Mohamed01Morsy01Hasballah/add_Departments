import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_management/Bloc/States.dart';
import 'package:notes_management/Component/component.dart';
import 'package:notes_management/Widget/GridView.dart';
import '../Bloc/Cubit.dart';
import '../Model.dart';
import 'AddSection.dart';
import 'SectionDetails.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final media=MediaQuery.of(context).orientation;

    return BlocConsumer<AppCubit,AppStates>(

    listener: (context,state){
      var cubitt=AppCubit.get(context);

      if(state is createdDatabaseSucessState){
          cubitt.getFromDatabase();
        }
      },
      builder: (context,state){
    var cubit=AppCubit.get(context);

    return Scaffold(

          appBar: AppBar(
            title: Text('The Main'),
            centerTitle: true,
            leading: Container(
                height: 10,
                width: 30,
                child: Image.asset('assets/icons/icons8-mail-24.png',color: Colors.white,)),
            actions: [
              Image.asset('assets/icons/icons8-logout-32.png',color: Colors.white,)
            ],

          ),
          floatingActionButton:FloatingActionButton(
            onPressed: () {
              navigatePush(widget: AddSection(),context: context);
            },
              backgroundColor: Colors.deepOrange,

            child: Text('Add ',style: TextStyle(
              color: Colors.white,
              fontSize: 15
            ),)
          ),
          body: media==Orientation.portrait?portrait(context):LandScape(context),
        );
      },

    );
  }
  Widget portrait(context)=>Padding(

    padding: const EdgeInsets.all(10.0),
    child: ListView(

      children: [
        CarouselSlider(
            items: Book.getCommonBooks().map((e) =>

                Image.asset('${e.image}',fit: BoxFit.cover,),).toList(),
            options: CarouselOptions(
                initialPage: 0,
                height: 250,
                autoPlay: true,
                aspectRatio: 16/9,
                reverse: false,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8
            )
        ),
        SizedBox(height: 20,),
        AppCubit.get(context).data.isNotEmpty?
        Expanded(

            child: Wrap(
              alignment: WrapAlignment.center,
                direction: Axis.horizontal,
              spacing: 5.0,
              runSpacing: 20,
              children: List.generate(AppCubit.get(context).data.length, (e) {
                return InkWell(
                  onTap: (){
                   navigatePush(widget: SectionDetails(
                       title: AppCubit.get(context).data[e]['title'],
                       des:  AppCubit.get(context).data[e]['des'],
                       image:  AppCubit.get(context).data[e]['image'],
                       id:  AppCubit.get(context).data[e]['id']),context: context);
                  },
                  child: ItemGrid(
                      image: AppCubit.get(context).data[e]['image'],
                      title: AppCubit.get(context).data[e]['title']
                  ),
                );
              }),
            )
        )
            :
            const Expanded(
              child: Center(
                  child: Text(
                      'Data Not Found Yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
              ),
            ),
      ],
    ),
  );
  Widget LandScape(context)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListView(
      children: [
        CarouselSlider(
            items: Book.getCommonBooks().map((e) =>

                Container(width:double.infinity,child: Image.asset('${e.image}',fit: BoxFit.cover,)),).toList(),
            options: CarouselOptions(
                initialPage: 0,
                height: 250,
                autoPlay: true,
                aspectRatio: 16/9,
                reverse: false,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9
            )
        ),
        SizedBox(height: 20,),
        AppCubit.get(context).data.isNotEmpty?
        Expanded(

            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: 5.0,
              runSpacing: 20,
              children: List.generate(AppCubit.get(context).data.length, (e) {
                return InkWell(
                  onTap: (){},
                  child: ItemGrid(
                      image: AppCubit.get(context).data[e]['image'],
                      title: AppCubit.get(context).data[e]['title']
                  ),
                );
              }),
            )
        )
            :
        const Expanded(
          child: Center(
              child: Text(
                'Data Not Found Yet',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              )
          ),
        ),
      ],
    ),
  );

}