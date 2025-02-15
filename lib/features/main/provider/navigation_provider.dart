import 'package:flutter_riverpod/flutter_riverpod.dart';

// class NavigationNotifier extends StateNotifier<String> {
//   final void Function(String route)? onNavigate;

//   NavigationNotifier({this.onNavigate}) : super('/dashboard');

//   void navigateTo(String route) {
//     state = route; // Update the current route
//     onNavigate?.call(route); // Trigger navigation
//   }
// }

// final navigationProvider = StateNotifierProvider<NavigationNotifier, String>(
//   (ref) => NavigationNotifier(onNavigate: (route) {
//     Beamer.of(ref.read(beamerKeyProvider).currentContext!).beamToNamed(route);
//   }),
// );

// The navigation provider that holds the current route state
// final navigationProvider =
//     StateNotifierProvider<NavigationNotifier, String>((ref) {
//   return NavigationNotifier();
// });

// Define a provider for the current route
final mainScreenProvider =
    StateNotifierProvider<MainScreenNotifier, String>((ref) {
  return MainScreenNotifier();
});

// StateNotifier for managing the selected route
class MainScreenNotifier extends StateNotifier<String> {
  MainScreenNotifier() : super('/dashboard');

  void navigateTo(String route) {
    state = route; // Updates the route
  }
}
