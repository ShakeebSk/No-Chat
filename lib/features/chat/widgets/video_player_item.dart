// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  // late VideoPlayerController videoPlayerController;
  bool isPlay = false;
  // bool _isInitialized = false;
  // @override
  // void initState() {
  //   super.initState();
  //   videoPlayerController = VideoPlayerController.network(widget.videoUrl)
  //     ..initialize().then((value) {
  //       videoPlayerController.setVolume(1);
  //     });
  // }

  late VideoPlayerController videoPlayerController;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  Future<void> _initVideoPlayer() async {
    try {
      videoPlayerController =
          widget.videoUrl.startsWith('http')
              ? VideoPlayerController.network(widget.videoUrl)
              : VideoPlayerController.file(File(widget.videoUrl));

      await videoPlayerController.initialize();

      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
        videoPlayerController.setLooping(true);
        videoPlayerController.play();
      }
    } catch (e) {
      debugPrint('Video initialization failed: $e');
      if (mounted) {
        setState(() => _isInitializing = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to load video')));
      }
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          VideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlay) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
                setState(() {
                  isPlay = !isPlay;
                });
              },
              icon: Icon(isPlay ? Icons.pause_circle : Icons.play_circle),
            ),
          ),
        ],
      ),
    );
  }
}


// class VideoPlayerItem extends StatefulWidget {
//   final String videoUrl;
//   const VideoPlayerItem({
//     Key? key,
//     required this.videoUrl,
//   }) : super(key: key);

//   @override
//   State<VideoPlayerItem> createState() => _VideoPlayerItemState();
// }

// class _VideoPlayerItemState extends State<VideoPlayerItem> {
//   late CachedVideoPlayerController videoPlayerController;
//   bool isPlay = false;

//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((value) {
//         videoPlayerController.setVolume(1);
//       });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     videoPlayerController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: Stack(
//         children: [
//           CachedVideoPlayer(videoPlayerController),
//           Align(
//             alignment: Alignment.center,
//             child: IconButton(
//               onPressed: () {
//                 if (isPlay) {
//                   videoPlayerController.pause();
//                 } else {
//                   videoPlayerController.play();
//                 }

//                 setState(() {
//                   isPlay = !isPlay;
//                 });
//               },
//               icon: Icon(
//                 isPlay ? Icons.pause_circle : Icons.play_circle,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }