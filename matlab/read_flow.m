clear all
cd ../results
vf=importdata('output_v.dat');
vf=vf';
x=[0:(2/(1000-1)):2];
y=[0:(2/(1000-1)):2];
contourf(x,y,vf)

cd ../matlab