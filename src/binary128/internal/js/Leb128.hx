package binary128.internal.js;

import haxe.io.BytesInput;
import haxe.Int32;
import haxe.Int64;
import haxe.io.BytesOutput;

class Leb128 {
	public static function writeSignedLeb128(w:BytesOutput, val) {
		var more = true;
		while (more) {
			var byte = val & 0x7f;
			val >>>= 7;
			if ((val == 0 && (byte & 0x40) == 0) || (val == -1 && (byte & 0x40) != 0)) {
				more = false;
			} else {
				byte |= 0x80;
			}
			w.writeByte(byte);
		}
	}

	public static function writeUnsignedLeb128(w:BytesOutput, val) {
		do {
			var byte = val & 0x7f;
			val >>>= 7;
			if (val != 0) {
				byte |= 0x80;
			}
			w.writeByte(byte);
		} while (val != 0);
	}

    public static function readUnsignedLeb128(r:BytesInput) {
        var val = 0;
        var shift = 0;
        var byt = null;
        var pos = 0;

        while(true){
            var bt = r.readByte();
            // if (bt<0) throw "LEB128.ReadULEB128(premature stream end)";

            val += (bt & 0x7f)  << shift;

            if (bt<128) break;

            shift += 7;
        }
        return val;
    }

    public static function readSignedLeb128(r:BytesInput) {
        var val = 0;
        var shl = 0;
        var byt = null;
        var pos = 0;

        var signBits = -1;

        do {
            
            byt = r.readByte();
            pos++;
            val |= (byt & 0x7F) << shl;
            signBits <<= 7;
            // if (!((byt & 0x80) == 0)) break;
            shl += 7;
        }while (byt >= 128);

        if (((signBits >> 1) & val) != 0 ) {
            val |= signBits;
        }

        return val;
    }

    
}
