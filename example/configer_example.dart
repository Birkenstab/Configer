// Copyright (c) 2016, Moritz Beck (Birkenstab). All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:Configer/configer.dart';

main( ) async {
    var myConfig = new TestConfig( new File( "myConf.json" ) );
    await myConfig.init();
    print( myConfig );
}

class TestConfig extends Config {
    String myString;
    int foo = 34;
    bool bar;
    String foobar;
    bool barfoo;
    var thisIsADynamicField;

    TestConfig( File configLocation ) : super( configLocation );

    @override
    String toString( ) {
        return 'TestConfig{myString: $myString, foo: $foo, bar: $bar, foobar: $foobar, barfoo: $barfoo, thisIsADynamicField: $thisIsADynamicField}';
    }
    
    
}