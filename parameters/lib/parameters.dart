/// Function that counts the amount of [items] that match a given [predicate],
/// with the option to skip the first [skip] elements.
///
/// This function has three parameters:
/// - Required positional parameter [predicate]
/// - Required named parameter [items]
/// - Optional named parameter [skip]
int countWhere<T>(
  bool Function(T) predicate, {
  required Iterable<T> items,
  int skip = 0,
}) {
  return items.skip(skip).where(predicate).length;
}
