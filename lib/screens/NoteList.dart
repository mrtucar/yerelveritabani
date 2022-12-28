import 'package:flutter/material.dart';
import '../utils/dbHelper.dart';
import '../models/note_model.dart';
import 'NotAyrintilari.dart';

class NotListesi extends StatefulWidget {
  const NotListesi({Key? key}) : super(key: key);
  @override
  State<NotListesi> createState() => _NotListesiState();
}

class _NotListesiState extends State<NotListesi> {
  DatabaseHelper vtIslemleri = DatabaseHelper();
  List<Note>? notlar;
  int count=0;
  void veriCek(){
    final notlarFuture = DatabaseHelper.getAllNotes().then((value) => {
      setState((){notlar = value;})
    });
  }
  @override
  Widget build(BuildContext context) {
    if (notlar == null) {
      veriCek();
    }

    return Scaffold(
      body:notListesiNesneleri(),
      appBar: AppBar (title: Text("Notlar")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          yeniEkle();
        },
        tooltip: 'Not Ekle',
        child: Icon(Icons.add),
      ),
    );
  }
  ListView notListesiNesneleri() {
    return ListView.builder(
        itemCount: notlar?.length ?? 0,
        itemBuilder: (BuildContext context, int position) =>
            Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(notlar![position].title),
                subtitle: Text(notlar![position].description),
                onTap: () {
                  ayrintilaraGit(notlar![position]);
                },
              ),
            )
    );
  }
  void yeniEkle() async {
    bool? sonuc = await Navigator.push(
        context,MaterialPageRoute( builder:(context) => NotAyrintilari())
    );
    veriCek();
  }
  void ayrintilaraGit(Note note) async {
    bool? sonuc = await Navigator.push(
        context,MaterialPageRoute( builder:(context) => NotAyrintilari(note:note))
    );
    veriCek();
  }
}
