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


/**
 * Common leb128 class
 */
class Leb128 {
    public static function writeInt32(w:BytesOutput, val) {
        #if cpp 
        Leb128T.writeInt32(cast val, w);
        #end

        #if cs 
        Leb128T.writeSignedLEB128(w, cast val);
        #end

        #if java 
        Leb128T.writeSignedLeb128(w, cast val);
        #end
        
    }

    public static function writeUint32(w:BytesOutput, val) {
        #if cpp 
        Leb128T.writeUint32(cast val, w);
        #end

        #if cs 
        Leb128T.writeUnsignedLEB128(w, cast val);
        #end

        #if java 
        Leb128T.writeUnsignedLeb128(w, cast val);
        #end
    }

    public static function writeInt64(w:BytesOutput, val) {
        #if cpp 
        Leb128T.writeInt64(cast val, w);
        #end

        #if cs 
        Leb128T.writeSignedLEB128(w, cast val);
        #end

        #if java 
        Leb128T.writeSignedLeb128(w, cast val);
        #end
    }

    public static function writeUint64(w:BytesOutput, val) {
        #if cpp 
        Leb128T.writeUint64(cast val, w);
        #end

        #if cs 
        Leb128T.writeUnsignedLEB128(w, cast val);
        #end

        #if java 
        Leb128T.writeUnsignedLeb128(w, cast val);
        #end
    }

    public static function readInt32(i:BytesInput) {
        #if cpp
        return Leb128T.readInt32(i);
        #end

        #if cs 
        return Leb128T.readSignedLEB128(i);
        #end

        #if java 
        return Leb128T.readSignedLeb128(i);
        #end
    }

    public static function readInt64(i:BytesInput) {
        #if cpp
        return Leb128T.readInt64(i);
        #end

        #if cs 
        return Leb128T.readSignedLEB128(i);
        #end

        #if java 
        return Leb128T.readSignedLeb128(i);
        #end
    }

    public static function readUint32(i:BytesInput) {
        #if cpp
        return Leb128T.readUint32(i);
        #end

        #if cs 
        return Leb128T.readUnsignedLEB128(i);
        #end

        #if java 
        return Leb128T.readUnsignedLeb128(i);
        #end
    }

    public static function readUint64(i:BytesInput) {
         #if cpp
        return Leb128T.readUint64(i);
        #end

        #if cs 
        return Leb128T.readUnsignedLEB128(i);
        #end

        #if java 
        return Leb128T.readUnsignedLeb128(i);
        #end
    }


}