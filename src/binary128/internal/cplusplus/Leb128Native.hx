package binary128.internal.cplusplus;

import haxe.Int64;
import haxe.io.*;


class Leb128Native {

	public static  function decodeVarUint32(input:BytesInput):cpp.UInt32 {
        var ret:U32 = 0;
        var count = 0;
		var signBits = 0;
        while(true){
            var byte:cpp.Int8 = input.readByte();
            ret |= (byte & 127) << (7 * count);
			signBits <<= 7;
            count++;
            if((byte & 128) == 0) {
                break;
            }
        }
		// Sign extend if appropriate
        if (((signBits >> 1) & ret) != 0 ) {
            ret |= signBits;
        }
		return ret;
	}

	public static  function decodeVarUint64(input:BytesInput):cpp.UInt64 {
		var ret:U64 = 0;
        var count = 0;
		var signBits = 0;
        while(true){
            var byte:cpp.Int8 = input.readByte();
            ret |= (byte & 127) << (7 * count);
            count++;
			signBits <<= 7;
            if((byte & 128) == 0) {
                break;
            }
        }
		// Sign extend if appropriate
        if (((signBits >> 1) & ret) != 0 ) {
            ret |= signBits;
        }
		return ret;
	}

	public static  function decodeVarInt32(input:BytesInput):cpp.Int32 {
		var bt = 0;

        var value:cpp.UInt32 = 0;
        var shift = 0;

        do {
            var ibt = input.readByte();
            if (ibt<0) throw "LEB128.ReadSLEB128(premature stream end)";
            bt = ibt;

            value |= (bt & 0x7f) << shift;
            shift += 7;
        }while(bt >= 128);

        // Sign extend negative numbers.
        if ((bt & 0x40)!=0){
            value |= -1 << shift;
        }

        return value;
	}

	public static  function decodeVarInt64(input:BytesInput):cpp.Int64 {
		var value:cpp.Int64 = 0;

        var shift = 0;

        while(true){
            var bt = input.readByte();
            if (bt<0) throw "LEB128.ReadULEB128(premature stream end)";

            value += (bt & 0x7f)  << shift;

            if (bt<128) break;

            shift += 7;
        }

        return value;
	}

	public static  function encodeVarUint32(value:U32, output:BytesOutput) {
		do {
			var byte = value & 0x7f;
			value >>= 7;
			if (value == 0) {
				output.writeByte(byte);
				break;
			} else {
				output.writeByte(byte | 0x80);
			}
		} while (true);
	}

	public static  function encodeVarUint64(value:U64, output:BytesOutput) {
		do {
			var byte = value & 0x7f;
			value >>= 7;
			if (value == 0) {
				output.writeByte(byte);
				break;
			} else {
				output.writeByte(byte | 0x80);
			}
		} while (true);
	}

	public static  function encodeVarInt32(value:haxe.Int32, output:BytesOutput) {
		do {
			var byte = cast(value, cpp.UInt8) & 0x7f;
			value >>= 7;
			if (value == 0) {
				output.writeByte(byte);
				break;
			} else {
				output.writeByte(byte | 0x80);
			}
		} while (true);
	}

	public static  function encodeVarInt64(value:haxe.Int64, output:BytesOutput) {
		do {
			var byte = Int64.toInt(value) & 0x7f;
			value >>= 7;
			if (value == 0) {
				output.writeByte(byte);
				break;
			} else {
				output.writeByte(byte | 0x80);
			}
		} while (true);
		// do {
		// 	var byte = Int64.toInt(value) & 0x7f;
		// 	trace(byte);
		// 	value >>= 7;
		// 	if (value < 0) {
		// 		if (value == -1 && (byte & 0x40) != 0) {
		// 			output.writeByte(byte);
		// 			break;
		// 		} else {
		// 			output.writeByte(byte | 0x80);
		// 		}
		// 	} else {
		// 		if (value == 0 && (byte & 0x40) != 0) {
		// 			output.writeByte(byte);
		// 			break;
		// 		} else {
		// 			output.writeByte(byte | 0x80);
		// 		}
		// 	}
		// } while (true);
	}
}
