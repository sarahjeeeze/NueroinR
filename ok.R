mridir <- "C:/Neurohacking/Neurohacking_data/BRAINIX/NIfTI"
volume <- readNIfTI(file.path(mridir,"/FLAIR.nii"),reorient=FALSE)
volume <- cal_img(volume)
image(volume,z=12,plot.type="single")

#ventricles in the middle differrent contrast

volumeT2 <- readNIfTI(file.path(mridir,"/T2.nii"),reorient=FALSE)
volumeT2 <- cal_img(volumeT2)
image(volumeT2,z=12,plot.type="single")

#hyperintensities around ventricles in ppl with ms
#think about intensities within arrays
#data can be 3 dimensional - every locatino is a 3d voxel.
