clc
clear all
close all
G_sc=1353;
betta=input('Enter surface tilt angle from horizontal ');
gamma=input('Enter surface azimuth angle ');
phi=input('Enter the latitude ');
zetha=input('Enter the longitude ');
dn=input('Enter day number ');
for n=1:1:365
delta(n)=23.45*(sind(360*(n/365)));
ws=(1/15)*acosd(-tand(delta(n))*tand(phi));
ss(n)=12+ws;
sr(n)=12-ws;
ss1=datestr(hours(ss(n)),'HH:MM:SS');
sr1=datestr(hours(sr(n)),'HH:MM:SS');
dl(n)=2*ws;
t=sr(n);
m=1;
while t<ss(n)
t=t+0.1;
w=15*(t-12);
alpha_s(n,m)=asind(sind(delta(n))*sind(phi)+cosd(delta(n))*cosd(phi)*cosd(w));
gamma_s(n,m)=asind(cosd(delta(n))*sind(w)/cosd(alpha_s(n,m)));
gamma_sy=abs(gamma_s(n,m)-gamma);
tetha(n,m)=acosd(sind(delta(n))*sind(phi)*cosd(betta)-sind(delta(n))*cosd(phi)*sind(betta)*cosd(gamma)+cosd(delta(n))*cosd(phi) ...
    *cosd(betta)*cosd(w)+cosd(delta(n))*sind(phi)*sind(betta)*cosd(gamma)*cosd(gamma)*cosd(w)+cosd(delta(n))*sind(betta) ...
    *sind(gamma)*sind(w));
tetha_z(n,m)=90-alpha_s(n,m);
G_oh(n,m)=G_sc*(1+0.033*cosd(360*(n+81)/365))*cosd(tetha_z(n,m));
H_oh(n,m)=(24*3600/pi)*G_sc*(1+0.033*cosd(360*(n+81)/365))*(cosd(delta(n))*cos(phi)*sind(ws)+(2*pi*ws/365)*sin(delta(n))*sin(phi));
t1(n,m)=t;
m=m+1;
end
end
Ir=G_oh(dn,:);
Ir=Ir';
Ir(Ir==0)=[];
Ti=t1(dn,:);
Ti=Ti';
Ti(Ti==0)=[];
Ti1=datestr(hours(Ti),'HH:MM:SS');
alpha_s1=alpha_s(dn,:);
alpha_s1=alpha_s1';
alpha_s1(alpha_s1==0)=[];
gamma_s1=gamma_s(dn,:);
gamma_s1=gamma_s1';
gamma_s1(gamma_s1==0)=[];
tetha1=tetha(dn,:);
tetha1=tetha1';
tetha1(tetha1==0)=[];
tetha_z1=tetha_z(dn,:);
tetha_z1=tetha_z1';
tetha_z1(tetha_z1==0)=[];
C=table(Ti1,Ir,alpha_s1,gamma_s1,tetha_z1,tetha1,'VariableNames',{'Time','Irradiance (W/m2)','Solar Altitude Angle','Solar Azimuth Angle','Solar Zenith Angle','Incidence Angle'});
disp(C)
de=delta(dn);
day_le=dl(dn);
sunrise=sr(dn);
% sunrise=datestr(hours(sunrise),'HH:MM:SS');
sunset=ss(dn);
% sunset=datestr(hours(sunset),'HH:MM:SS');
max_ir=max(Ir);
max_in=max(tetha1);
max_al=max(alpha_s1);
Results=[de;day_le;sunrise;sunset;max_ir;max_in;max_al];
C1={'Declination Angle';'Day Lenth';'Sunrise';'Sunset';'Maximum Irradiance';'Maximum Incidence Angle';'Maximum Solar Altitude Angle'};
C2=table(Results,'RowNames',C1);
disp(C2)