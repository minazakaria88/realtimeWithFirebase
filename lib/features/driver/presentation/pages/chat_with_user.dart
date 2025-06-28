import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websockets_firebase/features/driver/presentation/cubit/driver_cubit.dart';

import '../../../home/data/models/messages_model.dart';

class ChatWithUser extends StatelessWidget {
  const ChatWithUser({super.key, required this.driverId, required this.orderId});
  final String driverId;
  final String orderId ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat with Driver")),
      body: BlocBuilder<DriverCubit, DriverState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<DriverCubit>(context);
          final list = state.messages ?? [];
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (list.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(list[index].text ?? ''),
                                Text(list[index].dateTime ?? ''),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cubit.messageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter order id",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              cubit.sendMessage(
                                orderId,
                                driverId,
                                MessageModel(
                                  text: cubit.messageController.text,
                                  receiverId: driverId,
                                  senderId: '20',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
