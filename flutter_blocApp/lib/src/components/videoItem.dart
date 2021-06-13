import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItems extends StatefulWidget {
  VideoPlayerController videoPlayerController;
  final String url;
  final bool looping;
  final bool autoplay;

  VideoItems({
    this.url,
    this.looping,
    this.autoplay,
    Key key,
  }) : super(key: key);

  @override
  _videoItemState createState() => _videoItemState();
}

// ignore: camel_case_types
class _videoItemState extends State<VideoItems> {
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.videoPlayerController = VideoPlayerController.network(widget.url);
    // widget.videoPlayerController.play();
    widget.videoPlayerController.setLooping(widget.looping);
    _initializeVideoPlayerFuture = widget.videoPlayerController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _chewieController.dispose();
    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                        aspectRatio: widget.videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(widget.videoPlayerController)
                    );
                  } else {
                    return Center(child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ));
                  }
                }
                ),
          ),
          Container(
            width: 25,
            height: 25,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    // If the video is playing, pause it.
                    if (widget.videoPlayerController.value.isPlaying) {
                      widget.videoPlayerController.pause();
                    } else {
                      // If the video is paused, play it.
                      widget.videoPlayerController.play();
                    }
                  });
                },
              child: Icon(widget.videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
            ),
          )
        ],
      ),
    );
  }
}
