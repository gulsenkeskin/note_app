import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget(
      {Key? key,
      this.isImportant = false,
      this.number = 0,
      this.title = '',
      this.description = '',
      required this.onChangedImportant,
      required this.onChangedNumber,
      required this.onChangedTitle,
      required this.onChangedDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (isImportant ?? false)
                    const Text(
                      "Önemli",
                      style: TextStyle(color: Colors.white60),
                    ),
                  Switch(
                      value: isImportant ?? false,
                      onChanged: onChangedImportant),
                  Expanded(
                      child: Slider(
                    value: (number ?? 0).toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (number) => onChangedNumber(number.toInt()),
                  ))
                ],
              ),
              buildTitle(),
              const SizedBox(
                height: 8,
              ),
              buildDescription(),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Başlık boş olamaz' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: GoogleFonts.rubik(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Bir şeyler yaz...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Açıklama boş olamaz' : null,
        onChanged: onChangedDescription,
      );
}
