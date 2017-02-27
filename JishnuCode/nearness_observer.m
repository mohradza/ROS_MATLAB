clear all;close all;clc;
t=[0:0.03:12]';
g=zeros(8,1);
for i=1:360
    g(i)=0.5*pi/180+1*(i-1)*pi/180;
end
u=1*ones(length(t),1);%forward velocity in m/s, along forward body axis 
v=zeros(length(t),1);%lateral velocity in m/s, along lateral (left) body axis
psi=zeros(length(t),1);%yaw angle in rad, +ve CCW
psidot=zeros(length(t),1);%yaw rate in rad, +ve CCW
y=zeros(length(t),1);% lateral offset in m, along lateral (left) inertial axis
a=1.5;%m; corridor half width
ut=zeros(length(g),length(t));%tangential component of linear velocity
ur=zeros(length(g),length(t));%radial component of linear velocity
mu=zeros(length(g),length(t));%true nearness
Qdotm=zeros(length(g),length(t));%measured optic flow
Qdote=zeros(length(g),length(t));%estimated optic flow
mue=1*ones(length(g),length(t));%estimated nearness 
mudotm=zeros(length(g),length(t));
mudote=zeros(length(g),length(t));
rho=20;%observer gain
for i=1:length(t)
    for j=1:length(g)
        ut(j,i)=u(i)*sin(g(j))-v(i)*cos(g(j));
        ur(j,i)=-(u(i)*cos(g(j))+v(i)*cos(g(j)));
       % if (g(j)+psi(i)<=pi)
        %    mu(j,i)=sin(g(j)+psi(i))/(a-y(i));
        e%lse
          %  mu(j,i)=-sin(g(j)+psi(i))/(a+y(i));
    end%
        Qdotm(j,i)=-psidot(i)+mu(j,i)*ut(j,i);
        %mudote(j,i)=ur(j,i)*mu(j,i)^2;
    end
end
%Observer implementation
for i=1:length(t)-1
    for j=1:length(g)
        Qdote(j,i)=-psidot(i)+mue(j,i)*ut(j,i);%notice the difference in the expressions for measured and estimated optic flow: Qdotm and Qdote
        mudot=ur(j,i)*mue(j,i)^2-rho*ut(j,i)*(Qdote(j,i)-Qdotm(j,i));%ur(j,i)*mue(j,i)^2
        mue(j,i+1)=mue(j,i)+mudot*(t(i+1)-t(i));
    end
end

% figure(1);
% for j=1:length(g)
%     plot(g,Qdotm(:,1));hold on;
%     break;
% end

for j=1:length(g)
    figure(1);%steady state plot of the estimated nearness and true nearness
    plot(g*180/pi,mu(:,length(t)-1)');hold on;
    plot(g*180/pi,mue(:,length(t)-1)','r--');grid on;
    break;
end
for i=1:length(t)
    figure(2);%time history of estimated nearness and true nearness at g=45 deg location
    plot(t,mu(45,:));hold on;
    plot(t,mue(45,:),'r--');grid on;   
    break;
end
for j=1:length(g)
    figure(3);%steady state plot of estimated nearness rate
%     plot(g*180/pi,mudote(:,1)','b');grid on;hold on;
    plot(g*180/pi,mudote(:,length(t)-1)','r--');grid on;
    break;
end