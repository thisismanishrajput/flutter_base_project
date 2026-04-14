import 'package:equatable/equatable.dart';

/// Base class for all product feature events.
sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Event to trigger products fetch flow.
class FetchProducts extends ProductEvent {
  const FetchProducts();
}
