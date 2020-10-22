%% flow field

x=[0:(2/(1000-1)):2];
y=[0:(2/(1000-1)):2];
u_0=10; %10 m/s
D=0.02; %m
beta=0.114;
alpha=0.057;
y_0=1.5;

nx=length(x);
ny=length(y);

x_0=6.2*D
for i=1:nx
    u_c(i)=u_0*6.2*((x(i)+x_0)/D).^(-1);
    b(i)=beta*x(i);
end
plot(x,u_c)

u_r=zeros(nx,ny);
v_r=zeros(nx,ny);
rb=zeros(nx,ny);
for i=1:nx
    for j=1:ny
        rb(i,j)=(y(j)-y_0)/b(i);
        if (i==1) 
            rb(i,j)=0;
        end
            u_r(i,j)=u_c(i)*exp(-rb(i,j)^2);
            v_r(i,j)=abs(alpha*u_c(i)*(1-exp(-rb(i,j)^2)-(beta/alpha)*(rb(i,j)^2)*exp(-rb(i,j)^2))/rb(i,j));
    end
end

for i=1:nx
    for j=1:ny
        if (abs(y(j)-y_0) > 0.16*x(i))
            u_r(i,j)=0.;
            v_r(i,j)=0.;
        end
    end
end

figure(1)
contourf(x,y,u_r')

figure(2)
contourf(x,y,v_r')

        