part of 'home_cubit.dart';

enum SendOrderStatus { initial, loading, success, failure }

extension HomeStatusX on HomeState {
  bool get isLoading => sendOrderStatus == SendOrderStatus.loading;
  bool get isSuccess => sendOrderStatus == SendOrderStatus.success;
  bool get isFailure => sendOrderStatus == SendOrderStatus.failure;
}

class HomeState extends Equatable {
  SendOrderStatus? sendOrderStatus;
  String? errorMessage;
  List<OfferModel>? offers;
  List<MessageModel>? messages;
  String? orderStatus;

  HomeState({
    this.sendOrderStatus = SendOrderStatus.initial,
    this.errorMessage,
    this.offers,
    this.messages,
    this.orderStatus,
  });

  HomeState copyWith({
    SendOrderStatus? sendOrderStatus,
    String? errorMessage,
    List<OfferModel>? offers,
    List<MessageModel>? messages,
    String? orderStatus,
  }) {
    return HomeState(
      sendOrderStatus: sendOrderStatus ?? this.sendOrderStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      offers: offers ?? this.offers,
      messages: messages ?? this.messages,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  @override
  List<Object?> get props => [
    sendOrderStatus,
    errorMessage,
    offers,
    messages,
    orderStatus,
  ];
}
