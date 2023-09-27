import 'package:flutter/material.dart';
import 'package:room_app/pages/add_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Room Expenses',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddItem()),
                  );
                },
                tooltip: 'Add Expense',
                icon: const Icon(Icons.add_circle))
          ],
        ),
        body: itemList(context),
        bottomNavigationBar: bottomPart(context));
  }

  Widget bottomPart(BuildContext context) {
    return const BottomAppBar(
        color: Colors.amber,
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Amount:',
                    style: TextStyle(fontSize: 24.0),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '1500',
                    style: TextStyle(fontSize: 24.0),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget itemList(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber[400], // Set the background color
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
          ),
          height: 100,
          // child: Center(child: Text('Entry ${entries[index]}')),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Vegetables',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Text(
                    '2023-09-10',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '500',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'Suraj',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
