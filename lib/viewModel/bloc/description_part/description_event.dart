class CollectionFetchEvent {}

class CollectionFetchProject extends CollectionFetchEvent {
  final int? collectionFetch;
  CollectionFetchProject({this.collectionFetch});
}
