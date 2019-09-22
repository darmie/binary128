package binary128.internal.java;

/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


import haxe.io.BytesInput;
import haxe.io.BytesOutput;

import java.lang.Integer;

/**
 * Reads and writes DWARFv3 LEB 128 signed and unsigned integers. See DWARF v3
 * section 7.6.
 */
#if java
class Leb128 {
    
    /**
     * Gets the number of bytes in the unsigned LEB128 encoding of the
     * given value.
     *
     * @param value the value in question
     * @return its write size, in bytes
     */
    public static function unsignedLeb128Size(value:Int):Int {
        var remaining:Int = value >> 7;
        var count:Int = 0;

        while(remaining != 0){
            remaining >>= 7;
            count++;
        }

        return count + 1;
    }

    /**
     * Gets the number of bytes in the signed LEB128 encoding of the
     * given value.
     *
     * @param value the value in question
     * @return its write size, in bytes
     */
    public static function signedLeb128Size(value:Int):Int {
        var remaining:Int = value >> 7;
        var count:Int = 0;
        var hasMore = true;
        var end = ((value & IntegerClass.MIN_VALUE) == 0) ? 0 : -1;

        while (hasMore) {
            hasMore = (remaining != end)
                || ((remaining & 1) != ((value >> 6) & 1));

            value = remaining;
            remaining >>= 7;
            count++;
        }

        return count;
    }

    /**
     * Reads a signed integer from {@code in}.
     * @param in 
     * @return Int
     */
    public static function readSignedLeb128(_in:BytesInput){
        var result = 0;
        var cur;
        var count = 0;
        var signBits = -1;

        do {
            cur = _in.readByte() & 0xff;
            result |= (cur & 0x7f) << (count * 7);
            signBits <<= 7;
            count++;
        } while (((cur & 0x80) == 0x80) && count < 5);

        if ((cur & 0x80) == 0x80) {
            throw "invalid LEB128 sequence";
        }

        // Sign extend if appropriate
        if (((signBits >> 1) & result) != 0 ) {
            result |= signBits;
        }

        return result;
    }

    public static function readSigned64Leb128(_in:BytesInput):I64{
        var result = 0;
        var cur;
        var count = 0;
        var signBits = -1;

        do {
            cur = _in.readByte() & 0xff;
            result |= (cur & 0x7f) << (count * 7);
            signBits <<= 7;
            count++;
        } while (((cur & 0x80) == 0x80) && count < 5);

        if ((cur & 0x80) == 0x80) {
            throw "invalid LEB128 sequence";
        }

        // Sign extend if appropriate
        if (((signBits >> 1) & result) != 0 ) {
            result |= signBits;
        }

        return result;
    }

    /**
     * Reads an unsigned integer from {@code in}.
     * @param in 
     * @return Int
     */
    public static function readUnsignedLeb128(_in:BytesInput) {
        var result = 0;
        var cur;
        var count = 0;

        do {
            cur = _in.readByte() & 0xff;
            result |= (cur & 0x7f) << (count * 7);
            count++;
        } while (((cur & 0x80) == 0x80) && count < 5);

        if ((cur & 0x80) == 0x80) {
            throw "invalid LEB128 sequence";
        }

        return result;
    }

    public static function readUnsigned64Leb128(_in:BytesInput):U64 {
        var result:I64 = 0;
        var shift:Int = 0;
        var count = 0;

        while((_in.readByte() & 0x80) != 0){
            var data:I64 = _in.readByte() & 0xff << shift;
            shift += 7;
            result |= data;
        }
        result |= _in.readByte()<<shift;

        return result;
    }

    /**
     * Writes {@code value} as an unsigned integer to {@code out}, starting at
     * {@code offset}. Returns the number of bytes written.
     */
    public static  function writeUnsignedLeb128(out:BytesOutput, value):Void {
        var remaining = value >>> 7;

        while (remaining != 0) {
            out.writeByte(((value & 0x7f) | 0x80));
            value = remaining;
            remaining >>>= 7;
        }

        out.writeByte((value & 0x7f));
    }

    public static  function writeSignedLeb128(out:BytesOutput, value):Void {
        var remaining = value >>> 7;
        var hasMore = true;
        var end = ((value & IntegerClass.MIN_VALUE) == 0) ? 0 : -1;
        while (hasMore) {
            hasMore = (remaining != end)
                    || ((remaining & 1) != ((value >> 6) & 1));

            out.writeByte(((value & 0x7f) | (hasMore ? 0x80 : 0)));
            value = remaining;
            remaining >>= 7;
        }
    }

    
}
#end