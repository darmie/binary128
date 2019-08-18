#ifdef __cplusplus
extern "C" {
#endif

#ifdef _WIN32
  #define LIB_EXPORT __declspec(dllexport)
#else
  #define LIB_EXPORT
#endif

#include <stdlib.h>

#ifdef HXCPP
#include <hxcpp.h>
#endif


class leb128 {
    public: 
    template<typename int_t = uint64_t>
    size_t encodeVarint(int_t value, unsigned char *output) {
        size_t outputSize = 0;
        //While more than 7 bits of data are left, occupy the last output byte
        // and set the next byte flag
        while (value > 127) {
            //|128: Set the next byte flag
            output[outputSize] = ((uint8_t)(value & 127)) | 128;
            //Remove the seven bits we just wrote
            value >>= 7;
            outputSize++;
        }
        output[outputSize++] = ((uint8_t)value) & 127;
        return outputSize;
    }

    template<typename int_t = uint64_t>
    int_t decodeVarint(unsigned char *input, size_t inputSize) {
        int_t ret = 0;
        for (size_t i = 0; i < inputSize; i++) {
            ret |= (input[i] & 127) << (7 * i);
            //If the next-byte flag is set
            if(!(input[i] & 128)) {
                break;
            }
        }
        return ret;
    }

    LIB_EXPORT uint32_t decodeVarUint32(unsigned char *input, size_t inputSize) {
        return decodeVarint<uint32_t>(input, inputSize);
    }
    LIB_EXPORT int32_t decodeVarInt32(unsigned char *input, size_t inputSize) {
        return decodeVarint<int32_t>(input, inputSize);
    }

    LIB_EXPORT uint64_t decodeVarUint64(unsigned char *input, size_t inputSize) {
        return decodeVarint<uint64_t>(input, inputSize);
    }
    LIB_EXPORT int64_t decodeVarInt64(unsigned char *input, size_t inputSize) {
        return decodeVarint<int64_t>(input, inputSize);
    }

    LIB_EXPORT uint8_t decodeVarUint8(unsigned char *input, size_t inputSize) {
        return decodeVarint<uint8_t>(input, inputSize);
    }
    LIB_EXPORT int8_t decodeVarInt8(unsigned char *input, size_t inputSize) {
        return decodeVarint<int8_t>(input, inputSize);
    }



    LIB_EXPORT size_t encodeVarInt32(int32_t value, unsigned char *output) {
        return encodeVarint<int32_t>(value, output);
    }

    LIB_EXPORT size_t encodeVarUint32(uint32_t value, unsigned char *output) {
        return encodeVarint<uint32_t>(value, output);
    }

    LIB_EXPORT size_t encodeVarUint64(uint64_t value, unsigned char *output) {
        return encodeVarint<uint64_t>(value, output);
    }

    LIB_EXPORT size_t encodeVarInt64(int64_t value, unsigned char *output) {
        return encodeVarint<int64_t>(value, output);
    }

    LIB_EXPORT size_t encodeVarUint8(uint8_t value, unsigned char *output) {
        return encodeVarint<uint8_t>(value, output);
    }

    LIB_EXPORT size_t encodeVarInt8(int8_t value, unsigned char *output) {
        return encodeVarint<int64_t>(value, output);
    }
};

#ifdef __cplusplus
}
#endif