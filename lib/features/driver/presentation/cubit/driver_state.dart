part of 'driver_cubit.dart';


enum SenOfferStatus { initial, loading, success, failure }

class DriverState extends Equatable {
   DriverState({
    this.sendOfferStatus = SenOfferStatus.initial,
    this.errorMessage,
    this.offers,
    this.messages
  });

   SenOfferStatus ?sendOfferStatus;
   String? errorMessage;
   List<OfferModel>? offers;
   List<MessageModel>? messages;

  DriverState copyWith({
    SenOfferStatus? sendOfferStatus,
    String? errorMessage,
    List<OfferModel>? offers,
    List<MessageModel>? messages,
  }) {
    return DriverState(
      sendOfferStatus: sendOfferStatus ?? this.sendOfferStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      offers: offers ?? this.offers,
      messages: messages ?? this.messages
    );
  }



  @override
  List<Object?> get props => [sendOfferStatus, errorMessage, offers,messages];
}

