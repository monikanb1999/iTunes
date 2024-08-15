import 'package:flutter_application_1/Model/iTunesSearchModel.dart';
import 'package:flutter_application_1/viewModel/bloc/description_part/description_event.dart';
import 'package:flutter_application_1/viewModel/bloc/description_part/description_state.dart';
import 'package:flutter_application_1/viewModel/bridge/iTunesSearchViewModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchCollectionBloc extends Bloc<CollectionFetchEvent, CollectionFetchState> {
  FetchCollectionBloc() : super(CollectionFetchState()) {
    on<CollectionFetchProject>(collectionFetchFromList);
  }

  final iTunesSearchViewModel itunesSearchViewModel = iTunesSearchViewModel();

  // final OnlineClassApiCall _onlineClassApiCall = OnlineClassApiCall();
  void collectionFetchFromList(
      CollectionFetchProject event, Emitter<CollectionFetchState> emit) async {
    emit(CollectionFetchInitial());
    if (event is CollectionFetchProject) {
      emit(CollectionFetchLoading());
      try {
        Map<String, dynamic> temp =
            await itunesSearchViewModel.collectionNameData(collectionName: event.collectionFetch);
        Result resultList = Result.fromJson(temp['results'][0]);
        print(resultList);
// Extract the list of Result objects
        // List<Result> resultList = collectionDescription.results;

        emit(CollectionFetchLoaded(iTunesCollectionFetch: resultList));
      } catch (e) {
        emit(CollectionFetchError(message: e.toString()));
      }
    }
  }
}
