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
    LIB_EXPORT size_t encodeVarint(int_t value, Array<unsigned char> output) {
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
    LIB_EXPORT int_t decodeVarint(Array<unsigned char> input, size_t inputSize) {
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
};

#ifdef __cplusplus
}
#endif