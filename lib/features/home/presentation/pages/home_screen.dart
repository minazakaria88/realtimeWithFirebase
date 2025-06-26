import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import 'order_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (previous, current) => previous.sendOrderStatus != current.sendOrderStatus,
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Order sent successfully")),
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: cubit..listenForOffers(cubit.controller.text),
                  child: const OrderScreen(),
                ),
              ),
            );
          }
          if (state.isFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
          }
        },
        buildWhen: (previous, current) => previous.sendOrderStatus != current.sendOrderStatus,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: cubit.controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter order id",
                  ),
                ),
                SizedBox(height: 30),
                state.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          cubit.sendOrder(cubit.controller.text);
                        },
                        child: const Text("Send Order"),
                      ),


                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: cubit..listenForOffers(cubit.controller.text),
                          child: const OrderScreen(),
                        ),
                      ),
                    );
                  },
                  child: Text("Go to Order Screen"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
