# <img src="https://uploads-ssl.webflow.com/5ea5d3315186cf5ec60c3ee4/5edf1c94ce4c859f2b188094_logo.svg" alt="Pip.Services Logo" width="200"> <br/> Portable Abstractions and Patterns for Dart

This module is a part of the [Pip.Services](http://pip.services.org) polyglot microservices toolkit.
It provides a set of basic patterns used in microservices or backend services.
Also the module implemenets a reasonably thin abstraction layer over most fundamental functions across
all languages supported by the toolkit to facilitate symmetric implementation.

The module contains the following packages:

- **Commands** - commanding and eventing patterns
- **Config** - configuration framework
- **Convert** - soft value converters
- **Data** - data patterns
- **Errors** - application errors
- **Random** - random data generators
- **Refer** - locator (IoC) pattern
- **Reflect** - reflection framework
- **Run** - execution framework
- **Validate** - validation framework

<a name="links"></a> Quick links:

* [Configuration Pattern](https://www.pipservices.org/recipies/configuration) 
* [Locator Pattern](https://www.pipservices.org/recipies/references)
* [Component Lifecycle](https://www.pipservices.org/recipies/component-lifecycle)
* [Components with Active Logic](https://www.pipservices.org/recipies/active-logic)
* [Data Patterns](https://www.pipservices.org/recipies/memory-persistence)
* [API Reference](https://pub.dev/documentation/pip_services3_commons/latest/pip_services3_commons/pip_services3_commons-library.html)
* [Change Log](CHANGELOG.md)
* [Get Help](https://www.pipservices.org/community/help)
* [Contribute](https://www.pipservices.org/community/contribute)

## Use

Add this to your package's pubspec.yaml file:
```yaml
dependencies:
  pip_services3_commons: version
```

Now you can install package from the command line:
```bash
pub get
```

Then you are ready to start using the Pip.Services patterns to augment your backend code.

For instance, here is how you can implement a component, that receives configuration, get assigned references,
can be opened and closed using the patterns from this module.

```dart
class MyComponentA implements IConfigurable, IReferenceable, IOpenable {
  MyComponentA();

  String _param1 = 'ABC';
  int _param2 = 123;
  MyComponentB _anotherComponent;
  bool _opened = true;

  @override
  void configure(ConfigParams config) {
    this._param1 = config.getAsStringWithDefault('param1', this._param1);
    this._param2 = config.getAsIntegerWithDefault('param2', this._param2);
  }

  @override
  void setReferences(IReferences refs) {
    this._anotherComponent = refs.getOneRequired<MyComponentB>(
      Descriptor('myservice', 'mycomponent-b', '*', '*', '1.0')
    );
  }

  @override
  bool isOpen() {
    return this._opened;
  }

  @override
  Future open(String? correlationId) {
    return Future(() {
      this._opened = true;
      print('MyComponentA has been opened.');
    });
  }

  @override
  Future close(String? correlationId) {
    return Future(() {
      this._opened = true;
      print('MyComponentA has been closed.');
    });
  }
}
```

Then here is how the component can be used in the code

```dart
import 'package:pip_services3_commons/src/config/ConfigParams.dart';
import 'package:pip_services3_commons/src/refer/References.dart';
import 'package:pip_services3_commons/src/refer/DependencyResolver.dart';

var myComponentA = MyComponentA();

// Configure the component
myComponentA.configure(ConfigParams.fromTuples([
  'param1', 'XYZ',
  'param2', 987
]));

// Set references to the component
myComponentA.setReferences(References.fromTuples([
   Descriptor('myservice', 'mycomponent-b', 'default', 'default', '1.0',) myComponentB
]));

// Open the component
myComponentA.open('123');
```


## Develop

For development you shall install the following prerequisites:
* Dart SDK 2
* Visual Studio Code or another IDE of your choice
* Docker

Install dependencies:
```bash
pub get
```

Run automated tests:
```bash
pub run test
```

Generate API documentation:
```bash
./docgen.ps1
```

Before committing changes run dockerized build and test as:
```bash
./build.ps1
./test.ps1
./clear.ps1
```

## Contacts

The library is created and maintained by **Sergey Seroukhov**, **Levichev Dmitry**, **Alexey Dvoykin**.

The documentation is written by **Egor Nuzhnykh**, **Alexey Dvoykin**, **Mark Makarychev**, **Levichev Dmitry**.
