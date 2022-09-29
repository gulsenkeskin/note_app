import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/model/note.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orangeAccent[100],
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100,
  Colors.purpleAccent[100],
  Colors.yellowAccent[200],
  Colors.pink[100],
  Colors.lightGreenAccent,
  Colors.lightBlueAccent[100],
  Colors.orange.shade300,

];

class NoteCardWidget extends StatelessWidget {
 const NoteCardWidget({Key? key, required this.note, required this.index})
      : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
             note.title,
              style:const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w200),
            ),
            const SizedBox(height: 8,),
            Text(note.description, style: GoogleFonts.rubik(        fontSize: 16, color: Colors.black54,),)
          ],
        ),
      ),
    );
  }

  //farklı widgetlar için farklı yükseklik döndürmek için
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
