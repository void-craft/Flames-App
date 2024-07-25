import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String yourName = "";
  String partnerName = "";

  Map<String, String> flameFullform = {
    "f" : "You are Friends",
    "l" : "You are in love",
    "a" : "You are aquiantances",
    "m" : "You are married",
    "e" : "You are enemies",
    "s" : "You are siblings"
  };
  
  String getRelationship(List<String> flames, length) {
    final removedDataLength = length % flames.length;
    final updatedFlames = [...flames];
    updatedFlames.removeAt(removedDataLength == 0 ? flames.length - 1 : removedDataLength - 1);
    if (flames.length == 1) {
      return flames.join('');
    }
    return getRelationship(updatedFlames, length);
  }

  void findMyRelationship() {
    List<String> longestName =
        (yourName.length > partnerName.length ? yourName : partnerName)
            .toLowerCase()
            .split('');
    List<String> shortestName =
        (yourName.length < partnerName.length ? yourName : partnerName)
            .toLowerCase()
            .split('');
    final local = [...longestName];
    for (var i in local) {
      if (shortestName.contains(i)) {
        longestName.remove(i);
        shortestName.remove(i);
      }
    }
    final totalNameLength = longestName.length + shortestName.length;
    List<String> flames = ["f", "l", "a", "m", "e", "s"];
    String ans = getRelationship(flames, totalNameLength);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Your Relationship '),
        content: Text(flameFullform[ans] ?? ""),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flames"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: ((value) {
                yourName = value;
              }),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Your Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: ((value) {
                partnerName = value;
              }),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Partner's Name",
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                findMyRelationship();
              },
              child: const Text("Find My Relationship"))
        ],
      ),
    );
  }
}
