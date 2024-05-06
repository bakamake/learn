import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI框架',
      home: MyHomePage(),
      theme: ThemeData.light(), // Define your light theme
      darkTheme: ThemeData.dark(), // Define your dark theme
      themeMode: ThemeMode.system, // Use the system theme
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: '搜索',
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //00Request permission
            setState(() {
              isRecording = !isRecording;
            });
          },
          child: Icon(
            isRecording ? Icons.stop : Icons.mic,
          ),
        ),
      ),
      drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton (
                  icon: const Icon(Icons.import_export),
                  onPressed: () {
                    Permission.storage.request().then((status) {
                      if (status.isGranted) {
                        FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'pdf', 'doc'],
                        ).then((result) {
                          if (result != null) {
                            // Handle selected files
                            // For example, access file paths:
                            // result.files.forEach((file) => print(file.path));
                          } else {
                            // User canceled the file picker
                          }
                        });
                      } else {
                        // Permission denied
                      }
                    });
                  },
                ),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.add),
                ),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.settings),
                ),
                IconButton(
                    onPressed: (){
                      setState(() {

                      });
                    },
                    icon: const Icon(Icons.info),
                ),
              ],
            ),
        // 侧边栏内容
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.surround_sound),
            label: 'tts',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        onTap: (index) {
          setState(() {
            // 处理底部导航栏点击事件
          });
        },
      ),
    );
  }
}