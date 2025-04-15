enum Frequency {
  everyDay('Every day'),
  daysOfWeek('Days of week'),
  everyXDays('Every X days');

  final String displayName;
  const Frequency(this.displayName);
}
