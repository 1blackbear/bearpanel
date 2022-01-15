class Disciplin {
  String name;
  String status;
  int period;
  bool finalized;
  List items;


  Disciplin({required this.name, required this.period, required this.finalized, required this.items, required this.status});

  Map<String, dynamic> toMap(){
    return {
      'Nome': name,//
      'Período': period,//
      'Finalizada?': finalized, //
      'Status': status,
      'Atividades': items,
    };
  }
}