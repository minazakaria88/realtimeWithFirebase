import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:websockets_firebase/features/home/data/models/messages_model.dart';
import 'package:websockets_firebase/features/home/data/models/offer_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  final TextEditingController controller = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final firstore = FirebaseFirestore.instance;

  void sendOrder(String orderId) async {
    try {
      emit(state.copyWith(sendOrderStatus: SendOrderStatus.loading));
      await firstore.collection('orders').doc(orderId).set({
        'price': 200,
        'catType': 'bmw',
        'orderStatus': 'pending',
        'orderDate': DateTime.now().toString(),
        'orderNumber': '123456789',
      });
      emit(state.copyWith(sendOrderStatus: SendOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(sendOrderStatus: SendOrderStatus.failure));
    }
  }


  void listenForOrder(String orderId) async {
    try {
      log('listenFororder $orderId');
      firstore
          .collection('orders')
          .doc(orderId)
          .snapshots()
          .listen((model) {
            emit(state.copyWith(orderStatus: model.data()?['orderStatus']));

          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  void deleteOffer(String orderId, String offerId) async {
    try {
      await firstore
          .collection('orders')
          .doc(orderId)
          .collection('offers')
          .doc(offerId)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void listenForOffers(String orderId) async {
    try {
      log('listenForOffers $orderId');
      firstore
          .collection('orders')
          .doc(orderId)
          .collection('offers')
          .snapshots()
          .listen((model) {
            final offers = model.docs
                .map((e) => OfferModel.fromJson(e.data()))
                .toList();
            emit(state.copyWith(offers: offers));
          });
    } catch (e) {
      debugPrint(e.toString());
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
}
