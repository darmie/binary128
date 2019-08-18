package binary128.internal.cpp;

import ammer.Library;
import ammer.ffi.*;
import haxe.io.Bytes;
import cpp.UInt32;
import cpp.UInt64;

import cpp.Int32;
import cpp.Int64;

class Leb128Impl extends Library<"leb128"> {
    public static function decodeVarUint32(input:Bytes, size:SizeOf<"input">)):UInt32;
    public static function decodeVarUint64(input:Bytes, size:SizeOf<"input">)):UInt64;

    public static function decodeVarInt32(input:Bytes, size:SizeOf<"input">)):Int32;
    public static function decodeVarInt64(input:Bytes, size:SizeOf<"input">)):Int64;


    public static function encodeVarUint32(value:UInt32, output:Bytes)):Int;
    public static function encodeVarUint64(value:UInt64, output:Bytes)):Int;

    public static function encodeVarInt32(value:Int32, output:Bytes)):Int;
    public static function encodeVarInt64(value:Int64, output:Bytes)):Int;

}



class Leb128 {
    public static function readUint32(input:Bytes):UInt32 {
        return decodeVarUint32(input);
    }

    public static function readUint64(input:Bytes):UInt64 {
        return decodeVarUint64(input);
    }

    public static function readInt32(input:Bytes):Int32 {
        return decodeVarInt32(input);
    }

    public static function readInt64(input:Bytes):Int64 {
        return decodeVarInt64(input);
    }

    public static function writeUint32(value:UInt32, output:Bytes) {
        encodeVarUint32(value, output);
    }

    public static function writeUint64(value:UInt64, output:Bytes) {
        encodeVarUint64(value, output);
    }

    public static function writeInt32(value:Int32, output:Bytes) {
        encodeVarInt32(value, output);
    }

    public static function writeInt64(value:Int64, output:Bytes) {
        encodeVarInt64(value, output);
    }
}