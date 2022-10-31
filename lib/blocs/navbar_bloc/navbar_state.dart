import 'package:equatable/equatable.dart';

abstract class NavbarState extends Equatable{
  @override
  List<Object?> get props => [];

}

class ShowFirstState extends NavbarState {
  final int itemIndex = 0;
}

class ShowSecondState extends NavbarState {
  final int itemIndex = 1;
}