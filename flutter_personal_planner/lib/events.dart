import 'package:flutter/material.dart';

void main() {
  runApp(events());
}

class events extends StatefulWidget {
  @override
  _eventsState createState() => _eventsState();
}

class _eventsState extends State<events> {
  int _sliderValue = 0;
  List<Map<String, String>> _events = [
    {'name': 'Etkinlik 1', 'date': '01.01.2022', 'time': '12:00'},
    {'name': 'Etkinlik 2', 'date': '02.01.2022', 'time': '13:00'},
    {'name': 'Etkinlik 3', 'date': '03.01.2022', 'time': '14:00'},
  ];
  DateTime? _selectedDate = null;
  late String _ea;
  var _controller1 = TextEditingController();
  final _timeC = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Etkinlik Takvimi'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Etkinlik Adı: ${_events[_sliderValue]['name']}'),
                  Text('Etkinlik Tarihi: ${_events[_sliderValue]['date']}'),
                  Text('Etkinlik Saati: ${_events[_sliderValue]['time']}'),
                ],
              ),
            ),
            Slider(
              value: _sliderValue.toDouble(),
              min: 0,
              max: _events.length.toDouble() - 1,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value.round();
                });
              },
            ),
            TextFormField(
              controller: _controller1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Etkinlik Adı'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Etkinlik Adı boş olamaz';
                }
                return null;
              },
              onSaved: (value) => _ea = value!,
            ),
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return ElevatedButton(
                      onPressed: () async {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                        ).then((value) {
                          print(value!);
                          print("${value.day}:${value.month}:${value.year}");
                          if (value != null) {
                            setState(() {
                              _selectedDate = value;
                            });
                          }
                        });
                      },
                      child: Text(_selectedDate == null
                          ? 'Gün Seç'
                          : '${_selectedDate!.day.toString()}/${_selectedDate!.month.toString()}/${_selectedDate!.year.toString()}'));
                }),
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return ElevatedButton(
                      onPressed: () async {
                        var time = await showTimePicker(context: context, initialTime: timeOfDay);

                        if (time != null) {
                          setState(() {
                            _timeC.text = "${time.hour}:${time.minute}";
                          });
                        }
                      },
                      child:
                      Text(_timeC.text == '' ? 'Saat Seç' : _timeC.text));
                }),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Etkinlik Ekle'),
                  onPressed: () {
                    setState(() {
                      _events.add(
                          {'name': _controller1.text, 'date': '${_selectedDate!.day.toString()}/${_selectedDate!.month.toString()}/${_selectedDate!.year.toString()}', 'time': _timeC.text});
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Etkinlik Sil'),
                  onPressed: () {
                    setState(() {
                      if (_events.length > 0) {
                        _events.removeAt(_sliderValue);
                        if (_sliderValue >= _events.length) {
                          _sliderValue = _events.length - 1;
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
