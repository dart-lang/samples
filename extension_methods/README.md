# Extension methods samples

This a set of samples that demonstrates the extension methods syntax
and shows some common use cases of the feature.

This feature was added in Dart 2.6.0. The programs in this folder won't
compile in earlier versions.

## Instructions

Read the source code in the `example/` directory. The code is split into
separate files according to topics or use cases. For instance,
`example/generics.dart` explores the intersection between extension methods
and generic types, while `example/operator_extensions.dart` shows how
you can extend classes with operators.

The files in `lib/` are support for the samples in `example/`. For instance,
`lib/some_api.dart` is pretending to be an API from another package (because
a common use case for extension methods is to modify classes whose source
code we cannot edit).
