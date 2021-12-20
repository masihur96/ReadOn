part of 'reader_bloc.dart';

abstract class ReaderEvent extends Equatable {
  const ReaderEvent();
}

class ReaderLastLocationChanged extends ReaderEvent {
  final double newOffset;

  ReaderLastLocationChanged(this.newOffset);
  @override
  List<Object?> get props => [newOffset];
}
