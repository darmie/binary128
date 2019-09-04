package binary128.internal;

import haxe.io.Bytes;
import haxe.io.BytesOutput;
import haxe.io.BytesInput;
import haxe.Int32;
import haxe.Int64;

#if cpp 
typedef Leb128T =  binary128.internal.cpp.Leb128;
#end

#if cs 
typedef Leb128T = binary128.internal.cs.Leb128;
#end


#if java 
typedef Leb128T = binary128.internal.java.Leb128;
#end

#if js
typedef Leb128T = binary128.internal.js.Leb128;
#end


/**
 * Common leb128 class
 */
class Leb128 {
    public static function writeInt32(w:BytesOutput, val:I32) {
        #if cpp 
        Leb128T.writeInt32(val, w);
        #end

        #if cs 
        Leb128T.writeSigned32LEB128(w, val);
        #end

        #if java 
        Leb128T.writeSignedLeb128(w, val);
        #end

        #if js
        Leb128T.writeSignedLeb128(w, val);
        #end
        
    }

    public static function writeUint32(w:BytesOutput, val:U32) {
        #if cpp 
        Leb128T.writeUint32(val, w);
        #end

        #if cs 
        Leb128T.writeUnsigned32LEB128(w, val);
        #end

        #if java 
        Leb128T.writeUnsignedLeb128(w, val);
        #end

        #if js
        Leb128T.writeUnsignedLeb128(w, val);
        #end
    }

    public static function writeInt64(w:BytesOutput, val:I64) {
        #if cpp 
        Leb128T.writeInt64(val, w);
        #end

        #if cs 
        Leb128T.writeSigned64LEB128(w, val);
        #end

        #if java 
        Leb128T.writeSignedLeb128(w, cast val);
        #end

        #if js
        Leb128T.writeSignedLeb128(w, cast val);
        #end
    }

    public static function writeUint64(w:BytesOutput, val:U64) {
        #if cpp 
        Leb128T.writeUint64(val, w);
        #end

        #if cs 
        Leb128T.writeUnsigned64LEB128(w, val);
        #end

        #if java 
        Leb128T.writeUnsignedLeb128(w, cast val);
        #end

        #if js
        cast Leb128T.writeUnsignedLeb128(w, val);
        #end
    }

    public static function readInt32(i:BytesInput):I32 {
        #if cpp
        return Leb128T.readInt32(i);
        #end

        #if cs 
        cast return Leb128T.readSignedLEB128(i);
        #end

        #if java 
        return Leb128T.readSignedLeb128(i);
        #end

        #if js
        cast return Leb128T.readSignedLeb128(i);
        #end

       return 0;
    }

    public static function readInt64(i:BytesInput):I64 {
        #if cpp
        return Leb128T.readInt64(i);
        #end

        #if cs 
        return Leb128T.readSignedLEB128(i);
        #end

        #if java 
        return Leb128T.readSignedLeb128(i);
        #end

        #if js 
        cast return Leb128T.readSignedLeb128(i);
        #end

        return 0;
    }

    public static function readUint32(i:BytesInput):U32 {
        #if cpp
        return Leb128T.readUint32(i);
        #end

        #if cs 
        cast return Leb128T.readUnsignedLEB128(i);
        #end

        #if java 
        return Leb128T.readUnsignedLeb128(i);
        #end

        #if js 
        cast return Leb128T.readUnsignedLeb128(i);
        #end

        return 0;
    }

    public static function readUint64(i:BytesInput):U64 {
        #if cpp
        return Leb128T.readUint64(i);
        #end

        #if cs 
        return Leb128T.readUnsignedLEB128(i);
        #end

        #if java 
        return Leb128T.readUnsignedLeb128(i);
        #end

        #if js
        cast return Leb128T.readUnsignedLeb128(i);
        #end

        return 0;
    }


}