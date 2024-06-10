import 'package:flutter/material.dart' show BuildContext, Scaffold, Stack, StatelessWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mapHome.dart';
import 'sidebar.dart';
import 'navigation/navigation_bloc.dart';

class HomePageWithSideBar extends StatelessWidget{
@override
  Widget build(BuildContext context){

  return Scaffold(
    body: BlocProvider(
      create: (context) => NavigationBloc(MyMapApp()),
      child: Stack(
        children: <Widget>[
          BlocBuilder<NavigationBloc, NavigationStates>(
            builder: (context, navigationState) {
              return navigationState as Widget;
            },
          ),
          SideBar(),
        ],
      ),
    ),
    );
  }

}