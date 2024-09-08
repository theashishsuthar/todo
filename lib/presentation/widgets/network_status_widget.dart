import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/datasources/network_source.dart'; 

class NetworkStatusWidget extends StatelessWidget {
  const NetworkStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<NetworkInfo>(
      create: (_) => NetworkInfoImpl(Connectivity()),
      builder: (context, child) {
        return StreamBuilder<bool>(
          stream: context
              .watch<NetworkInfo>()
              .onConnectionChange, 
          builder: (context, snapshot) {
            bool isConnected = snapshot.data ?? true;

            if (!isConnected) {
              return Container(
                color: Colors.red,
                padding: const EdgeInsets.all(8.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "You are offline",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            }
            // If online, don't show any message
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
