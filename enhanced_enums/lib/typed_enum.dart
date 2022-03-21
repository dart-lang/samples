/// Enum with a Type.
/// 
/// The type [T] is used to define the type of [List] the enum contains.
enum EnumWithType<T> {
  numbers<int>([1, 2, 3]),
  strings<String>(['A', 'B', 'C']);

  final List<T> items;

  const EnumWithType(this.items);
}
