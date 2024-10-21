
import 'package:connection_checker/application/vpn_connection/vpn_connection_cubit.dart';
import 'package:connection_checker/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/connectivity/connectivity_cubit.dart';
import 'infrastructure/connectivity_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ConnectivityCubit(ConnectivityRepository()),
          ),
          BlocProvider(
            create: (context) => VpnConnectionCubit(ConnectivityRepository()),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}

