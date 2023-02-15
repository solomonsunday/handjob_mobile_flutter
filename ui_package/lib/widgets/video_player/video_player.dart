import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:video_player/video_player.dart';

enum VideoType { NETWORK, FILE }

class DefaultVideoPlayer extends StatefulWidget {
  final String url;
  final VideoType videoType;
  const DefaultVideoPlayer({
    super.key,
    required this.url,
    this.videoType = VideoType.NETWORK,
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
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      if (_videoPlayerController.value.volume > 0) {
                        _videoPlayerController.setVolume(100);
                      } else {
                        _videoPlayerController.setVolume(0);
                      }
                    },
                    child: _videoPlayerController.value.volume > 0
                        ? const Icon(Icons.campaign)
                        : const Icon(
                            Icons.not_accessible,
                          ),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: ColorManager.kGrey1,
                valueColor: AlwaysStoppedAnimation(ColorManager.kWhiteColor),
              ),
            );
          }
        });
  }
}
