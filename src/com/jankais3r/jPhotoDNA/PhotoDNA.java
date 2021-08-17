package com.jankais3r.jPhotoDNA;

import com.sun.jna.Native;
import com.sun.jna.Pointer;
import org.opencv.core.Mat;

public class PhotoDNA {
    private extendPhotoDNA photoDNA;
    private Pointer functPointer;

    public PhotoDNA(String photoDnaLib) {
        this.photoDNA = Native.load(photoDnaLib, extendPhotoDNA.class);
        this.functPointer = this.photoDNA.RobustHashInitBuffer(16777216);
    }

    public byte[] calculateHash(Mat matImage) {
        byte[] byteImage = new byte[matImage.width() * matImage.height() * matImage.channels()];
        matImage.get(0, 0, byteImage);

        int ImageWidth = matImage.width();
        int ImageHeight = matImage.height();
        byte[] hashValue = new byte[144];
        if (ImageWidth * ImageHeight <= 16777216) {
            int pitch = 0;
            this.photoDNA.ComputeRobustHash(byteImage, ImageWidth, ImageHeight, pitch, hashValue, this.functPointer);
        } else {
            System.out.println("Does not support images over 16MP (4096x4096).");
            System.exit(0);
        }
        return hashValue;
    }

    public void releaseBuffer() {
        this.photoDNA.RobustHashReleaseBuffer(this.functPointer);
    }
}
