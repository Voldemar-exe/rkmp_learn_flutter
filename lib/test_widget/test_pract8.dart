/*
class MyClass {
  const MyClass({
    required String singleArg,
    required String anotherOne,
    required String anotherTwo,
    required String anotherThree,
    required String anotherFour,
    required String anotherFive,
    required String anotherSix,
    required String anotherSeven,
    required String anotherEight,
    required String anotherNine,
    required String anotherTen,
  });
}
void main() {

  const obj = MyClass(
    singleArg: "only one",
    anotherOne: 'only two',
    anotherTwo: 'only three',
    anotherThree: 'only four',
    anotherFour: 'only five',
    anotherFive: 'only six',
    anotherSix: 'only seven',
    anotherSeven: 'only eight',
    anotherEight: 'please stop',
    anotherNine: 'please',
    anotherTen: 'stop',
  );
}*/
import 'package:flutter/material.dart';

class MyLogic extends InheritedWidget {
  final int number;

  const MyLogic({super.key, required this.number, required super.child});

  @override
  bool updateShouldNotify(covariant MyLogic oldWidget) =>
      oldWidget.number != number;

  static MyLogic of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyLogic>()!;
}

class MyClass {}
abstract class MyModel {
  void doSomething();
}
abstract class MyAPI {
  Future<String> fetchData();
}
class MyModelImplementation implements MyModel {
  @override
  void doSomething() {}
}
class MyAPIImplementation implements MyAPI {
  @override
  Future<String> fetchData() async {
    return "Data from API";
  }
}
/*
void main() {

  GetIt.instance.registerSingleton<MyModel>(MyModelImplementation());
  GetIt.I.registerLazySingleton<MyAPI>(() => MyAPIImplementation());

  // access to the Singleton instance of GetIt
  GetIt getItFull = GetIt.instance;
  // Short form to access the instance of GetIt
  GetIt getItShort = GetIt.I;

  GetIt.I.registerFactory(() => MyClass(), instanceName: 'my_class');
  GetIt.I.isRegistered<MyClass>(instanceName: 'my_class');

  // get instance of MyClass
  var myClassFull = GetIt.instance<MyClass>();
  // Short form to get instance of MyClass
  var myClassShort = GetIt.I<MyClass>();

}*/
