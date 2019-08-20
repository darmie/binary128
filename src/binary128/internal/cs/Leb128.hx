package binary128.internal.cs;

/*
* NFX (.NET Framework Extension) Unistack Library
* Copyright 2003-2018 Agnicore Inc. portions ITAdapter Corp. Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/


import haxe.io.BytesOutput;
import haxe.io.BytesInput;
import haxe.io.Bytes;
/**
 * Implementation gotten from https://github.com/aumcode/nfx/blob/master/Source/NFX/IO/LEB128.cs
 */

#if cs
class Leb128 {
    public static function writeSignedLEB128(buf:BytesOutput, value:cs.types.Int64):Void {
        var more = false;

        do {
            var bt = (value & 0x7f);
            value >>= 7;
            more = !((((value == 0 ) && ((bt & 0x40) == 0)) ||
                    ((value == -1) && ((bt & 0x40) != 0))));
            if (more) bt |= 0x80; // Mark this byte to show that more bytes will follow.
            buf.writeByte(cast bt);
        }while (more);
    }

    public static function writeUnsignedLEB128(buf:BytesOutput, value:cs.types.UInt64):Void {
        do {
            var bt = (value & 0x7f);
            value >>= 7;
            if (value != 0) bt |= 0x80;
            buf.writeByte(cast bt);
        }while(value != 0);
    }

    public static function readSignedLEB128(buf:BytesInput):cs.types.Int64 {
        var bt = 0;

        var value:cs.types.Int64 = 0;
        var shift = 0;

        do {
            var ibt = buf.readByte();
            if (ibt<0) throw "LEB128.ReadSLEB128(premature stream end)";
            bt = ibt;

            value |= (bt & 0x7f) << shift;
            shift += 7;
        }while(bt >= 128);

        // Sign extend negative numbers.
        if ((bt & 0x40)!=0){
            value |= (untyped __cs__('-1L')) << shift;
        }

        return value;
    }

    public static function readUnsignedLEB128(buf:BytesInput):cs.types.UInt64 {
        var value = 0;

        var shift = 0;

        while(true){
            var bt = buf.readByte();
            if (bt<0) throw "LEB128.ReadULEB128(premature stream end)";

            value += (bt & 0x7f)  << shift;

            if (bt<128) break;

            shift += 7;
        }

        return value;
    }
}
#end