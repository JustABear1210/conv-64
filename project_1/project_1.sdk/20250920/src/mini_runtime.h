#pragma once


typedef signed char        int8_t;
typedef short              int16_t;
//typedef int                int32_t;
typedef long long          int64_t;
typedef unsigned char      uint8_t;
typedef unsigned short     uint16_t;
//typedef unsigned int       uint32_t;
typedef unsigned long long uint64_t;

static inline void memset_fast(void* dst, int v, unsigned int n) {
    uint8_t* p = (uint8_t*)dst;
    uint8_t  b = (uint8_t)v;
    for (unsigned int i=0;i<n;++i) p[i] = b;
}

static inline void memcpy_fast(void* dst, const void* src, unsigned int n) {
    uint8_t* d = (uint8_t*)dst;
    const uint8_t* s = (const uint8_t*)src;
    for (unsigned int i=0;i<n;++i) d[i] = s[i];
}


static inline float tanhf_fast(float x) {
    const float x2 = x * x;
    const float num = x * (27.0f + x2);
    const float den = 27.0f + 9.0f * x2;
    float y = num / den;

    if (y > 1.0f) y = 1.0f;
    if (y < -1.0f) y = -1.0f;
    return y;
}


static inline float sigmoidf_fast(float x) {
    return 0.5f * (tanhf_fast(0.5f * x) + 1.0f);
}
