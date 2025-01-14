import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/features/orders/presentation/bloc/my_orders_bloc.dart';
import 'package:flutter_base_project/services/session_manager/app_session_manager.dart';
import 'package:flutter_base_project/utility/constants/color_constants.dart';

import 'router/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
saveToken();
  }

void saveToken()async{
  AppSessionManager.instance.saveAuthToken(authToken: "WshAoqyWBmJCkbC0a97SjUtFgcA6Uw7iYVFuUtZSROaY5vhkhXE5bZgq4JP2");
}
  /// Root Widget
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyOrdersBloc>(
          create: (BuildContext context) => MyOrdersBloc(),
        ),

      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorSchemeSeed: ColorConst.colorPrimary,
            useMaterial3: false,
            fontFamily: "Spartan",
            scaffoldBackgroundColor: Colors.white,
            bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.transparent, modalElevation: 0),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              foregroundColor: ColorConst.white,
              // backgroundColor: ColorConst.primaryBlackBackground,
            )),
        routerConfig: router,
      ),
    );
  }
}
