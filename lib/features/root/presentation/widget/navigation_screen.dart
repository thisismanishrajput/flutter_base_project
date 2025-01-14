import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:flutter_base_project/features/home/presentation/view/home_screen.dart';
import 'package:flutter_base_project/features/orders/presentation/view/orders_screen.dart';
import 'package:flutter_base_project/utility/constants/color_constants.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';

class BottomNavItem {
  final IconData imgPath;
  final String name;
  BottomNavItem({required this.imgPath, required this.name});
}

class Home extends StatefulWidget {
  const Home({super.key});
  static const String path = '/root';
  static const String routeName = 'root';
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  PersistentTabController? _controller;
  double? deviceWidth;
  List<CustomNavBarScreen> _buildScreens = [];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _buildScreens = [
      const CustomNavBarScreen(screen: HomeScreen()),
      const CustomNavBarScreen(screen: OrdersScreen()),
    ];
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  List<BottomNavItem> _navBarsItems() {
    return [
      BottomNavItem(imgPath: Icons.home, name: kHome),
      BottomNavItem(imgPath: Icons.receipt_long, name: kOrders),
    ];
  }
  Future<bool> onWillPop(BuildContext? context)async{
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:true,
      onPopInvokedWithResult: (r,v){
        if (mounted) setState(() {});
      },
      child: Scaffold(
        body: PersistentTabView.custom(
          context,
          hideNavigationBarWhenKeyboardAppears: true,
          controller: _controller!,
          screens: _buildScreens,
          onWillPop: onWillPop,
          confineToSafeArea: true,
          itemCount: _buildScreens.length,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: false,
          stateManagement: true,
          customWidget: CustomNavBarWidget(
            items: _navBarsItems(),
            onItemSelected: (index) {
              setState(() {
                _controller!.index =
                    index; // THIS IS CRITICAL!! Don't miss it!
              });
            },
            selectedIndex: _controller!.index,
          ),
        ),
      ),
    );
  }
}

class CustomNavBarWidget extends StatelessWidget {
  final int? selectedIndex;
  final List<BottomNavItem> items;
  final ValueChanged<int>? onItemSelected;

  const CustomNavBarWidget({super.key,
    this.selectedIndex,
    required this.items,
    this.onItemSelected,
  });


  Widget _buildItem(BottomNavItem item, bool isSelected) {
    final textColor = isSelected ? ColorConst.black : Colors.grey;

    return Container(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         Icon(item.imgPath,color: isSelected ?ColorConst.colorPrimary:Colors.black45,),
          Material(
            type: MaterialType.transparency,
            child: FittedBox(
              child: Text(
                item.name,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight:isSelected?FontWeight.bold: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              onTap: () {
                onItemSelected!(index);
                if (selectedIndex == index && index == 0) {
                }
              },
              child: _buildItem(item, selectedIndex == index),
            ),
          );
        }).toList(),
      ),
    );
  }
}
