/// Enum that implements a Comparable
enum Quantity implements Comparable<Quantity> {
  zero(0),
  one(1),
  many(99);

  final int quantity;

  const Quantity(this.quantity);

  @override
  int compareTo(Quantity other) => quantity - other.quantity;
}
