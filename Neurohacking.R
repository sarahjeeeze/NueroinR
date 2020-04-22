
library("oro.dicom")

setwd("C:/Neurohacking/Neurohacking_data/BRAINIX/DICOM/FLAIR")
slice=readDICOM("IM-0001-0011.dcm")
class(slice)
#explore the data
names(slice)
class(slice$hdr)
class(slice$hdr[[1]])
class(slice$img)
class(slice$img[[1]])
dim(slice$img[[1]])

#view the image
d=dim(t(slice$img[[1]]))
image(1:d[1],1:d[2],t(slice$img[[1]]),col=gray(0:64/64))

#look at the actual numbers

slice$img[[1]][101:105,121:125]

#plot entire thing - make density instead of count
hist(slice$img[[1]][,],breaks=50 ,xlab="FLAIR",prob=T, col=rgb(0,1,1,1/4),main="")

#explore header info

hdr=slice$hdr[[1]]
names(hdr)
hdr$name
#lookk at resoltuion
hdr[hdr$name == "PixelSpacing", "value"]
#flip angle
hdr[hdr$name == "FlipAngle",]

#change directory

setwd("C:/Neurohacking/Neurohacking_data/BRAINIX/DICOM")
all_slices_T1=readDICOM("T1/")
dim(all_slices_T1$img[[11]])
hdr=all_slices_T1$hdr[[11]]