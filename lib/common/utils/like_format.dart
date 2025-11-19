class LikeFormat {
 static String formatLikes(int count) {
  if (count < 1000) {
    return count.toString();
  } else if (count < 1000000) {
    double result = count / 1000;
    return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}k';
  } else {
    double result = count / 1000000;
    return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
  }
}

}