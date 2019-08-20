package binary128.internal.cpp;

import haxe.io.BytesOutput;
import haxe.io.BytesInput;
import haxe.io.Bytes;


class Leb128 {
    public static function readUint32(input:BytesInput):Int {

        return Leb128Native.decodeVarUint32(input.readAll());
    }

    public static function readUint64(input:BytesInput):Int {
        return Leb128Native.decodeVarUint64(input.readAll());
    }

    public static function readInt32(input:BytesInput):Int {
        return Leb128Native.decodeVarInt32(input.readAll());
    }

    public static function readInt64(input:BytesInput):Int {
        return Leb128Native.decodeVarInt64(input.readAll());
    }

    public static function writeUint32(value:Int, output:BytesOutput) {
        var buf = Bytes.alloc(output.getBytes().length);
        Leb128Native.encodeVarUint32(value, buf);
        output.writeBytes(buf, 0, buf.length);
    }

    public static function writeUint64(value:Int, output:BytesOutput) {
        var buf = Bytes.alloc(output.getBytes().length);
        Leb128Native.encodeVarUint64(value, buf);
        output.writeBytes(buf, 0, buf.length);
    }

    public static function writeInt32(value:Int, output:BytesOutput) {
        var buf = Bytes.alloc(output.getBytes().length);
        Leb128Native.encodeVarInt32(value, buf);
        output.writeBytes(buf, 0, buf.length);
    }

    public static function writeInt64(value:Int, output:BytesOutput) {
        var buf = Bytes.alloc(output.getBytes().length);
        Leb128Native.encodeVarInt64(value, buf);
        output.writeBytes(buf, 0, buf.length);
    }
}