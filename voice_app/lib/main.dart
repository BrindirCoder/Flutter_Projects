import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const VoiceNotesApp());
}

class VoiceNotesApp extends StatelessWidget {
  const VoiceNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Notes App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: Colors.deepPurpleAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E293B),
          elevation: 0,
        ),
      ),
      home: const AudioHomeScreen(),
    );
  }
}

class AudioHomeScreen extends StatefulWidget {
  const AudioHomeScreen({super.key});

  @override
  State<AudioHomeScreen> createState() => _AudioHomeScreenState();
}

class _AudioHomeScreenState extends State<AudioHomeScreen> {
  late AudioRecorder _audioRecorder;
  late AudioPlayer _audioPlayer;

  bool _isRecording = false;
  int _recordDuration = 0;
  Timer? _timer;

  List _notes = [];
  bool _isLoading = true;
  String? _currentlyPlayingUrl;
  bool _isPlaying = false;

  // بۆ Android Emulator ناونیشانی 10.0.2.2 بەکاربهێنە
  final String baseUrl = 'http://10.0.2.2:5000';

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
          if (state == PlayerState.completed) {
            _currentlyPlayingUrl = null;
          }
        });
      }
    });

    _fetchNotes();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _fetchNotes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/notes'));
      if (response.statusCode == 200 && mounted) {
        setState(() {
          _notes = jsonDecode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String filePath = '${appDir.path}/temp_audio.m4a';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: filePath,
        );

        if (mounted) {
          setState(() {
            _isRecording = true;
            _recordDuration = 0;
          });
        }

        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) {
            setState(() => _recordDuration++);
          }
        });
      }
    } catch (e) {
      debugPrint('هەڵە لە تۆمارکردن: $e');
    }
  }

  Future<void> _stopRecordingAndUpload() async {
    _timer?.cancel();
    final path = await _audioRecorder.stop();

    if (mounted) {
      setState(() => _isRecording = false);
    }

    if (path != null && mounted) {
      _showSaveDialog(path, _formatDuration(_recordDuration));
    }
  }

  void _showSaveDialog(String filePath, String duration) {
    final titleController = TextEditingController(text: 'تێبینی دەنگی');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('پاشەکەوتکردنی دەنگ'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'ناوی تێبینیەکە'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              File(filePath).delete();
              Navigator.pop(dialogContext);
            },
            child: const Text('پاشگەزبوونەوە'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await _uploadAudio(filePath, titleController.text, duration);
            },
            child: const Text('ئاپڵۆد'),
          )
        ],
      ),
    );
  }

  Future<void> _uploadAudio(String filePath, String title, String duration) async {
    if (mounted) setState(() => _isLoading = true);

    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));
      request.fields['title'] = title;
      request.fields['duration'] = duration;
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var streamedResponse = await request.send();
      if (streamedResponse.statusCode == 201) {
        _fetchNotes();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('کێشەیەک لە ئاپڵۆدکردن ڕوویدا')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // میتۆدی لێدانەوەی دەنگ (چاککراو)
  Future<void> _togglePlayAudio(String filename) async {
    final audioUrl = '$baseUrl/audio/$filename';

    if (_currentlyPlayingUrl == audioUrl && _isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.stop();
      setState(() {
        _currentlyPlayingUrl = audioUrl;
      });

      try {
        final response = await http.get(Uri.parse(audioUrl));
        if (response.statusCode == 200) {
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/$filename');
          await tempFile.writeAsBytes(response.bodyBytes);

          await _audioPlayer.play(DeviceFileSource(tempFile.path));
        }
      } catch (e) {
        debugPrint('هەڵە لە لێدانەوەی دەنگ: $e');
      }
    }
  }

  Future<void> _deleteNote(int id) async {
    await http.delete(Uri.parse('$baseUrl/notes/$id'));
    _fetchNotes();
  }

  String _formatDuration(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تێبینییە دەنگییەکان 🎙️'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? const Center(child: Text('هیچ دەنگێک تۆمار نەکراوە!'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    final audioUrl = '$baseUrl/audio/${note['filename']}';
                    final isThisPlaying = _currentlyPlayingUrl == audioUrl && _isPlaying;

                    return Card(
                      color: const Color(0xFF1E293B),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isThisPlaying ? Colors.amber : Colors.deepPurple,
                          child: IconButton(
                            icon: Icon(
                              isThisPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () => _togglePlayAudio(note['filename']),
                          ),
                        ),
                        title: Text(
                          note['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${note['created_at']} • ${note['duration']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteNote(note['id']),
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        color: const Color(0xFF1E293B),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isRecording)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '🔴 لە حاڵەتی تۆمارکردندا... ${_formatDuration(_recordDuration)}',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            GestureDetector(
              onTap: _isRecording ? _stopRecordingAndUpload : _startRecording,
              child: CircleAvatar(
                radius: 36,
                backgroundColor: _isRecording ? Colors.red : Colors.deepPurpleAccent,
                child: Icon(
                  _isRecording ? Icons.stop : Icons.mic,
                  size: 36,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}