import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int? selectdjk = -1;
  double sliderValue = 0.0;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String name = '';
  String text = '';

  List<String> Listmenu = ['Dart', 'java', 'koltin', 'C++', 'C#', 'JavaScript'];
  String? item = 'Dart';
  String? textMenu = '';

  final List<String> setting = ['Aktif'];
  List<bool> settingValue = [false];
  final TextEditingController textEditingController = TextEditingController();
  final List<String> bahasa = ['java', 'koltin', 'dart'];
  bool? selectd1 = false;
  bool? selectd2 = false;
  bool? selectd3 = false;
  List<int> list = [];

  void onChangeddrop(String? value) {
    setState(() {
      item = value;
    });
  }

  void clearText() {
    setState(() {
      name = '';
      text = '';
      list.clear(); // Menghapus pilihan checkbox
      selectd1 = false;
      selectd2 = false;
      selectd3 = false;
      item = Listmenu[0];
      textEditingController.clear();
      selectdjk = -1;
      sliderValue = 0.0;
    });
  }

  Future<Null> selectdDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: this.date,
        firstDate: DateTime(2019),
        lastDate: DateTime(2030));
    if (selected != null && selected != this.date) {
      setState(() {
        this.date = selected;
      });
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (selected != null && selected != time) {
      setState(() {
        time = selected;
      });
    }
  }

  void onSwitth(bool value) {
    setState(() {
      this.settingValue[0] = value;
    });
    print(settingValue);
  }

  void onPressedSlider(double value) {
    setState(() {
      this.sliderValue = value;
    });
  }

  void onChangedjk(int? value) {
    setState(() {
      this.selectdjk = value;
    });
    print('Pilihan: ${this.selectdjk}');
  }

  void onPressed() {
    setState(() {
      if (this.name.trim().length == 0) return;

      textMenu = '$item';

      selectd1 = list.contains(0);
      selectd2 = list.contains(1);
      selectd3 = list.contains(2);

      this.text = 'Hai ' +
          this.name +
          ', Apa kabar?\nBahasa yang Anda kuasai: ${list.map((index) => bahasa[index]).join(', ')}\nJenis Kelamin: ${selectdjk == 0 ? 'Laki-Laki' : 'Perempuan'}\nMahasiswa Aktif: ${sliderValue.round()}% \nTanggal:  ${DateFormat('dd-MM-yyyy').format(date)}\nWaktu: ${time.format(context)}\nBahasa: ${textMenu}';
    });
  }

  void onChangedname(String value) {
    setState(() {
      this.name = value;
    });
  }

  void onChanged1(bool? value) {
    setState(() {
      this.selectd1 = value;
    });
    if (value == true)
      list.add(0);
    else
      list.remove(0);
    print(list);
  }

  void onChanged2(bool? value) {
    setState(() {
      this.selectd2 = value;
    });
    if (value == true)
      list.add(1);
    else
      list.remove(1);
    print(list);
  }

  void onChanged3(bool? value) {
    setState(() {
      this.selectd3 = value;
    });
    if (value == true)
      list.add(2);
    else
      list.remove(2);
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 50),
        child: Column(
          children: <Widget>[
            // Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: 'Ketik Nama...'),
              onChanged: (value) {
                onChangedname(value);
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Text("Masukan Bahasa anda kuasai"),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: this.selectd1,
                        onChanged: (bool? value) {
                          onChanged1(value);
                        },
                      ),
                      Container(
                        child: Text(this.bahasa[0]),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: this.selectd2,
                        onChanged: (bool? value) {
                          onChanged2(value);
                        },
                      ),
                      Container(
                        child: Text(this.bahasa[1]),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: this.selectd3,
                        onChanged: (bool? value) {
                          onChanged3(value);
                        },
                      ),
                      Container(
                        child: Text(this.bahasa[2]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text("Jenis Kelamin"),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: this.selectdjk,
                        onChanged: (int? value) {
                          onChangedjk(value);
                        },
                      ),
                      Container(
                        child: Text('Laki-Laki'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: this.selectdjk,
                        onChanged: (int? value) {
                          onChangedjk(value);
                        },
                      ),
                      Container(
                        child: Text('Perempuan'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text('Aktif: ${sliderValue.round()}'),
                Slider(
                  min: 0.0,
                  max: 100.0,
                  value: this.sliderValue,
                  onChanged: (double value) {
                    onPressedSlider(value);
                  },
                )
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Text('Tanggal'),
                    ElevatedButton(
                      onPressed: () {
                        selectdDate(context);
                      },
                      child: Text('Pilih Tanggal'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      child: Text('Pilih Wakktu'),
                      onPressed: () {
                        selectTime(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text("Pilih Bahasa"),
                DropdownButton(
                  value: item,
                  items: Listmenu.map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Row(
                        children: <Widget>[Text(val)],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    onChangeddrop(value);
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Switch(
                  value: this.settingValue[0],
                  onChanged: (bool value) {
                    onSwitth(value);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Click'),
                  onPressed: () {
                    onPressed();
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  child: Text('Clear'),
                  onPressed: () {
                    clearText();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                    style: BorderStyle.solid, color: Colors.amber, width: 5),
              ),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Text(this.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
