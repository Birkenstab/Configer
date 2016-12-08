// Copyright (c) 2016, Moritz Beck (Birkenstab). All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:configer/configer.dart';
import 'package:test/test.dart';
import 'dart:io';

void main( ) {
    group( 'Basic tests', ( ) {
        test( 'First Test', ( ) async {
            // Saving config
            MyTestConfig config1 = new MyTestConfig();
            config1.init();
            config1.field4 = true;
            config1.temperature = 5456235;
            config1.myString = "World!";
            await config1.save();
            
            MyTestConfig config2 = new MyTestConfig();
            await config2.init();
            expect( config2.myString, "World!" );
            expect( config2.temperature, 5456235 );
            expect( config2.secondString, null );
            expect( config2.field4, true );
            expect( config2.field5, null );
            
            await new File( "test1.json" ).delete();
        } );
    } );
}

class MyTestConfig extends Config {
    String myString = "hello";
    int temperature;
    String secondString;
    bool field4 = false;
    bool field5;
    
    MyTestConfig() : super( new File( "test1.json" ) );
}
