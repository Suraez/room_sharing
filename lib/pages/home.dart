import 'package:flutter/material.dart';
import 'package:room_app/pages/add_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:room_app/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> fetchedItems = [
    // {'id': 1, 'name': 'groceries', 'amount': 100},
    // {'id': 2, 'name': 'vegetables', 'amount': 2000},
  ];

  String username = 'Suraj';

  Future<void> _getProfile() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from('profiles')
          .select<Map<String, dynamic>>()
          .eq('id', userId)
          .single();
      username = (data['username'] ?? '') as String;
      setState(() {});
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: const Color.fromARGB(255, 41, 39, 39),
      );
    } catch (error) {
      const SnackBar(
        content: Text('Unexpected error occurred'),
        backgroundColor: Color.fromARGB(255, 41, 39, 39),
      );
    }
  }

  var totalAmount = 0;

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: const Color.fromARGB(255, 41, 39, 39),
      );
    } catch (error) {
      const SnackBar(
        content: Text('Unexpected error occurred'),
        backgroundColor: Color.fromARGB(255, 41, 39, 39),
      );
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchItems();
    _getProfile();
  }

  Future<void> _fetchItems() async {
    final response = await supabase
        .from('items')
        .select('*, profiles(*)')
        .order('created_at', ascending: false);
    fetchedItems = response;
    int total = 0;
    // debugPrint('fetchedItems are $fetchedItems');
    for (var item in response) {
      total += item['amount'] as int;
    }
    setState(() {
      totalAmount = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.amber[200],
          child: ListView(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.amber,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hello $username',
                            style: const TextStyle(
                              fontSize: 32.0,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _signOut,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Logout',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Room Expenses',
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _fetchItems();
              },
              tooltip: 'Fetch',
              icon: const Icon(Icons.filter_center_focus),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddItem()));
              },
              tooltip: 'Add Expense',
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
        body: itemList(context),
        bottomNavigationBar: bottomPart(context));
  }

  Widget bottomPart(BuildContext context) {
    return BottomAppBar(
        color: Colors.amber,
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Column(
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
                    '$totalAmount',
                    style: const TextStyle(fontSize: 24.0),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget itemList(BuildContext context) {
    // final List<String> entries = <String>['A', 'B', 'C'];
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: fetchedItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber[400], // Set the background color
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
          ),
          height: 70,
          // child: Center(child: Text('Entry ${entries[index]}')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    fetchedItems[index]['name'],
                    style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Text(
                    fetchedItems[index]['created_at'].substring(0, 10) ?? '',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fetchedItems[index]['amount'].toString(),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    fetchedItems[index]['profiles'] != null
                        ? fetchedItems[index]['profiles']['username']
                        : '',
                    style: const TextStyle(fontSize: 14.0),
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
