# jPhotoDNA
CLI Java wrapper for the PhotoDNA library 

## Setup
1)	Clone this repo
2)	Run `install.bat`
3)	Once the setup is complete, you can generate hashes using the following syntax

`jPhotoDNA.exe PhotoDNAx64.dll image.jpg`

![Setup](https://github.com/jankais3r/jPhotoDNA/raw/main/setup.png)

## PhotoDNA – what is it?
A perceptual hashing algorithm created by Hany Farid of Dartmouth College in collaboration with Microsoft Research in 2009. Designed to identify known (and derived) CSAM and used primarily by law enforcement and large internet service providers to screen user-created content. Originally an on-premise solution, Microsoft started offering it as a cloud service to selected partners in 2014. Not much is publicly known about the technology – Microsoft’s own [promo materials](https://www.microsoft.com/en-us/photodna) are extremely vague and are missing key technical details. You would be hard pressed to find even basic information such as a bit length of the resulting hashes.

Author’s [high-level description](https://farid.berkeley.edu/downloads/publications/nai18.pdf) of the algorithm:

```Although I will not go into too much detail on the algorithmic specifics, I will provide a broad overview of the robust hashing algorithm — named PhotoDNA — that we developed (see also (4,5)). Shown in Figure 2 is an overview of the basic steps involved in extracting a robust hash. First, a full-resolution color image is converted to grayscale and downsized to a lower and fixed resolution of 400 × 400 pixels. This step reduces the processing complexity in subsequent steps, makes the robust hash invariant to image resolution, and eliminates high-frequency differences that may result from compression artifacts. Next, a high-pass filter is applied to the reduced resolution image to highlight the most informative parts of the image. Then, the image is partitioned into non-overlapping quadrants from which basic statistical measurements of the underlying content are extracted and packed into a feature vector. Finally, we compute the similarity of two hashes as the Euclidean distance between two feature vectors, with distances below a specified threshold qualifying as a match. Despite its simplicity, this robust-hashing algorithm has proved to be highly accurate and computationally efficient to calculate.```


## Call for transparency
In August 2021, Apple announced their [controversial plan](https://appleprivacyletter.com/) to deploy CSAM scanning agent to more than 1 billion iOS devices with the next OS release. Their decision to do the scanning locally on people’s devices instead of on their own servers like virtually everybody else in the industry lead to renewed calls for more transparency on the topic. PhotoDNA claims to have false positive rate of 1 in 50 billion, but thanks to Microsoft’s approach to security via obscurity, it has been historically difficult to verify such claims. Since Apple’s solution is designed to run on edge devices, it [didn’t take long](https://twitter.com/KhaosT/status/1424205967122571268) until somebody put together a wrapper utilizing the official framework’s API to generate NeuralHash hashes from arbitrary images. This is an important step in verifying the algorithm’s performance, but does little to alleviate the risk of totalitarian governments around the world passing laws adapting the same scanning mechanism to look for dissident or LGBT-themed images.

In the same manner that [nhcalc](https://github.com/KhaosT/nhcalc) is a wrapper around Apple’s NeuralHash framework, jPhotoDNA is a wrapper around Microsoft’s PhotoDNA library. As previously mentioned, PhotoDNA is a closely guarded secret with only a limited number of organizations being granted access to the technology. However, several digital forensics vendors are shipping a DLL allowing an offline computation of PhotoDNA hashes for investigation purposes. jPhotoDNA uses such library shipped with Magnet AXIOM, a digital forensics platform that is freely available for download. There is a number of other forensic tools shipping the same library.


## Validation
Since there is a limited amount of information about PhotoDNA, how can we be sure that jPhotoDNA computes valid hashes? I found a single example of actual PhotoDNA hashes in [Microsoft’s 2013 article](https://news.microsoft.com/en-gb/2013/11/18/tacklingproliferatio/) on the topic.

In that article, Microsoft showcases two PhotoDNA hashes for the same image encoded in JPG and GIF formats. jPhotoDNA’s hash of the image that I grabbed from that article closely resembles the official hashes.
![Hash validation](https://github.com/jankais3r/jPhotoDNA/raw/main/validation.png)

## Legal
jPhotoDNA was created for reserach purposes. If you wish to use PhotoDNA, reach out to Microsoft and acquire a license.

PhotoDNA is a registered trademark of Microsoft Corporation.

AXIOM is a registered trademark of Magnet Forensics Inc.

