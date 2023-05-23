import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_app/models/music.dart';
import 'package:music_app/data/music_data.dart';


class SongScreen extends StatefulWidget{

  SongScreen({super.key, required this.song, required this.currentIndex, this.isLoop = false, this.isRepeat = false, this.isShuffle = false});
  final Music song;
  final int currentIndex;
  bool isLoop;
  bool isRepeat;
  bool isShuffle;
  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {

  late AudioPlayer _audioPlayer;
  late bool _isPlaying ;
  final data = MusicData().musicList;

  void navigate(int index, bool isLoop, bool isRepeat, bool isShuffle){
    if(index < data.length && index>=0){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SongScreen(song: data[index], currentIndex: index, isRepeat: isRepeat, isLoop: isLoop, isShuffle: isShuffle,)));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('End of playlist',textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)),backgroundColor: Colors.black.withOpacity(0.4),elevation: 5,));
    }
  }

  @override
  void initState() {
    super.initState();
    _isPlaying = true;
    _audioPlayer = AudioPlayer()..setAsset(widget.song.musicLink)..positionStream;

    _audioPlayer.positionStream.listen((event) {
      if(_audioPlayer.position == _audioPlayer.duration) {
        setState(() {
          _isPlaying = false;
        });
        if(widget.isRepeat) {
          Navigator.of(context).pop();
          navigate(widget.currentIndex, widget.isLoop, widget.isRepeat, widget.isShuffle);
        }
        else if(widget.isLoop){
          Navigator.of(context).pop();
          navigate(widget.currentIndex +1, widget.isLoop, widget.isRepeat, widget.isShuffle);
        }else if(widget.isShuffle){
          Random random = Random();
          int shuffled = widget.currentIndex;
          while(shuffled == widget.currentIndex){
            shuffled = random.nextInt(data.length);
          }
          Navigator.of(context).pop();
          navigate(shuffled, widget.isLoop, widget.isRepeat, widget.isShuffle);
        }
      }
    });
    _audioPlayer.play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height- MediaQuery.of(context).padding.bottom;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceNotch = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: deviceNotch, width: double.infinity,),

          Stack(
            children: [
              Icon(Icons.circle,color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),size: (deviceHeight-deviceNotch)*0.08, ),
              IconButton(
                onPressed: (){Navigator.of(context).pop();},
                icon: const Icon(Icons.keyboard_arrow_down_sharp, ),
                iconSize: (deviceHeight-deviceNotch)*0.06,
                color: Theme.of(context).colorScheme.primary,
                // iconSize: 35,
              ),
            ],
          ),

          SizedBox(height: (deviceHeight-deviceNotch)*0.06, width: double.infinity,),
          CircleAvatar(radius: (deviceHeight-deviceNotch)*0.144 ,
            backgroundImage: NetworkImage(widget.song.url),
          ),
          SizedBox(height: (deviceHeight-deviceNotch)*0.06, width: double.infinity,),
          Text(widget.song.title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold)
          ),
          SizedBox(height: (deviceHeight-deviceNotch)*0.012, width: double.infinity,),
          Text(widget.song.artist,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: (deviceHeight-deviceNotch)*0.048, width: double.infinity,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: (deviceHeight-deviceNotch)*0.14,
            child: StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                return ProgressBar(
                  progress: snapshot.data ?? const Duration(),
                  total: _audioPlayer.duration ?? const Duration(),
                  progressBarColor: Theme.of(context).colorScheme.primary,
                  baseBarColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  thumbColor: Theme.of(context).colorScheme.primary,
                  thumbGlowColor: Colors.transparent,
                  thumbRadius: 9,
                  barHeight: 5,
                  timeLabelPadding: 20,
                  timeLabelTextStyle: Theme.of(context).textTheme.titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                  onSeek: (duration) {
                    _audioPlayer.seek(duration);
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).pop();
                // prev song
                navigate(widget.currentIndex-1, widget.isLoop, widget.isRepeat, widget.isShuffle,);
              },
                  icon: const Icon(Icons.skip_previous_sharp),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: (deviceWidth-MediaQuery.of(context).padding.left-MediaQuery.of(context).padding.right)*0.14
              ),
              IconButton(onPressed: (){
                  if(_isPlaying){
                    setState(() {
                      _isPlaying = false;
                    });
                      _audioPlayer.pause();
                    }else{
                    setState(() {
                      _isPlaying = true;
                    });
                    _audioPlayer.play();
                  }
                },
                  icon: (_isPlaying) ? const Icon(Icons.pause_circle_filled_sharp)
                      : const Icon(Icons.play_circle_filled_sharp),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: (deviceWidth-MediaQuery.of(context).padding.left-MediaQuery.of(context).padding.right)*0.16
              ),
              IconButton(onPressed: (){
                // _audioPlayer.stop();
                Navigator.of(context).pop();
                //next song
                navigate(widget.currentIndex+1,  widget.isLoop, widget.isRepeat, widget.isShuffle);
              },
                  icon: const Icon(Icons.skip_next_sharp),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: (deviceWidth-MediaQuery.of(context).padding.left-MediaQuery.of(context).padding.right)*0.14
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        // height: (deviceHeight-deviceNotch)*0.05,
        child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: IconButton(onPressed:(){
                  setState(() {
                    // favourite line code
                  });
                  },
                  icon: const Icon(Icons.favorite_outline, color: Colors.black),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(onPressed:(){
                  setState(() {
                    widget.isRepeat =  widget.isRepeat ? false : true;
                    widget.isLoop = false;
                    widget.isShuffle = false;
                  });
                 },
                  icon: Icon(Icons.replay, color: widget.isRepeat ? Colors.green.shade500 :Colors.black),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(onPressed:(){
                  setState(() {
                    widget.isLoop =  widget.isLoop ? false : true;
                    widget.isRepeat = false;
                    widget.isShuffle = false;
                  });
                  },
                  icon: Icon(Icons.repeat, color: widget.isLoop ? Colors.green.shade500 :Colors.black,),),
                  label: '',
              ),
              BottomNavigationBarItem(
                  icon: IconButton(onPressed:(){
                    setState(() {
                      widget.isShuffle =  widget.isShuffle ? false : true;
                      widget.isLoop = false;
                      widget.isRepeat = false;
                    });
                  },
                    icon: Icon(Icons.shuffle_sharp, color: widget.isShuffle ? Colors.green.shade500 :Colors.black),)
                  ,label: ''
              ),
        ]),
      ),
    );
  }
}