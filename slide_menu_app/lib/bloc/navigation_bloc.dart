import 'package:bloc/bloc.dart';
import 'package:slide_menu_app/ui/messages_page.dart';
import 'package:slide_menu_app/ui/my_cards_page.dart';
import 'package:slide_menu_app/ui/utility_bills_page.dart';

enum NavigationEvents {
  DashboardClickEvent,
  MessagesClickEvent,
  UtilityClickEvent
}


abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;

  NavigationBloc({this.onMenuTap}) : super( MyCardsPage(
    onMenuTap: onMenuTap,
  ));

  // NavigationStates get initialState => MyCardsPage(
  //   onMenuTap: onMenuTap,
  // );

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickEvent:
        yield MyCardsPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.MessagesClickEvent:
        yield MessagesPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.UtilityClickEvent:
        yield UtilityBillsPage(
          onMenuTap: onMenuTap,
        );
        break;
    }
  }
}