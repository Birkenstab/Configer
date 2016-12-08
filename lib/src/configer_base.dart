// Copyright (c) 2016, Moritz Beck (Birkenstab). All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';

/// Class that should be extended to create your own config file
class Config {
    File _configLocation;
    InstanceMirror _instanceMirror;
    ClassMirror _classMirror;
    Map<String, Symbol> _fields = {};
    
    Config( this._configLocation ) {
        _instanceMirror = reflect( this );
        _classMirror = _instanceMirror.type;
        for ( var v in _classMirror.declarations.values ) {
            if ( ! (v is VariableMirror) )
                continue;
            VariableMirror variableMirror = v;
            if ( variableMirror.isStatic || variableMirror.isFinal || variableMirror.isConst )
                continue;
            
            _fields[ MirrorSystem.getName( v.simpleName ) ] = v.simpleName;
        }
    }
    
    /// Loads the config file and saves it
    /// Throws ConfigLoadException when loading or saving failed
    init( ) async {
        try {
            await load( );
        } on ConfigException catch ( e ) {
            if ( e.exception is FileSystemException == false )
                rethrow;
            FileSystemException e2 = e.exception;
            if ( e2.osError.errorCode != 2 ) // 2 => 'No such file or directory'
                rethrow;
        }
        await save( );
    }
    
    /// Loads the config file
    /// Throws ConfigLoadException when the loading failed
    load( ) async {
        var readString;
        try {
            readString = await _configLocation.readAsString( );
        } on FileSystemException catch ( exception ) {
            throw new ConfigException( exception );
        }
        
        var json;
        try {
            json = JSON.decode( readString );
        } on FormatException catch ( exception ) {
            throw new ConfigException( exception );
        }
        _loadFields( json );
    }
    
    save( ) async {
        Map<String, dynamic> json = new Map( );
        _fields.forEach( ( name, symbol ) {
            json[ name ] = _instanceMirror
                .getField( symbol )
                .reflectee;
        } );
        
        JsonEncoder encoder = new JsonEncoder.withIndent( '  ' );
        String jsonString = encoder.convert( json );
        await _configLocation.writeAsString( jsonString );
    }
    
    
    _loadFields( Map<String, dynamic> json ) {
        json.forEach( ( key, value ) {
            if ( ! _fields.containsKey( key ) ) {
                print( "Field was not found: $key" );
                return;
            }
            
            VariableMirror variableMirror = _classMirror.declarations[ _fields[ key] ];
            
            if ( value == null || reflect( value ).type.isAssignableTo(
                variableMirror.type ) ) {
                _instanceMirror.setField( _fields[ key ], value );
            } else {
                print( "Field $key has wrong type: Should be ${variableMirror.type.reflectedType}" );
            }
        } );
    }
}

class ConfigException implements Exception {
    Exception exception;
    
    ConfigException( this.exception );
    
    @override
    String toString( ) {
        return "ConfigException: $exception";
    }
}

