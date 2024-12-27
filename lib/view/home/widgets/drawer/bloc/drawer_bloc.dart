// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'drawer_event.dart';
// part 'drawer_state.dart';

// class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {

//   int activeDrawerPage = 1;


//   DrawerBloc() : super(DrawerInitialState()) {
//     on<DrawerEvent>((event, emit) {
//       // TODO: implement event handler


// if(event is DrawerTapdedEvent){

// emit(DrawerLoadingState());

// activeDrawerPage = event.tappdedDrawerItemNumber ; 

// emit(DrawerSucsessState()); 

// }



// //   drawerTapded({required int newDrawerPage}) {
// //     activeDrawerPage = newDrawerPage;
// //     // switch (newDrawerPage) {
// //     //   case 1:
// //     //     // 1 in the drawer is ( my home )
// //     //     bottomNavBarTapded(newPageNumber: newDrawerPage);
// //     //     break;
// //     //   // case 6 :
// //     //   // // 6 in the drawer is ( my cart )
// //     //   // bottomNavBarTapded(newPageNumber: newDrawerPage);
// //     //   // break;
// //     //   case 5:
// //     //     // 5 in the drawer is ( my favouret ), and it's 3 in the bottoNavBAr
// //     //     bottomNavBarTapded(newPageNumber: 3);
// //     //     break;
// //     //   case 8:
// //     //     // 8 in the drawer is ( my setting, or personal )
// //     //     bottomNavBarTapded(newPageNumber: 4);
// //     //     break;
// //     // }

// // //
// // //

// // //     if (newDrawerPage == 1) {
// // //       // 1 in the drawer is ( my home )
// // //       bottomNavBarTapded(newPageNumber: 1);
// // //       activePageNumber = 1;
// // //     }

// // // // this section is canceled
// // //     // if (newDrawerPage == 5) {
// // //     //   //     // 5 in the drawer is ( my favouret ), and it's 3 in the bottoNavBAr
// // //     //   bottomNavBarTapded(newPageNumber: 3);
// // //     //   activePageNumber = 3;

// // //     // }

// // //     if (newDrawerPage == 6) {
// // //       // 6 in the drawer is ( my cart )
// // //       // bottomNavBarTapded(newPageNumber: 6);
// // //       // activePageNumber = 1;
// // //     }

// // //     if (newDrawerPage == 5) {
// // //       // 5 in the drawer is ( my favouret ), and it's 3 in the bottoNavBAr
// // //       bottomNavBarTapded(newPageNumber: 3);
// // //       activePageNumber = 3;
// // //     }

// // //     if (newDrawerPage == 8) {
// // //       // 8 in the drawer is ( my setting, or personal )
// // //       bottomNavBarTapded(newPageNumber: 4);
// // //       activePageNumber = 4;
// // //       print("seeeeeeeeeeeeeeeeeting");
// // //     }

// //     //
// //     //
// //     //

// //     // print("DDDDDDDDdrrrrrrrrrrrrrrrwer$activeDrawerPage");
// //   }



// //         if (event is DrawerTapdedEvent) {
// //           emit(HomeLoadingState());
// //           emit(HomeDrawerLoadingState());

// //           activeDrawerPage = event.tappdedDrawerItemNumber;
// //           // print("ddddddddddddddddddddddddddddddrawer nav bar tapped  ");

// //           // bottomNavBarTapded(newPageNumber) {
// //           // activePageNumber == newPageNumber;
// //           // activePageNumber == BottomNavBarTapdedEvent. ;
// //           // }

// //           drawerTapded(newDrawerPage: event.tappdedDrawerItemNumber);

// // //
// // //
// //           // if (activeDrawerPage == 1) {
// //           //   // 1 in the drawer is ( my home )
// //           //   // bottomNavBarTapded(newPageNumber: 1);
// //           //   add(BottomNavBarTapdedEvent(tappdedPageNumber: 1));
// //           // }

// //           // if (activeDrawerPage == 5) {
// //           //   //     // 5 in the drawer is ( my favouret ), and it's 3 in the bottoNavBAr
// //           //   // bottomNavBarTapded(newPageNumber: 3);
// //           //   add(BottomNavBarTapdedEvent(tappdedPageNumber: 3));
// //           // }

// //           // if (activeDrawerPage == 6) {
// //           //   // 6 in the drawer is ( my cart )
// //           //   // bottomNavBarTapded(newPageNumber: 6);
// //           //   // add(BottomNavBarTapdedEvent(tappdedPageNumber: 3));
// //           // }

// //           // if (activeDrawerPage == 5) {
// //           //   // 5 in the drawer is ( my favouret ), and it's 3 in the bottoNavBAr
// //           //   bottomNavBarTapded(newPageNumber: 3);
// //           //   add(BottomNavBarTapdedEvent(tappdedPageNumber: 3));
// //           // }

// //           // if (activeDrawerPage == 8) {
// //           //   // 8 in the drawer is ( my setting, or personal )
// //           //   bottomNavBarTapded(newPageNumber: 4);
// //           //   add(BottomNavBarTapdedEvent(tappdedPageNumber: 4));
// //           // }

// // //
// // //

// //           // activePageNumber = BottomNavBarTapdedEvent(tappdedPageNumber: tappdedPageNumber)

// //           emit(HomeLoadedState());
// //           emit(HomeDrawerLoadedState());
// //         }

      
//     });
//   }
// }
