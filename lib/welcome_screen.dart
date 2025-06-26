import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websockets_firebase/features/home/presentation/pages/home_screen.dart';

import 'features/home/presentation/cubit/home_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(child: Text("Welcome Screen")),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => HomeCubit(),
                      child: const HomeScreen()),
                ),
              );
            },
            child: Text("Go to Home Screen"),
          ),
        ],
      ),
    );
  }
}
