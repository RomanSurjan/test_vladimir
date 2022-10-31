
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/navbar_bloc/navbar_events.dart';
import 'package:test_vladimir/blocs/navbar_bloc/navbar_state.dart';


class NavbarBloc extends Bloc<NavbarItems,NavbarState>{
  NavbarBloc(super.initialState);
  @override
  NavbarState get initialState => ShowFirstState();


   @override
  Stream<NavbarState> mapEventToState(NavbarItems event) async*{
     switch (event) {
       case NavbarItems.second:
         yield ShowSecondState();
         break;

       default:
         yield ShowFirstState();
         break;
     }

  }
}