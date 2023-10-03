class Item {
  int? id;
  String? name;
  int? amount;
  DateTime? date;
  int? usrId;

  Item({this.id, this.name, this.amount, this.date, this.usrId});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    date = json['date'];
    usrId = json['usrId'];
  }
}
