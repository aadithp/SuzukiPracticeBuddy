class Achievement {
  String name;
  bool completeStatus;
  String description;
  String image;

  Achievement(this.name, this.completeStatus, this.description, this.image);

  Achievement.mapAchievement(Map<String, dynamic> map) {
    this.name = map['achievementName'];
    if (map['achievementCompleteStatus'] == 'true') {
      this.completeStatus = true;
    } else {
      this.completeStatus = false;
    }
    this.description = map['achievementDescription'];
    this.image = map['achievementImage'];
  }
}
