class Disciplin {
  final String name;
  final int period;
  bool finalized;


  Disciplin({required this.name, required this.period, required this.finalized});

  Map<String, dynamic> toMap(){
    return {
      'Nome': name,
      'Período': period,
      'Disciplina finalizada?': finalized,
    };
  }
}