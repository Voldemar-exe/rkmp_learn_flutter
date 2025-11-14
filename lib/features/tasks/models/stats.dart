class Stats {
  final int total;
  final int completed;
  final int pending;
  final Map<String, int> tagCounts;

  const Stats({
    required this.total,
    required this.completed,
    required this.pending,
    required this.tagCounts,
  });
}