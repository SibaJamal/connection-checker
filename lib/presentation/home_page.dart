import 'package:connection_checker/application/connectivity/connectivity_cubit.dart';
import 'package:connection_checker/application/vpn_connection/vpn_connection_cubit.dart';
import 'package:connection_checker/constants/enums.dart';
import 'package:connection_checker/presentation/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        state.maybeMap(
            online: (_)=>ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 2000), // fixed to milliseconds
                backgroundColor: Colors.green,
                content: Text(
                  'You are online', // fixed missing text
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            offline:(_) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 2000), // fixed to milliseconds
            backgroundColor: Colors.red,
            content: Text(
              'You are Offline', // fixed missing text
              style: TextStyle(color: Colors.white),
            ),
          ),
        ), orElse: () {  },);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  const Text('connection type: '),
                   BlocBuilder<ConnectivityCubit,ConnectivityState>(
                     builder: (context, state) {
                   return state.maybeMap(
                        online: (state) {
                          if (state.type == ConnectionType.wifi) return const Text('Wifi Connection');
                            if (state.type == ConnectionType.mobile) return const Text('Mobile Connection');
                          return const Text('Unknown Connection');
                        },
                        offline: (_)=>const Text('Not Connected'),
                      orElse: () => const Text('Checking Connection'),
                    );
                     }
                  )
                 ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Vpn connection: '),
                  BlocBuilder<VpnConnectionCubit,VpnConnectionState>(
                      builder: (context, state) {
                        return state.maybeMap(
                            connected: (_) => const Text('yes'),
                            notConnected: (_) => const Text('No') ,
                            orElse: () => const Text('Error'),
                        );
                      }
                  )
                ],
              ),
              const SizedBox(height: 100,),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondPage()),
                  );
                },
                child: const Text('Press me'),),
            ],
          ),
        ),
      ),
    );
  }
}
