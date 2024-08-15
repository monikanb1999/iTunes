class iTunesSearchEvent {}

class FetchiTunesProject extends iTunesSearchEvent {
  final String? textFieldData;
  final List<String>? checkBoxData;
  FetchiTunesProject({this.textFieldData, this.checkBoxData});
}
