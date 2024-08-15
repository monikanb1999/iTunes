class CollectionFetchState {}

class CollectionFetchInitial extends CollectionFetchState {}

class CollectionFetchLoading extends CollectionFetchState {}

class CollectionFetchLoaded extends CollectionFetchState {
  var iTunesCollectionFetch;

  CollectionFetchLoaded({required this.iTunesCollectionFetch});
}

class CollectionFetchError extends CollectionFetchState {
  final String message;

  CollectionFetchError({required this.message});
}
