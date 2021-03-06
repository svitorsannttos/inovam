import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inovam/common/custom_drawer/custom_drawer.dart';
import 'package:inovam/models/home_manager.dart';
import 'package:inovam/screens/home/components/section_staggered.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color.fromARGB(0,0, 0, 0),
                  Color.fromARGB(0,0, 0, 0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Image.asset('assets/logo.png'),
                titleSpacing: 70,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.black,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              ),
              Consumer<HomeManager>(
                builder:(_,homeManager,__){
                  final List<Widget> children = homeManager.sections.map<Widget>(
                          (section) {
                            switch(section.type){
                              case 'List':
                                return SectionList(section);
                              case  'Staggered':
                                return SectionStaggered(section);
                              default:
                                return Container();
                            }
                          }
                          ).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}