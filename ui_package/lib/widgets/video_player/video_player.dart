import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:video_player/video_player.dart';

enum VideoType { NETWORK, FILE }

class DefaultVideoPlayer extends StatefulWidget {
  final String url;
  final VideoType videoType;
  final bool inPosition;
  const DefaultVideoPlayer({
    super.key,
    required this.url,
    this.videoType = VideoType.NETWORK,
    this.inPosition = false,
  });

  @override
  State<DefaultVideoPlayer> createState() => _DefaultVideoPlayerState();
}

class _DefaultVideoPlayerState extends State<DefaultVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.videoType == VideoType.FILE) {
      _videoPlayerController = VideoPlayerController.file(File(widget.url));
    } else {
      _videoPlayerController = VideoPlayerController.network(widget.url);
    }

    _videoPlayerController.initialize().then((_) {
      setState(() {
        // _videoPlayerController.play();
        _videoPlayerController.setVolume(1.0);
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: GestureDetector(
                onTap: () {
                  _videoPlayerController.value.isPlaying
                      ? _videoPlayerController.pause()
                      : _videoPlayerController.play();
                },
                child: VideoPlayer(_videoPlayerController)),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (_videoPlayerController.value.volume > 0.0) {
                  _videoPlayerController.setVolume(0.0);
                } else {
                  _videoPlayerController.setVolume(1.0);
                }
              });
            },
            child: _videoPlayerController.value.volume > 0
                ? const Icon(Icons.volume_up)
                : const Icon(
                    Icons.volume_off,
                  ),
          ),
        )
      ],
    );
  }
}
