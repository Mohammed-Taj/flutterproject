// // home_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Define Events
// abstract class HomeEvent {}

// class CategoryChangedEvent extends HomeEvent {
//   final int index;
//   CategoryChangedEvent(this.index);
// }

// class SliderChangedEvent extends HomeEvent {
//   final int value;
//   SliderChangedEvent(this.value);
// }

// // Define States
// abstract class HomeState {}

// class HomeInitialState extends HomeState {}

// class CategorySelectedState extends HomeState {
//   final int selectedIndex;
//   CategorySelectedState(this.selectedIndex);
// }

// class SliderChangedState extends HomeState {
//   final int sliderValue;
//   SliderChangedState(this.sliderValue);
// }

// // Define the Bloc
// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomeInitialState());

//   Stream<HomeState> mapEventToState(HomeEvent event) async* {
//     if (event is CategoryChangedEvent) {
//       yield CategorySelectedState(event.index);
//     } else if (event is SliderChangedEvent) {
//       yield SliderChangedState(event.value);
//     }
//   }
// }
