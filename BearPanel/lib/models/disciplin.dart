class Disciplin {
  String name;
  String status;
  int period;
  bool finalized;
  List items;
  double notes;


  Disciplin({required this.name, required this.period, required this.finalized, required this.items, required this.notes
  , required this.status});

  Map<String, dynamic> toMap(){
    return {
      'Nome': name,//
      'Período': period,//
      'Finalizada?': finalized, //
      'Notal Atual': notes,
      'Status': status,
      'Atividades': items,
    };
  }
}