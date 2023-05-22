import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_app/models/music.dart';
import 'package:music_app/data/music_data.dart';

class SongScreen extends StatefulWidget{

  const SongScreen({super.key, required this.song, required this.currentIndex});
  final Music song;
  final int currentIndex;
  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset(widget.song.musicLink);
  }

  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    final data = MusicData().musicList;

    void navigate(int index){
      if(index < data.length && index>=0){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SongScreen(song: data[index], currentIndex: index,)));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No other song available',textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)),backgroundColor: Colors.black.withOpacity(0.4),elevation: 5,));
      }
    }


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50, width: double.infinity,),

          Stack(
            children: [
              Icon(Icons.circle,color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),size: 60, ),
              IconButton(
                onPressed: (){Navigator.of(context).pop();},
                icon: const Icon(Icons.keyboard_arrow_down_sharp, ),
                iconSize: 45,
                color: Theme.of(context).colorScheme.primary,
                // iconSize: 35,
              ),
            ],
          ),

          const SizedBox(height: 50, width: double.infinity,),
          CircleAvatar(radius: 120 ,
            backgroundImage: NetworkImage(widget.song.url),
          ),
          const SizedBox(height: 50, width: double.infinity,),
          Text(widget.song.title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10, width: double.infinity,),
          Text(widget.song.artist,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40, width: double.infinity,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 130,
            child: ProgressBar(
                progress: _audioPlayer.position ,
                total: _audioPlayer.duration ?? const Duration() ,
                progressBarColor: Theme.of(context).colorScheme.primary,
                baseBarColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                thumbColor: Theme.of(context).colorScheme.primary,
                thumbGlowColor: Colors.transparent,
                thumbRadius: 9,
                barHeight: 5,
                timeLabelPadding: 20,
                timeLabelTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),


                onSeek: (duration){
                  _audioPlayer.seek(duration);
                },
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).pop();
                navigate(widget.currentIndex-1);
              },
                  icon: const Icon(Icons.skip_previous_sharp),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: 50
              ),
              IconButton(onPressed: (){
                  if(_isClicked){
                    setState(() {
                      _isClicked = false;
                    });

                      _audioPlayer.pause();
                    }else{
                    setState(() {
                      _isClicked = true;
                    });
                    _audioPlayer.play();
                  }
                  // _isClicked = _isClicked ? false: true;
                },
                  icon: _isClicked ? const Icon(Icons.pause_circle_filled_sharp)
                      : const Icon(Icons.play_circle_filled_sharp),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: 70
              ),
              IconButton(onPressed: (){
                Navigator.of(context).pop();
                navigate(widget.currentIndex+1);
              },
                  icon: const Icon(Icons.skip_next_sharp),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: 50
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline, color: Colors.black), label: '',),
            BottomNavigationBarItem(icon: Icon(Icons.replay, color: Colors.black), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.repeat, color: Colors.black), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shuffle_sharp, color: Colors.black), label: ''),
      ]),
    );
  }
}