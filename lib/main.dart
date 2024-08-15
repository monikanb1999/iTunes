import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/setiTunesLayoutBuilderList.dart';
import 'package:flutter_application_1/viewModel/bloc/iTunesSearch/iTunesSearch_bloc.dart';
import 'package:flutter_application_1/viewModel/bloc/iTunesSearch/iTunesSearch_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: iTunesWelcomePages(),
    );
  }
}

class iTunesWelcomePages extends StatefulWidget {
  @override
  _iTunesWelcomePagesState createState() => _iTunesWelcomePagesState();
}

class _iTunesWelcomePagesState extends State<iTunesWelcomePages> {
  String dropdownValue = 'album';
  var _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  List<String> _choices = ['album', 'movie', 'song', 'ebook', 'podcast'];
  List<String> _selectedChoices = [];
  @override
  Widget build(BuildContext context) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;
    double dynamicFontSize = screenWidth * 0.04;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('iTunes',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.025)),
              SizedBox(height: screenHeight * 0.08),
              Text(
                'Search for a variety of content from the iTunes store including iBooks, movies, podcasts, music, music videos, and audiobooks.',
                style: TextStyle(color: Colors.white, fontSize: dynamicFontSize),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.025),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: 'Enter search term',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    errorStyle: TextStyle(color: Colors.red), // Style for the error message
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a search term'; // Error message if the field is empty
                    }
                    return null; // Return null if there is no error
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Specify the parameter for the content to be searched',
                style: TextStyle(color: Colors.white, fontSize: dynamicFontSize),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                children: _choices.map((String choice) {
                  return FilterChip(
                    label: Text(choice),
                    selected: _selectedChoices.contains(choice),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          // Add the choice to the chip selected list present
                          if (!_selectedChoices.contains(choice)) {
                            _selectedChoices.add(choice);
                          }
                        } else {
                          // Remove the choice from the chip selected list ifpresent
                          _selectedChoices.remove(choice);
                        }
                        print('_selectedChoices: $_selectedChoices');
                      });
                    },
                    selectedColor: Color.fromARGB(255, 62, 197, 197),
                    backgroundColor: Colors.grey[800],
                    labelStyle: TextStyle(color: Color.fromARGB(255, 20, 20, 20)),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext ctx) => MultiBlocProvider(
                                  providers: <BlocProvider<dynamic>>[
                                    BlocProvider<OnlineClassApiBloc>(
                                        create: (BuildContext context) => OnlineClassApiBloc()
                                          ..add(FetchiTunesProject(
                                              textFieldData: _controller.text,
                                              checkBoxData: _selectedChoices))),
                                  ],
                                  child: SetiTunesLayoutBuilderList(),
                                )));
                  } else {}
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.001, vertical: screenHeight * 0.015),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 54, 54, 55), // Background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: dynamicFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
