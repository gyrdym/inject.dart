import 'coffee_app_test.dart' as _i1;
import 'package:inject.example.coffee/src/drip_coffee_module.dart' as _i2;
import 'package:inject.example.coffee/src/electric_heater.dart' as _i3;
import 'dart:async' as _i4;
import 'package:inject.example.coffee/src/coffee_maker.dart' as _i5;
import 'package:inject.example.coffee/src/heater.dart' as _i6;
import 'package:inject.example.coffee/src/pump.dart' as _i7;

class TestCoffee$Injector implements _i1.TestCoffee {
  TestCoffee$Injector.fromModule(this._testModule, this._dripCoffeeModule);

  final _i1.TestModule _testModule;

  final _i2.DripCoffeeModule _dripCoffeeModule;

  _i3.PowerOutlet _powerOutlet;

  _i3.Electricity _singletonElectricity;

  static _i4.Future<_i1.TestCoffee> create(
      _i2.DripCoffeeModule dripCoffeeModule, _i1.TestModule testModule) async {
    final injector =
        TestCoffee$Injector.fromModule(testModule, dripCoffeeModule);
    injector._powerOutlet =
        await injector._dripCoffeeModule.providePowerOutlet();
    return injector;
  }

  _i5.CoffeeMaker _createCoffeeMaker() => _i5.CoffeeMaker(_createHeater(),
      _createPump(), _createBrandNameString(), _createModelNameString());
  _i6.Heater _createHeater() => _testModule.testHeater(_createElectricity());
  _i3.Electricity _createElectricity() => _singletonElectricity ??=
      _dripCoffeeModule.provideElectricity(_createPowerOutlet());
  _i3.PowerOutlet _createPowerOutlet() => _powerOutlet;
  _i7.Pump _createPump() => _dripCoffeeModule.providePump(_createHeater());
  String _createBrandNameString() => _dripCoffeeModule.provideBrand();
  String _createModelNameString() => _testModule.testModel();
  @override
  _i5.CoffeeMaker getCoffeeMaker() => _createCoffeeMaker();
}
