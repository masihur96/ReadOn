part of 'reader_bloc.dart';

abstract class ReaderState extends Equatable {
  const ReaderState();
}

class ReaderInitial extends ReaderState {
  @override
  List<Object> get props => [];
}

class ReaderReady extends ReaderState {
  @override
  List<Object?> get props => [];
}
