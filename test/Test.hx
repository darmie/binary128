package;

import binary128.internal.Leb128;
import haxe.io.BytesBuffer;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import haxe.io.Bytes;


typedef UintTest = {
	v:Int,
	b:Bytes
}


class Test {
    static var casesUint:Array<UintTest>;

    public static function main() {
        testUnsigned32();
		testSigned32();
		testReadWriteInt64();
		testReadWriteInt32();
		testReadWriteUInt32();
    }

	static function  testUnsigned32(){
		casesUint = [];

		var buf1 = new BytesBuffer();
		 buf1.addByte(0x08);
		 var b1 = buf1.getBytes();
		casesUint.push({
			b: b1,
			v: 8
		});

		var buf2 = new BytesBuffer();

		buf2.addByte(0x80);
		buf2.addByte(0x7f);
		
		var b2 = buf2.getBytes();

		casesUint.push({
			b: b2,
			v: 16256
		});

		var buf3 = new BytesBuffer();
		buf3.addByte(0x80);
		buf3.addByte(0x80);
		buf3.addByte(0x80);
		buf3.addByte(0xfd);
		buf3.addByte(0x07);


		casesUint.push({
			b: buf3.getBytes(),
			v: 2141192192
		});

      	for(c in casesUint){
			var n = Leb128.readUint32(new BytesInput(c.b));
			if(n != cast c.v){
				// Console.error('[Ui32] got $n expected ${c.v}');
                trace('[Ui32] got $n expected ${c.v}');
			} else {
				// Console.success('[Ui32] $n == ${c.v} : true');
                trace('[Ui32] $n == ${c.v} : true');
			}
			
		}
	}

	static function testSigned32(){

        // trace(cast(cs.system.Int32.MinValue, cs.system.Int64));
		
		casesUint = [];

		var buf1 = new BytesBuffer();
		 buf1.addByte(0x80);
		 buf1.addByte(0x80);
		 buf1.addByte(0x80);
		 buf1.addByte(0x80);
		 buf1.addByte(0x78);
		 var b1 = buf1.getBytes();
		casesUint.push({
			b: b1,
			v: -2147483648
		});

        // trace(cs.system.BitConverter.ToInt64(b1.getData(), 0));

		var buf2 = new BytesBuffer();
		 buf2.addByte(0xff);
		 buf2.addByte(0xff);
		 buf2.addByte(0xff);
		 buf2.addByte(0xff);
		 buf2.addByte(0x07);
		 var b2 = buf2.getBytes();
		casesUint.push({
			b: b2,
			v: 2147483647
		});

		var buf3 = new BytesBuffer();
		buf3.addByte(0x80);
		buf3.addByte(0x40);
		
		casesUint.push({
			b: buf3.getBytes(),
			v: -8192
		});

		var buf4 = new BytesBuffer();
		buf4.addByte(0x80);
		buf4.addByte(0xc0);
		buf4.addByte(0x00);
		
		casesUint.push({
			b: buf4.getBytes(),
			v: 8192
		});

		var buf5 = new BytesBuffer();
		buf5.addByte(135);
		buf5.addByte(0x01);
		
		casesUint.push({
			b: buf5.getBytes(),
			v: 135
		});

		for(c in casesUint){
			var n = Leb128.readInt32(new BytesInput(c.b));
			if(n != c.v){
				// Console.error('[i32] got $n expected ${c.v}');
                trace('[i32] got $n expected ${c.v}');
                
			} else {
				// Console.success('[i32] $n == ${c.v} : true');
                trace('[i32] $n == ${c.v} : true');
			}
			
		}
	}

	static function testReadWriteInt64() {
		var buf = Bytes.alloc(16);
		for(i in 0...1000000){
			var _in = new BytesInput(buf);
			_in.readFullBytes(buf, 0, buf.length);
			var reader = new BytesInput(buf);
			var val = Leb128.readInt64(reader);
			var readLen = buf.length - reader.length;
			if(readLen > (64+6)/7){
				// Console.error('[i64] read len:$readLen larger then ceil(N/7) bytes');
                trace('[i64] read len:$readLen larger then ceil(N/7) bytes');
				return;
			}
			var buf2 = new BytesOutput();
			
			Leb128.writeInt64(buf2, val);
			var b2 = buf2.getBytes();
			if(readLen <= b2.length){
				if(!(buf.length >= b2.length && buf.sub(0, b2.length).compare(b2) == 0)){
					// Console.error('val:$val, origin buf:${buf.getData()}, buf2:${b2.getData()}');
                    trace('val:$val, origin buf:${buf.getData()}, buf2:${b2.getData()}');
				}
			}
		}
		// Console.success('[i64] readWrite : Sucess');
        trace('[i64] readWrite : Sucess');

	}

	static function testReadWriteInt32() {
		var buf = Bytes.alloc(16);
		for(i in 0...1000000){
			var _in = new BytesInput(buf);
			_in.readFullBytes(buf, 0, buf.length);
			var reader = new BytesInput(buf);
			var val = Leb128.readInt32(reader);
			var readLen = buf.length - reader.length;
			if(readLen > (32+6)/7){
				// Console.error('[i32] read len:$readLen larger then ceil(N/7) bytes');
                trace('[i32] read len:$readLen larger then ceil(N/7) bytes');
				return;
			}
			var buf2 = new BytesOutput();
			
			Leb128.writeInt64(buf2, val);
			var b2 = buf2.getBytes();
			if(readLen <= b2.length){
				if(!(buf.length >= b2.length && buf.sub(0, b2.length).compare(b2) == 0)){
					// Console.error('val:$val, origin buf:${buf.getData()}, buf2:${b2.getData()}');
                    trace('val:$val, origin buf:${buf.getData()}, buf2:${b2.getData()}');
				}
			}
		}
		// Console.success('[i32] readWrite : Sucess');
        trace('[i32] readWrite : Sucess');

	}

	static function testReadWriteUInt32() {
		var buf = Bytes.alloc(16);
		for(i in 0...1000000){
			var _in = new BytesInput(buf);
			_in.readFullBytes(buf, 0, buf.length);
			var reader = new BytesInput(buf);
			var val = Leb128.readUint32(reader);
			var readLen = buf.length - reader.length;
			if(readLen > (32+6)/7){
				// Console.error('[u32] read len:$readLen larger then ceil(N/7) bytes');
                trace('[u32] read len:$readLen larger then ceil(N/7) bytes');
				return;
			}
			var buf2 = new BytesOutput();
			
			Leb128.writeUint32(buf2, val);
			var b2 = buf2.getBytes();
			if(readLen <= b2.length){
				if(!(buf.length >= b2.length && buf.sub(0, b2.length).compare(b2) == 0)){
					// Console.error('val:$val, origin buf:${buf.getData()}, buf2:${b2.getData()}');
                    trace('val:$val, origin buf:${buf.getData()}, buf2:${b2.getData()}');
				}
			}
		}
		// Console.success('[u32] readWrite : Sucess');
        trace('[u32] readWrite : Sucess');

	}
}