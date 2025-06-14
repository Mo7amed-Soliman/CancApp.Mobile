class HealthInputModel {
  final int age;
  final int gender;
  final int airPollution;
  final int alcoholUse;
  final int dustAllergy;
  final int occupationalHazards;
  final int geneticRisk;
  final int chronicLungDisease;
  final int balancedDiet;
  final int obesity;
  final int smoking;
  final int passiveSmoker;
  final int chestPain;
  final int coughingOfBlood;
  final int fatigue;
  final int weightLoss;
  final int shortnessOfBreath;
  final int wheezing;
  final int swallowingDifficulty;
  final int clubbingOfFingerNails;
  final int frequentCold;
  final int dryCough;
  final int snoring;

  HealthInputModel({
    required this.age,
    required this.gender,
    required this.airPollution,
    required this.alcoholUse,
    required this.dustAllergy,
    required this.occupationalHazards,
    required this.geneticRisk,
    required this.chronicLungDisease,
    required this.balancedDiet,
    required this.obesity,
    required this.smoking,
    required this.passiveSmoker,
    required this.chestPain,
    required this.coughingOfBlood,
    required this.fatigue,
    required this.weightLoss,
    required this.shortnessOfBreath,
    required this.wheezing,
    required this.swallowingDifficulty,
    required this.clubbingOfFingerNails,
    required this.frequentCold,
    required this.dryCough,
    required this.snoring,
  });

  Map<String, dynamic> toJson() {
    return {
      'Age': age,
      'Gender': gender,
      'Air_Pollution': airPollution,
      'Alcohol_use': alcoholUse,
      'Dust_Allergy': dustAllergy,
      'Occupational_Hazards': occupationalHazards,
      'Genetic_Risk': geneticRisk,
      'chronic_Lung_Disease': chronicLungDisease,
      'Balanced_Diet': balancedDiet,
      'Obesity': obesity,
      'Smoking': smoking,
      'Passive_Smoker': passiveSmoker,
      'Chest_Pain': chestPain,
      'Coughing_of_Blood': coughingOfBlood,
      'Fatigue': fatigue,
      'Weight_Loss': weightLoss,
      'Shortness_of_Breath': shortnessOfBreath,
      'Wheezing': wheezing,
      'Swallowing_Difficulty': swallowingDifficulty,
      'Clubbing_of_Finger_Nails': clubbingOfFingerNails,
      'Frequent_Cold': frequentCold,
      'Dry_Cough': dryCough,
      'Snoring': snoring,
    };
  }
}
