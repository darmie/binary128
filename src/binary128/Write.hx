package binary128;

import haxe.io.BytesOutput;
import binary128.internal.Leb128;

class Write {
    public static inline function U32(o:BytesOutput, val:Int) {
        Leb128.writeUint32(o, val);
    }

    public static inline function I32(o:BytesOutput, val:Int) {
        Leb128.writeInt32(o, val);
    }


    public static inline function U64(o:BytesOutput, val:Int) {
        Leb128.writeUint64(o, val);
    }

    public static inline function I64(o:BytesOutput, val:Int) {
        Leb128.writeInt64(o, val);
    }
}