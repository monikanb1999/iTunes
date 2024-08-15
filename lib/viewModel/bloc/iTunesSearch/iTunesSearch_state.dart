import 'package:flutter_application_1/Model/iTunesSearchModel.dart';

class iTunesSearchState {}

class iTunesSearchInitial extends iTunesSearchState {}

class iTunesSearchLoading extends iTunesSearchState {}

class iTunesSearchLoaded extends iTunesSearchState {
  var iTunesSearch;

  iTunesSearchLoaded({required this.iTunesSearch});
}

class iTunesSearchError extends iTunesSearchState {
  final String message;

  iTunesSearchError({required this.message});
}
