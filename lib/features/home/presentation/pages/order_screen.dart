import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websockets_firebase/features/home/presentation/cubit/home_cubit.dart';

import 'chat_with_driver.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offers")),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => previous.offers != current.offers,
        builder: (context, state) {
          final list = state.offers ?? [];
          final cubit = BlocProvider.of<HomeCubit>(context);
          return list.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: cubit
                                ..getMessages(
                                  cubit.controller.text,
                                  list[index].id ?? '',
                                ),
                              child: ChatWithDriver(
                                driverId: list[index].id ?? '',
                              ),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(list[index].name ?? ''),
                              Text(list[index].price.toString()),
                              Text(list[index].carType ?? ''),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
