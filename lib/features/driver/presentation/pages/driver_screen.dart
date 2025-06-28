import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/driver_cubit.dart';
import 'chat_with_user.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DriverCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Driver")),
      body:  Column(
        children: [
          TextButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: cubit..getMessages('mina', '18'),
                  child: const ChatWithUser(driverId: '18',orderId: 'mina',),
                ),
              ),
            );
          }, child: Text('Chat with User')),

          TextButton(onPressed: (){
            context.read<DriverCubit>().sendOffer('mina');
          }, child: Text('Send Offer'))
        ],
      ),

    );
  }
}
