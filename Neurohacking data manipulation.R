#read data 

mridir <- "C:/Neurohacking/Neurohacking_data/kirby21/visit_1/113"
T1 <- readNIfTI(file.path(mridir,"/113-01-MPRAGE.nii"),reorient=FALSE)
orthographic(T1)

#read in and view binary mask for the image

mask <- readNIfTI(file.path(mridir,"/113-01-MPRAGE_mask.nii"),reorient=FALSE)
orthographic(mask)
#must be in the same dimensions
#areas not in the mask are now gone
#got rid of bone area and things that arent actually brain
masked.T1 <- T1*mask
orthographic(masked.T1)

#take one image away from another 
#also can do multiply, modulus, exponential, log transform etc

T1.follow <- readNIfTI(file.path(mridir,'/113-02-MPRAGE.nii'),reorient=FALSE)
subtract.T1 <- T1.follow - T1
min(subtract.T1)
max(subtract.T1)
orthographic(subtract.T1)

im_hist<-hist(T1,plot=FALSE)
par(mar=c(5,4,4,4) + 0.3)
col1=rgb(0,0,1,1/2)
plot(im_hist$mids,im_hist$count,log="y",type="h",lwd=10,lend=2,col=col1,xlab="intentsity values",ylab="count (log)")
#linear transfomration
par(new=TRUE)
curve(x*1,axes=FALSE,xlab="",ylab="",col=2,lwd=3)
axis(side=4,at=pretty(range(im_hist$mids))/max(T1),labels=pretty(range(im_hist$mids)))
mtext("original intensity",side=4,line=2)
#transform them by differential, define a linear spline, break line in to knots
lin.sp<-function(x,knots,slope)
  {knots<-c(min(x),knots,max(x))
   slopeS<-slope[1]
  for(j in 2:length(slope)){slopeS<-c(slopeS,slope[j]-sum(slopeS))}
   
  rvals<-numeric(length(x))
  for(i in 2:length(knots))
    {rvals<-ifelse(x>=knots[i-1],slopeS[i-1]*(x-knots[i-1])+rvals,rvals)}
  return(rvals)}
knots.vals<-c(.3,.6)
slp.vals<-c(1,.5,.25)
  

#can also smooth an image by reducing  amount of noise but if too aggressive you may lose too much information