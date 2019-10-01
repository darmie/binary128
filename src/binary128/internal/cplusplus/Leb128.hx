package binary128.internal.cplusplus;

import haxe.io.BytesOutput;
import haxe.io.BytesInput;
import haxe.io.Bytes;


class Leb128 {
    public static function readUint32(input:BytesInput):cpp.UInt32 {
        return cast Leb128Native.decodeVarUint32(input);
    }

    public static function readUint64(input:BytesInput):cpp.UInt64 {
        return cast Leb128Native.decodeVarUint64(input);
    }

    public static function readInt32(input:BytesInput):haxe.Int32 {
        return cast Leb128Native.decodeVarInt32(input);
    }

    public static function readInt64(input:BytesInput):haxe.Int64 {
        return cast Leb128Native.decodeVarInt64(input);
    }

    public static function writeUint32(value:U32, output:BytesOutput) {
        Leb128Native.encodeVarUint32(value, output);
    }

    public static function writeUint64(value:cpp.UInt64, output:BytesOutput) {
        Leb128Native.encodeVarUint64(value, output);
    }

    public static function writeInt32(value:haxe.Int32, output:BytesOutput) {
        Leb128Native.encodeVarInt32(value, output);
    }

    public static function writeInt64(value:haxe.Int64, output:BytesOutput) {
        Leb128Native.encodeVarInt64(value, output);
    }
}