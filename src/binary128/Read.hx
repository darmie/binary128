package binary128;

import binary128.internal.Leb128;
import haxe.io.BytesInput;

class Read {
    public static inline function U32(r:BytesInput):Int {
       return  Leb128.readUint32(r);
    }

    public static function I32(r:BytesInput):Int {
        return Leb128.readInt32(r);
    }


    public static function U64(r:BytesInput):Int {
        return Leb128.readUint64(r);
    }

    public static function I64(r:BytesInput):Int {
        return Leb128.readInt64(r);
    }
}