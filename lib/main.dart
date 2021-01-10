import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse;
  List listresponse;
  TextEditingController searchcontroller = TextEditingController();
  Future fetchData(String searchword) async {
    http.Response response;
    response = await http.get(
        'https://api.dictionaryapi.dev/api/v2/entries/en/' + '$searchword');
    if (response.statusCode == 200) {
      setState(() {
        listresponse = jsonDecode(response.body);
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        elevation: 1,
        title: Text('DICTIONARY'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                stringResponse = searchcontroller.text;
                fetchData(stringResponse);
              });
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: searchcontroller,
              decoration: InputDecoration(hintText: 'enter word to search'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('meaning'),
              subtitle: listresponse == null
                  ? Container()
                  : Text(
                      listresponse[0]['meanings'][0]['definitions'][0]
                              ['definition']
                          .toString(),
                      style:
                          TextStyle(fontSize: 17, color: Colors.blueGrey[600]),
                    ),
              isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
              title: Text('part of speech'),
              subtitle: listresponse == null
                  ? Container()
                  : Text(
                      listresponse[0]['meanings'][0]['partOfSpeech'].toString(),
                      style:
                          TextStyle(fontSize: 17, color: Colors.blueGrey[600]),
                    ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('example'),
              subtitle: listresponse == null
                  ? Container()
                  : Text(
                      listresponse[0]['meanings'][0]['definitions'][0]
                              ['example']
                          .toString(),
                      style:
                          TextStyle(fontSize: 17, color: Colors.blueGrey[600]),
                    ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            height: 300,
            //width: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/diclogo.jpg'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}

/* body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: searchcontroller,
                  decoration: InputDecoration(hintText: 'enter word to search'),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    stringResponse = searchcontroller.text;
                    fetchData(stringResponse);
                  });
                },
                color: Colors.blue,
                child: Text('search'),
              ),
              SizedBox(
                height: 30,
              ),
              listresponse == null
                  ? Container()
                  : Text(
                      'MEANING : ' +
                          listresponse[0]['meanings'][0]['definitions'][0]
                                  ['definition']
                              .toString(),
                      style: TextStyle(fontSize: 30),
                    ),
              SizedBox(
                height: 30,
              ),
              listresponse == null
                  ? Container()
                  : Text(
                      'PARTOFSPEECH : ' +
                          listresponse[0]['meanings'][0]['partOfSpeech']
                              .toString(),
                      style: TextStyle(fontSize: 30),
                    ),
              SizedBox(
                height: 30,
              ),
              listresponse == null
                  ? Container()
                  : Text(
                      'EXAMPLE : ' +
                          listresponse[0]['meanings'][0]['definitions'][0]
                                  ['example']
                              .toString(),
                      style: TextStyle(fontSize: 30),
                    ),
            ],
          ),
        ),
      ),*/
