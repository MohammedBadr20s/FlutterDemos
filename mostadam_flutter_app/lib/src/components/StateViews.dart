import 'package:flutter/material.dart';
import 'package:mostadam_flutter_app/src/components/Constants.dart';
import 'package:mostadam_flutter_app/src/components/GenericViews.dart';




class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Visibility(
            visible: onRetryPressed == null ? false : true,
            child: FloatingActionButton(
              backgroundColor: Colors.red[500],
              child: Text('Retry', style: TextStyle(color: Colors.white)),
              onPressed: onRetryPressed,
            ),
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(mostadamTintColor()),
          ),
        ],
      ),
    );
  }
}
