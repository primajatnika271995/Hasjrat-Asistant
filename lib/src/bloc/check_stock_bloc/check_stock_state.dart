import 'package:equatable/equatable.dart';

class CheckStockState extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckStockInitial extends CheckStockState {}

class CheckStockLoading extends CheckStockState {}

class CheckStockDisposeLoading extends CheckStockState {}

class CheckStockFailed extends CheckStockState{}

class CheckStockSuccess extends CheckStockState{
  final _data;
  
  CheckStockSuccess(this._data);
  //model list porps here
  @override
  List<Object> get props => [_data];
}