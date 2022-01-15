class CurrentDateTime {
  static String getHour() {
    int hour = DateTime.now().hour;
    if (hour >= 12 && hour < 18)
      return "Boa tarde";
    else if (hour >= 5 && hour < 12)
      return "Bom dia";
    else
      return "Boa noite";
  }
}