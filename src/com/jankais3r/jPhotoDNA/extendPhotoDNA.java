package com.jankais3r.jPhotoDNA;

import com.sun.jna.Library;
import com.sun.jna.Pointer;

public interface extendPhotoDNA extends Library {
    Pointer RobustHashInitBuffer(int int0);
    void RobustHashReleaseBuffer(Pointer pointer1);
    int ComputeRobustHash(byte[] byteArray1, int int1, int int2, int int3, byte[] byteArray2, Pointer pointer1);
}
