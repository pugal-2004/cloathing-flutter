import 'package:cloth/home/components/custom_nav_bar.dart';
import 'package:cloth/home/components/horizontal_item_view.dart';
import 'package:cloth/home/components/my_app_bar.dart';
import 'package:cloth/home/components/title_heading.dart';
import 'package:cloth/home/products.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
   const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
       
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyAppBar(

              ),
              const TitleHeading(),
              HorizontalItemView(),
              Products(),
            ],
          ),
        ),
        bottomNavigationBar: const CustomNavBar(),
      ),
    );
  }
}