clear all
cd ../results
uf=importdata('output_u.dat');
uf=uf';
x=[0:(2/(1000-1)):2];
y=[0:(2/(1000-1)):2];
figure(1)
contourf(x,y,uf)

vf=importdata('output_v.dat');
vf=vf';
x=[0:(2/(1000-1)):2];
y=[0:(2/(1000-1)):2];
figure(2)
contourf(x,y,vf)

cd ../matlab