import 'package:dio/dio.dart';
import 'package:flutter_blocApp/src/di/injection.dart';
import 'package:flutter_blocApp/src/models/BaseModel.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'bloc_base.dart';


class MoviesBloc extends BlocBase  {
  final Repository repository;
  PublishSubject<BaseModel<ItemModel>> moviesFetcher;
  Stream<BaseModel<ItemModel>> get allMovies => moviesFetcher.stream;

  MoviesBloc({this.repository});

  init(){
    moviesFetcher = PublishSubject<BaseModel<ItemModel>>();
  }

  fetchAllMovies() async {
    moviesFetcher.sink.add(BaseModel.loading('Fetching Popular Movies'));
    await repository.fetchAllMovies().then((value) => moviesFetcher.sink.add(BaseModel.completed(value))).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
        // Here's the sample to get the failed response error code and message
          final res = (obj as DioError);
          moviesFetcher.sink.add(BaseModel.error("${res.response.statusCode} -> ${res.response.statusMessage}"));
          // moviesFetcher.sink.addError(res);
          logger.e("Got error : ${res.response.statusCode} -> ${res.response.statusMessage}");
          break;
        default:
      }
    });
  }

  dispose() {
    moviesFetcher.close();
  }
}