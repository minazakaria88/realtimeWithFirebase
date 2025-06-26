import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websockets_firebase/features/home/presentation/cubit/home_cubit.dart';

import '../../data/models/messages_model.dart';

class ChatWithDriver extends StatelessWidget {
  const ChatWithDriver({super.key, required this.driverId});
  final String driverId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat with Driver")),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<HomeCubit>(context);
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
                                context.read<HomeCubit>().controller.text,
                                driverId,
                                MessageModel(
                                  text: cubit.messageController.text,
                                  receiverId: driverId,
                                  senderId: '1',
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
