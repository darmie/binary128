package binary128.internal.cpp;


import ammer.Library;
import ammer.ffi.*;
import haxe.io.Bytes;

class Leb128Native extends Library<"leb128"> {
    public static inline function decodeVarUint32(input:Bytes, size:SizeOf<"input">):Int;
    public static inline function decodeVarUint64(input:Bytes, size:SizeOf<"input">):Int;

    public static inline function decodeVarInt32(input:Bytes, size:SizeOf<"input">):Int;
    public static inline function decodeVarInt64(input:Bytes, size:SizeOf<"input">):Int;


    public static inline function encodeVarUint32(value:Int, output:Bytes, size:SizeOf<"output">):Int;
    public static inline function encodeVarUint64(value:Int, output:Bytes, size:SizeOf<"output">):Int;

    public static inline function encodeVarInt32(value:Int, output:Bytes, size:SizeOf<"output">):Int;
    public static inline function encodeVarInt64(value:Int, output:Bytes, size:SizeOf<"output">):Int;

}