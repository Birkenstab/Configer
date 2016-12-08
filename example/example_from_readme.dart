import 'dart:io';
import 'package:Configer/configer.dart';

main( ) async {
    var myConfig = new TestConfig( new File( "myCoolConf.json" ) );
    await myConfig.init();
    print( myConfig.foo );
    print( myConfig.bar );
    print( myConfig.foobar );
}

class TestConfig extends Config {
    int foo = 34;
    bool bar;
    String foobar = "Default string";
    
    TestConfig( File configLocation ) : super( configLocation );
}