import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blocApp/src/blocs/language_bloc.dart';
import 'package:flutter_blocApp/src/components/AppLocalizations.dart';
import 'package:flutter_blocApp/src/components/connectivity.dart';
import 'package:flutter_blocApp/src/models/BaseModel.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/LanguageModel.dart';
import '../components/StateViews.dart';
import 'dart:ui' as ui;

class MovieList extends StatefulWidget {
  final MoviesBloc bloc;
  final LanguageBloc languageBloc;
  final MyConnectivity connectivity;

  MovieList({this.bloc, this.languageBloc, this.connectivity});

  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  Language langToChange;
  Map _source = {ConnectivityResult.none: false};

  @override
  void initState() {
    super.initState();
    widget.bloc.init();
    widget.bloc.fetchAllMovies();
    widget.connectivity.initialise();
    widget.connectivity.myStream.listen((event) {
      setState(() {
        _source = event;
      });
    });
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    widget.languageBloc.close();
    widget.connectivity.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (getCurrentLocale(context).languageCode == "ar") {
      langToChange = Language.EN;
    } else {
      langToChange = Language.AR;
    }
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(string)
        // Text(getLocalizedText(context, "home"))
        ,
        actions: [
          TextButton(
            onPressed: () {
              // setState(() {
              //   print("Language Pressed");
              //   // widget.appLang.changeLanguage(Locale(langToChange));
              //
              // });
              BlocProvider.of<LanguageBloc>(context)
                  .add(LanguageSelected(langToChange));
            },
            child: Text(langToChange.toString().split(".").last.toLowerCase()),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.black,
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: widget.bloc.moviesFetcher,
        builder: (context, AsyncSnapshot<BaseModel<ItemModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              _source.keys.toList().first != ConnectivityResult.none && (!snapshot.hasError)) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error as DioError;
            return Center(
                child: Text(
                    "Error Fetching Movies: ${error.response.statusCode} ${error.response.statusMessage}"));
          } else if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.COMPLETED:
                return buildList(snapshot);
                break;
              case Status.LOADING:
                return Loading(
                  loadingMessage: snapshot.data.message,
                );
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => widget.bloc.fetchAllMovies(),
                );
                break;
            }
            return Container();
          }
          else if (_source.keys.toList().first == ConnectivityResult.none ) {
            return Error(
              errorMessage: getLocalizedText(context, "NO_INTERNET"),
              onRetryPressed: () {
                if (_source.keys.toList().first != ConnectivityResult.none) {
                  widget.bloc.fetchAllMovies();
                }
              },
            );
          } else {
            print("Current Snapshot: $snapshot");
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Locale getCurrentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  Widget buildList(AsyncSnapshot<BaseModel<ItemModel>> snapshot) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
        itemCount: snapshot.data.data.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data.data.results[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data.data, index),
            ),
          );
        });
  }

  openDetailPage(ItemModel data, int index) {
    Navigator.pushNamed(context, 'movieDetail', arguments: data.results[index]);
  }
}
