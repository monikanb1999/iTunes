import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/iTunesSearchModel.dart';
import 'package:flutter_application_1/viewModel/bloc/description_part/description_bloc.dart';
import 'package:flutter_application_1/viewModel/bloc/description_part/description_event.dart';
import 'package:flutter_application_1/viewModel/bloc/description_part/description_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class iTunesDescription extends StatefulWidget {
  final int? description;
  iTunesDescription({super.key, required this.description});

  @override
  State<iTunesDescription> createState() => _iTunesDescriptionState();
}

class _iTunesDescriptionState extends State<iTunesDescription> {
  VideoPlayerController? _controllerVideo;
  late FetchCollectionBloc _fetchCollectionBloc;

  @override
  void initState() {
    super.initState();

    // Initialize the Bloc
    _fetchCollectionBloc = FetchCollectionBloc()
      ..add(CollectionFetchProject(collectionFetch: widget.description));

    // Initialize the video controller when the Bloc has loaded the data
    _fetchCollectionBloc.stream.listen((state) {
      if (state is CollectionFetchLoaded) {
        _controllerVideo = VideoPlayerController.network(state.iTunesCollectionFetch.previewUrl)
          ..initialize().then((_) {
            setState(() {}); // Update UI when video is initialized
            _controllerVideo?.setLooping(true);
            _controllerVideo?.play();
          }).catchError((error) {
            print('Error initializing video: $error');
          });
      }
    });
  }

  @override
  void dispose() {
    _controllerVideo?.dispose();
    _fetchCollectionBloc.close();
    super.dispose();
  }

  Widget loadingCenter() {
    return Center(
      child: Card(
        color: Color.fromARGB(255, 111, 109, 109), // Black card
        elevation: 8.0, // Elevation for shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card
          child: Row(
            mainAxisSize: MainAxisSize.min, // Wraps the content tightly
            children: [
              SizedBox(height: 20), // Space between the GIF and text
              Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 18.0, // Font size of the text
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;
    double dynamicFontSize = screenWidth * 0.04;
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchCollectionBloc>(
          create: (context) => _fetchCollectionBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          centerTitle: true,
          title: const Text(
            "Description",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: BlocBuilder<FetchCollectionBloc, CollectionFetchState>(
          builder: (BuildContext context, CollectionFetchState state) {
            if (state is CollectionFetchLoading) {
              return loadingCenter();
            }
            if (state is CollectionFetchLoaded) {
              return ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Card(
                          color: Colors.black,
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      height: MediaQuery.of(context).size.height * 0.18,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: Image.network(
                                            width: MediaQuery.of(context).size.width * 0.3,
                                            height: MediaQuery.of(context).size.height * 0.3,
                                            state.iTunesCollectionFetch.artworkUrl100,
                                            fit: BoxFit.fitHeight,
                                          ).image,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Text(
                                              state.iTunesCollectionFetch.trackCensoredName,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Text(
                                              state.iTunesCollectionFetch.artistName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.06),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Row(
                                              children: [
                                                Text(
                                                  state.iTunesCollectionFetch.primaryGenreName,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                Spacer(), // Pushes the next Text widget to the right end
                                                Text(
                                                  'Preview',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Card(
                          color: Colors.black,
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 14, top: 14),
                                child: Text(
                                  'Preview',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: _controllerVideo!.value.isInitialized
                                    ? AspectRatio(
                                        aspectRatio: _controllerVideo!.value.aspectRatio,
                                        child: VideoPlayer(_controllerVideo!),
                                      )
                                    : CircularProgressIndicator(),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 14, top: 14),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 14, top: 14),
                                child: Text(
                                  state.iTunesCollectionFetch.longDescription.toString().isEmpty
                                      ? "This is description"
                                      : state.iTunesCollectionFetch.longDescription,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 13),
                ],
              );
            }
            return Center(
              child: Padding(
                padding: EdgeInsets.only(left: 14, top: 14),
                child: Text(
                  'No ITunes Found!!!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
