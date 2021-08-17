package com.jankais3r.jPhotoDNA;

import org.opencv.core.Mat;
import org.opencv.core.Core;
import org.opencv.imgcodecs.Imgcodecs;
import java.io.File;

public class Main {
    public static void main(String[] args) {
        int argCount = args.length;
        if(argCount == 2) {
            String libPath = args[0];
            File libFile = new File(libPath);
            if (libFile.isFile() && (libPath.endsWith("PhotoDNAx64.dll"))) {
                String imagePath = args[1];
                File imageFile = new File(imagePath);
                if (imageFile.isFile()) {
                    System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
                    Imgcodecs imageCodecs = new Imgcodecs();
                    Mat matImage = imageCodecs.imread(imagePath);

                    PhotoDNA engine = new PhotoDNA(libPath);
                    byte[] hashBytes = engine.calculateHash(matImage);

                    String hashString = "";
                    for (int j = 0; j < 144; j++) {
                        hashString = hashString + (hashBytes[j] & 0xFF);
                        if (j + 1 != hashBytes.length)
                            hashString = hashString + ",";
                    }

                    System.out.println(imagePath + "|" + hashString);
                    engine.releaseBuffer();
                } else {
                    System.out.println("Image file does not exist.");
                    System.exit(0);
                }
            } else {
                System.out.println("Invalid path to PhotoDNAx64.dll.");
                System.out.println("Run as: java -jar jPhotoDNA.jar PhotoDNAx64.dll image.jpg");
                System.exit(0);
            }
        } else {
            System.out.println("Invalid argument count.");
            System.out.println("Run as: java -jar jPhotoDNA.jar PhotoDNAx64.dll image.jpg");
            System.exit(0);
        }
    }
}
