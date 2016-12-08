# Configer

Configer is a small library for Dart that makes creating config files easy.

Early alpha state of development! But it works :D

Inspired by Yamler of geNAZt (https://www.spigotmc.org/resources/yamler.315/)

## Usage

A simple usage example:

    import 'dart:io';
    import 'package:Configer/configer.dart';
    
    main( ) async {
        var myConfig = new TestConfig( new File( "myCoolConf.json" ) );
        await myConfig.init();
        print( myConfig.foo ); // Outputs the value in
        print( myConfig.bar ); // myCoolConf.json or the
        print( myConfig.foobar ); // default value if there is one
    }
    
    class TestConfig extends Config {
        int foo = 34;
        bool bar;
        String foobar;
    
        TestConfig( File configLocation ) : super( configLocation );
    }
This generates a file myCoolConf.json which contains the default values:

    {
      "foo": 34,
      "bar": null,
      "foobar": "Default string"
    }
Just edit the config and see the result!


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Birkenstab/Configer/issues
