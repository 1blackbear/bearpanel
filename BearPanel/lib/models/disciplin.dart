class Disciplin {
  String name;
  String status;
  int period;
  bool finalized;
  List lessons;

  Disciplin({required this.name, required this.period, required this.finalized, required this.lessons, required this.status});

  Map<String, dynamic> toMap(){
    return {
      'Nome': name,//
      'Período': period,//
      'Finalizada?': finalized, //
      'Status': status,
      'Atividades': lessons,
    };
  }
}