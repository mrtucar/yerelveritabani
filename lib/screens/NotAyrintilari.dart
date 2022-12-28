import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../utils/dbHelper.dart';

class NotAyrintilari extends StatelessWidget {
  final Note? note;
  NotAyrintilari({Key? key,this.note}) : super(key: key);

  TextEditingController baslikKontroller = TextEditingController();
  TextEditingController ayrintiKontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    baslikKontroller.text = note?.title ?? "";
    ayrintiKontroller.text = note?.description ?? "";

    return Scaffold(appBar: AppBar(title:Text("Baslik")),
    body: Column(
      children: [
        TextField(controller: baslikKontroller,),
        TextField(controller: ayrintiKontroller,),
        ElevatedButton(onPressed: (){_kayitekleGuncelle(context);}, child: Text("Kaydet")),
        ElevatedButton(onPressed: (){_kayitSil(context);}, child: Text("Sil")),
        ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Geri Dön")),
      ],
    ),
    ) ;
  }
  _kayitSil(BuildContext context) async {
    if (note != null) {
      await DatabaseHelper.deleteNote(note!);
    }
    Navigator.pop(context);
  }
  _kayitekleGuncelle(BuildContext context) async {
    final Note model = Note(
        title: baslikKontroller.text,
        description: ayrintiKontroller.text,
        id:note?.id
    );
    if (note == null) {
      await DatabaseHelper.addNote(model);
    }
    else {
      DatabaseHelper.updateNote(model);
    }
    Navigator.pop(context);
  }
}
