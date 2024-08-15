import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/iTunesSearchModel.dart';
import 'package:flutter_application_1/view/descriptioniTunes.dart';
import 'package:flutter_application_1/viewModel/bloc/iTunesSearch/iTunesSearch_bloc.dart';
import 'package:flutter_application_1/viewModel/bloc/iTunesSearch/iTunesSearch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SetiTunesLayoutBuilderList extends StatefulWidget {
  SetiTunesLayoutBuilderList({super.key});

  @override
  State<SetiTunesLayoutBuilderList> createState() => _SetiTunesLayoutBuilderListState();
}

class _SetiTunesLayoutBuilderListState extends State<SetiTunesLayoutBuilderList> {
  bool isGridLayout = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('iTunes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () {
              setState(() {
                isGridLayout = true;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              setState(() {
                isGridLayout = false;
              });
            },
          ),
        ],
      ),
      body: isGridLayout
          ? BlocBuilder<OnlineClassApiBloc, iTunesSearchState>(
              builder: (BuildContext ctx, iTunesSearchState state) {
              if (state is iTunesSearchLoading) {
                return //buildGridLayout(ctx, state);
                    loadingCenter();
              }
              if (state is iTunesSearchLoaded) {
                return SingleChildScrollView(
                    child: buildGridLayout(context, state)); //buildGridLayout(ctx, state);
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
            })
          : BlocBuilder<OnlineClassApiBloc, iTunesSearchState>(
              builder: (BuildContext ctx, iTunesSearchState state) {
              if (state is iTunesSearchLoading) {
                return //buildGridLayout(ctx, state);
                    loadingCenter();
              }
              if (state is iTunesSearchLoaded) {
                return SingleChildScrollView(
                    child: buildListLayout(context, state)); //buildGridLayout(ctx, state);
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
            }),
    );
  }

  Widget categoryCard(String category) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 1,
      decoration: BoxDecoration(
        color: Color(0xFF3D4244), // Background color
      ),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        category,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget categoryList(BuildContext context, List<Result> listCategory) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: listCategory.length, // The number of items in the list
        shrinkWrap: true, // Ensures the ListView takes only as much space as it needs
        physics: NeverScrollableScrollPhysics(), // Prevents independent scrolling
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => iTunesDescription(
                          description: listCategory[index].trackId,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Add padding between items
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      listCategory[index].artworkUrl100.toString(), // URL of the image
                      width: screenWidth * 0.3, // Set the width of the image
                      height: screenHeight * 0.1, // Set the height of the image
                      fit: BoxFit.fill, // How the image should be inscribed into the box
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                            Icons.error); // Display an error icon if the image fails to load
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: screenWidth * 0.4,
                          child: Text(
                            maxLines: 5,
                            listCategory[index].artistName.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: screenWidth * 0.5,
                          child: Text(
                            maxLines: 5,
                            listCategory[index].collectionName.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget categoryGrid(BuildContext context, List<Result> listCategory) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
      physics:
          NeverScrollableScrollPhysics(), // Prevent individual grids from scrolling independently
      shrinkWrap: true, // Allow GridView to take up only as much space as needed

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: listCategory.length, // Number of items in the grid
      itemBuilder: (BuildContext context, int index) {
        // Build and return grid items here
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => iTunesDescription(
                        description: listCategory[index].trackId,
                      )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  listCategory[index].artworkUrl100.toString(), // URL of the image
                  width: screenWidth * 0.3, // Optional: Set the width of the image
                  height: screenHeight * 0.1, // Optional: Set the height of the image
                  fit: BoxFit.fill, // Optional: How the image should be inscribed into the box.
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                        Icons.error); // Optional: Display an error icon if the image fails to load
                  },
                ),
                Text(
                  listCategory[index].artistName.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  listCategory[index].collectionName.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildGridLayout(BuildContext context, iTunesSearchLoaded state) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;

    List<Result> songs = state.iTunesSearch.where((e) => e.kind == 'song').toList();
    List<Result> podCast = state.iTunesSearch.where((e) => e.kind == 'podcast').toList();
    List<Result> featureMovie = state.iTunesSearch.where((e) => e.kind == 'feature-movie').toList();
    List<Result> tvEpisode = state.iTunesSearch.where((e) => e.kind == 'tv-episode').toList();
    List<Result> movie = state.iTunesSearch.where((e) => e.kind == 'movie').toList();
    List<Result> eBook = state.iTunesSearch.where((e) => e.kind == 'ebook').toList();
    List<Result> album = state.iTunesSearch.where((e) => e.kind == 'album').toList();
    List<Result> musicVideo = state.iTunesSearch.where((e) => e.kind == 'music-video').toList();
    print(songs);
    print('');
    if (state is iTunesSearchLoading) {
      return loadingCenter();
    }
    if (state is iTunesSearchLoaded) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (songs.isNotEmpty) ...[categoryCard("Song"), categoryGrid(context, songs)],
            if (podCast.isNotEmpty) ...[categoryCard("PodCast"), categoryGrid(context, podCast)],
            if (album.isNotEmpty) ...[
              categoryCard("Album"),
              categoryGrid(context, album),
            ],
            if (featureMovie.isNotEmpty) ...[
              categoryCard("Feature Movie"),
              categoryGrid(context, featureMovie),
            ],
            if (movie.isNotEmpty) ...[
              categoryCard("Movie"),
              categoryGrid(context, movie),
            ],
            if (tvEpisode.isNotEmpty) ...[
              categoryCard("TvEpisode"),
              categoryGrid(context, tvEpisode),
            ],
            if (songs.isEmpty &&
                podCast.isEmpty &&
                album.isEmpty &&
                featureMovie.isEmpty &&
                movie.isEmpty &&
                tvEpisode.isEmpty) ...[
              Text("No iTunes found!!!",
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20))
            ]
          ]);
    }
    return loadingCenter();
  }

  Widget loadingCenter() {
    return Center(
        child: Card(
      color: Color.fromARGB(255, 95, 94, 94), // Black card
      elevation: 8.0, // Elevation for shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Row(
          mainAxisSize: MainAxisSize.min, // Wraps the content tightly
          children: [
            // Loading GIF (using SpinKitDoubleBounce as an example)
            // SpinKitDoubleBounce(
            //   color: Colors.white,  // Color of the loading animation
            //   size: 50.0,           // Size of the loading animation
            // ),
            SizedBox(height: 20), // Space between the GIF and text
            // Loading Text
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
    ));
  }

  Widget buildListLayout(BuildContext context, iTunesSearchLoaded state) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;

    List<Result> songs = state.iTunesSearch.where((e) => e.kind == 'song').toList();
    List<Result> podCast = state.iTunesSearch.where((e) => e.kind == 'podcast').toList();
    List<Result> featureMovie = state.iTunesSearch.where((e) => e.kind == 'feature-movie').toList();
    List<Result> tvEpisode = state.iTunesSearch.where((e) => e.kind == 'tv-episode').toList();
    List<Result> movie = state.iTunesSearch.where((e) => e.kind == 'movie').toList();
    List<Result> eBook = state.iTunesSearch.where((e) => e.kind == 'ebook').toList();
    List<Result> album = state.iTunesSearch.where((e) => e.kind == 'album').toList();
    List<Result> musicVideo = state.iTunesSearch.where((e) => e.kind == 'music-video').toList();
    print(songs);
    print('');
    if (state is iTunesSearchLoading) {
      return loadingCenter();
    }
    if (state is iTunesSearchLoaded) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (songs.isNotEmpty) ...[categoryCard("Song"), categoryList(context, songs)],

        if (podCast.isNotEmpty) ...[categoryCard("PodCast"), categoryList(context, podCast)],

        if (album.isNotEmpty) ...[
          categoryCard("Album"),
          categoryList(context, album),
        ],
        if (featureMovie.isNotEmpty) ...[
          categoryCard("Feature Movie"),
          categoryList(context, featureMovie),
        ],
        if (movie.isNotEmpty) ...[
          categoryCard("Movie"),
          categoryList(context, movie),
        ],
        if (tvEpisode.isNotEmpty) ...[
          categoryCard("TvEpisode"),
          categoryList(context, tvEpisode),
        ]
        // if (songs.isEmpty &&
        //     podCast.isEmpty &&
        //     album.isEmpty &&
        //     featureMovie.isEmpty &&
        //     movie.isEmpty &&
        //     tvEpisode.isEmpty)
        //   Center(
        //       child: Text("No results found",
        //           style: TextStyle(color: Colors.white, fontSize: 16))),
      ]);
    }
    return loadingCenter();
  }

  Widget buildListSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget buildListItem(String imagePath, String title, String subtitle) {
    return ListTile(
      leading: Image.asset(imagePath, height: 50, width: 50),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget ShimmerLoadingWidget() {
    return SizedBox(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 4, // Show 6 shimmer items when loading
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
              baseColor: Color.fromARGB(255, 62, 60, 60),
              highlightColor: Colors.grey[50]!,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 250,
                      color: Color.fromARGB(255, 62, 60, 60),
                    ),
                    SizedBox(height: 8.0),
                    // Container(
                    //   width: 200,
                    //   height: 250,
                    //   color: Color.fromARGB(255, 62, 60, 60),
                    // ),
                    // SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
