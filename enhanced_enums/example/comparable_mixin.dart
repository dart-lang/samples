/// Enum that implements a Comparable using a mixin
enum Ordering with EnumIndexOrdering<Ordering> {
  zero,
  few,
  many;
}

mixin EnumIndexOrdering<T extends Enum> on Enum implements Comparable<T> {
  @override
  int compareTo(T other) => index - other.index;
}
