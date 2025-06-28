import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../home/data/models/messages_model.dart';
import '../../../home/data/models/offer_model.dart';

part 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit() : super(DriverState());

  final firstore = FirebaseFirestore.instance;

  final TextEditingController controller = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  void sendOffer(String orderId) async {
    emit(state.copyWith(sendOfferStatus: SenOfferStatus.loading));
    try {
      await firstore.collection('orders').doc(orderId).collection('offers').add(
        {'name': 'mina', 'id': '18', 'price': 200, 'carType': 'Bmw'},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void getMessages(String orderId, String driverId) async {
    try {
      firstore
          .collection('orders')
          .doc(orderId)
          .collection('chats')
          .doc(driverId)
          .collection('messages')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((model) {
            final messages = model.docs
                .map((e) => MessageModel.fromJson(e.data()))
                .toList();
            emit(state.copyWith(messages: messages));
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendMessage(
    String orderId,
    String driverId,
    MessageModel message,
  ) async {
    try {
      firstore
          .collection('orders')
          .doc(orderId)
          .collection('chats')
          .doc(driverId)
          .collection('messages')
          .add(message.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void listenForOrders() {
    try {
      firstore
          .collection('orders')
          .where('orderStatus', isEqualTo: 'pending')
          .snapshots()
          .listen((model) {
            if (model.docs.isEmpty) {
              return;
            }
            print(model.docs[0].data());
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
