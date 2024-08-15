import 'package:flutter_application_1/Model/iTunesSearchModel.dart';
import 'package:flutter_application_1/viewModel/bloc/iTunesSearch/iTunesSearch_event.dart';
import 'package:flutter_application_1/viewModel/bloc/iTunesSearch/iTunesSearch_state.dart';
import 'package:flutter_application_1/viewModel/bridge/iTunesSearchViewModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineClassApiBloc extends Bloc<iTunesSearchEvent, iTunesSearchState> {
  final iTunesSearchViewModel itunesSearchViewModel = iTunesSearchViewModel();

  OnlineClassApiBloc() : super(iTunesSearchState()) {
    on<FetchiTunesProject>(mapfetchLISTGRIDDataState);
  }
  // final OnlineClassApiCall _onlineClassApiCall = OnlineClassApiCall();
  void mapfetchLISTGRIDDataState(FetchiTunesProject event, Emitter<iTunesSearchState> emit) async {
    emit(iTunesSearchInitial());
    if (event is FetchiTunesProject) {
      emit(iTunesSearchLoading());
      try {
        Map<String, dynamic> temp = await itunesSearchViewModel.fetchLISTGRIDData(
            author: event.textFieldData!, kind: event.checkBoxData!);
        print(temp['results']);
        List<dynamic> result = temp['results'];
        List<Result> resultList = result.map((item) => Result.fromJson(item)).toList();

        print(resultList.runtimeType);

        // result.map((dynamic e) => listResult.add(Result.fromJson(e))).toList();
        // print(listResult.runtimeType);
        emit(iTunesSearchLoaded(iTunesSearch: resultList));
      } catch (e) {
        emit(iTunesSearchError(message: e.toString()));
      }
    }
  }
}
