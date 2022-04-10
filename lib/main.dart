import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/data/api.dart';
import 'package:music_player/models/artist.dart';
import 'package:music_player/widgets/music_control.dart';
import 'package:music_player/widgets/music_list.dart';
import 'package:music_player/widgets/search_bar.dart';

void main() => runApp(MaterialApp(
      home: MyApp(audioPlayer: AudioPlayer()),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  final AudioPlayer audioPlayer;
  const MyApp({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Variable for indicator slider audio, set value when duration changed from audioplayer
  Duration _duration = const Duration();

  //Variable for indicator slider audio, set value when audio position changed from audioplayer
  Duration _position = const Duration();

  //Variable for indicating if the music is pausing or playing, set value click button pause/play and selecting music to play
  var _isPausing = true;

  //Variable for play the music,  set value when selecting music to play
  Artist? _selectedMusic;

  //Variable for showing list of music after searching the artist, set value when success searching the artist
  List<Artist> _searchedArtist = [];

  //Variable for next or previous music. set value when selecting music to play
  List<Artist> _playlistMusic = [];

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    widget.audioPlayer.onAudioPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
    widget.audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _isPausing = true;
        _position = const Duration(seconds: 0);
      });
    });
  }

  void changeToSecond(int second) async {
    await widget.audioPlayer.seek(Duration(seconds: second));
  }

  void startCallback() async {
    if (_isPausing) {
      int result = await widget.audioPlayer.resume();
      if (result == 1) {
        setState(() {
          _isPausing = false;
        });
      }
    } else {
      int result = await widget.audioPlayer.pause();
      if (result == 1) {
        setState(() {
          _isPausing = true;
        });
      }
    }
  }

  void onMusicSelected(Artist artist) async {
    int result = await widget.audioPlayer.play(artist.previewUrl);
    if (result == 1) {
      setState(() {
        _isPausing = false;
        _selectedMusic = artist;
        _playlistMusic = _searchedArtist;
      });
    }
  }

  void onNextMusic() async {
    if (_selectedMusic != null) {
      final indextSelectedMusic = _playlistMusic.indexOf(_selectedMusic!);
      if (indextSelectedMusic + 1 < _playlistMusic.length) {
        final artist = _playlistMusic[indextSelectedMusic + 1];
        int result = await widget.audioPlayer.play(artist.previewUrl);
        if (result == 1) {
          setState(() {
            _isPausing = false;
            _selectedMusic = artist;
          });
        }
      }
    }
  }

  void onPreviousMusic() async {
    if (_selectedMusic != null) {
      final indextSelectedMusic = _playlistMusic.indexOf(_selectedMusic!);
      if (indextSelectedMusic > 0) {
        final artist = _playlistMusic[indextSelectedMusic - 1];
        int result = await widget.audioPlayer.play(artist.previewUrl);
        if (result == 1) {
          setState(() {
            _isPausing = false;
            _selectedMusic = artist;
          });
        }
      }
    }
  }

  //Function for fetch api Artist Search, when success show the searched artist, when failed/error show snackbar
  void onArtistSearch(String query, BuildContext context) {
    API
        .searchArtist(query)
        .then((value) => {
              setState(() {
                _searchedArtist = value;
              })
            })
        .catchError((error, stackTrace) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    error != null ? error.toString() : "Terjadi kesalahan"),
              ))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          title: SearchBar(
              onArtistSearch: ((query) => onArtistSearch(query, context))),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MusicList(
              searchedArtist: _searchedArtist,
              selectedMusic: _selectedMusic,
              onMusicSelected: onMusicSelected,
            ),
            Visibility(
              visible: _selectedMusic != null,
              child: MusicControl(
                position: _position,
                duration: _duration,
                setState: (second, setValue) {
                  changeToSecond(second);
                  setValue.call();
                },
                isPausing: _isPausing,
                startCallback: startCallback,
                previousCallback: onPreviousMusic,
                nextCallback: onNextMusic,
              ),
            )
          ],
        ));
  }
}
