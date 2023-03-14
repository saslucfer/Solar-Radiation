clc;
clear all;
close all;
G_sc=1353;
DS=0;
% phi=input('Please Enter the Local latitude "phi" ');
phi=35.6892;
% LL=input('Please Enter the Local Longitude "LL" ');
LL=51.42;
% SL=input('Please Enter the Standard Longitude "SL" ');
SL=52.5;
% gamma=input('Please Enter the zenith angle "landa" ');
gamma=0;
% beta=input('Please Enter beta "landa" ');
beta=30;

K_T=[0.55,0.58,0.64,0.64,0.65,0.65,0.61,0.55,0.5,0.51,0.53,0.53];

%%
for n=1:365;
    delta(n)=(23.45*sind(360*n/365));
    omega_s(n)=(1/15)*acosd(-tand(delta(n))*tand(phi));
    sunrise(n)=12-omega_s(n);
    sunset(n)=12+omega_s(n);
    T_d(n)=2*omega_s(n);
    B(n)=n*(360/364);
    ET(n)=9.87*sind(2*B(n))-7.53*cosd(B(n))-1.5*sind(B(n));
    H_oh(n)=(24*3600/pi)*G_sc*(1+0.033*cosd((360*(n+1))/365))*(cosd(gamma)*cosd(phi)*cosd(omega_s(n))+(2*pi*omega_s(n))*sind(gamma)*sind(phi));
    for h=[1:1:24];
        min(h)=h*60;
        t(n,h)=(min(h)+ET(n)-4*(SL-LL))/60;
        omega(n,h)=(t(n,h)-12)*15;
        alpha_s(n,h)=asind((sind(delta(n))*sind(phi))+(cosd(delta(n))*cosd(phi)*cosd(omega(n,h))));
        teta_z(n,h)=90-alpha_s(n,h);
        gamma_s(n,h)=asind(cosd(delta(n))*sind(omega(n,h))/cosd(alpha_s(n,h)));
        teta(n,h)=acosd(sind(delta(n))*sind(phi)*cosd(beta)-sind(delta(n))*cosd(phi)*sind(beta)*cosd(gamma)+cosd(delta(n))*cosd(phi)*cosd(beta)*cosd(omega(n,h))+cosd(delta(n))*sind(phi)*sind(beta)*cosd(gamma)*cosd(omega(n,h))+cosd(delta(n))*sind(beta)*sind(gamma)*sind(omega(n,h)));
        G_oh(n,h)=G_sc*(1+0.033*cosd((360*(n+81))/365))*(cosd(delta(n))*cosd(phi)*cosd(omega(n,h))+sind(delta(n))*sind(phi));
    end
end

  sunrise1=datestr(hours(sunrise),'HH:MM:SS');
  sunset1=datestr(hours(sunset),'HH:MM:SS');
  T_d1=datestr(hours(T_d),'HH:MM:SS');

%%
figure
x=[1:1:365];
plot(x,delta,'-ok','Markerfacecolor','r')
xlabel('day number')
ylabel('Declination angle')
title('declination angle curve')

figure
plot(x,T_d,'-ok','Markerfacecolor','b')
xlabel('day number')
ylabel('day lenght')
title('day lenghts in a years')

figure
plot(x,sunrise,'-ok','Markerfacecolor','G')
xlabel('day number')
ylabel('sunrise')
title('sunrises in a years')

figure
plot(x,sunset,'-ok','Markerfacecolor','Y')
xlabel('day number')
ylabel('sunset')
title('sunsets in a years')

%%
figure
h=[1:1:24];

alpha_1=alpha_s(1,:);
plot(h,alpha_1);
hold on

alpha_32=alpha_s(32,:);
plot(h,alpha_32);
hold on

alpha_63=alpha_s(63,:);
plot(h,alpha_63);
hold on

alpha_94=alpha_s(94,:);
plot(h,alpha_94);
hold on

alpha_125=alpha_s(125,:);
plot(h,alpha_125);
hold on

alpha_156=alpha_s(156,:);
plot(h,alpha_156);
hold on

alpha_187=alpha_s(187,:);
plot(h,alpha_187);
hold on

alpha_217=alpha_s(217,:);
plot(h,alpha_217);
hold on

alpha_247=alpha_s(247,:);
plot(h,alpha_247);
hold on

alpha_277=alpha_s(277,:);
plot(h,alpha_277);
hold on

alpha_307=alpha_s(307,:);
plot(h,alpha_307);
hold on

alpha_337=alpha_s(337,:);
plot(h,alpha_337);
hold on

alpha_365=alpha_s(365,:);
plot(h,alpha_365);
hold on

grid on
xlabel('time (hour)')
ylabel('declination angle (degree)')
title('Yearly variation of solar declination')
legend('1 farvardin','1 ordibehesht','1 khordad','1 tir','1 mordad','1 shahrivar','1 mehr','1 aban','1 azar','1 dey','1 bahman','1 esfand')
axis([0,24,0,80])

%%
figure
h=[1:1:24];

G_oh_1=G_oh(1,:);
K_T_1=0.55;
E_1=G_oh_1*K_T_1;
plot(h,G_oh_1);
hold on

G_oh_32=G_oh(32,:);
K_T_32=0.58;
E_32=G_oh_32*K_T_32;
plot(h,G_oh_32);
hold on

G_oh_63=G_oh(63,:);
K_T_63=0.64;
E_63=G_oh_63*K_T_63;
plot(h,G_oh_63);
hold on

G_oh_94=G_oh(94,:);
K_T_94=0.64;
E_94=G_oh_94*K_T_94;
plot(h,G_oh_94);
hold on

G_oh_125=G_oh(125,:);
K_T_125=0.65;
E_125=G_oh_125*K_T_125;
plot(h,G_oh_125);
hold on

G_oh_156=G_oh(156,:);
K_T_156=0.65;
E_156=G_oh_156*K_T_156;
plot(h,G_oh_156);
hold on

G_oh_187=G_oh(187,:);
K_T_187=0.61;
E_187=G_oh_187*K_T_187;
plot(h,G_oh_187);
hold on

G_oh_217=G_oh(217,:);
K_T_217=0.55;
E_217=G_oh_217*K_T_217;
plot(h,G_oh_217);
hold on

G_oh_247=G_oh(247,:);
K_T_247=0.5;
E_247=G_oh_247*K_T_247;
plot(h,G_oh_247);
hold on

G_oh_277=G_oh(277,:);
K_T_277=0.5;
E_277=G_oh_277*K_T_277;
plot(h,G_oh_277);
hold on

G_oh_307=G_oh(307,:);
K_T_307=0.51;
E_307=G_oh_307*K_T_307;
plot(h,G_oh_307);
hold on

G_oh_337=G_oh(337,:);
K_T_337=0.53;
E_337=G_oh_337*K_T_337;
plot(h,G_oh_337);
hold on

G_oh_365=G_oh(365,:);
K_T_365=0.53;
E_365=G_oh_365*K_T_365;
plot(h,G_oh_365);
hold on

grid on
xlabel('time (hour)')
ylabel('irradience (W/m2)')
title('Yearly variation of solar irradience')
legend('1 farvardin','1 ordibehesht','1 khordad','1 tir','1 mordad','1 shahrivar','1 mehr','1 aban','1 azar','1 dey','1 bahman','1 esfand')
axis([0,24,0,1300])

%%
figure
h=[1:1:24];

plot(h,E_1);
hold on
plot(h,E_32);
hold on
plot(h,E_63);
hold on
plot(h,E_94);
hold on
plot(h,E_125);
hold on
plot(h,E_156);
hold on
plot(h,E_187);
hold on
plot(h,E_217);
hold on
plot(h,E_247);
hold on
plot(h,E_277);
hold on
plot(h,E_307);
hold on
plot(h,E_337);
hold on
plot(h,E_365);
hold on
grid on
xlabel('time (hour)')
ylabel('irradience (W/m2)')
title('Yearly variation of solar irradience on earth')
legend('1 farvardin','1 ordibehesht','1 khordad','1 tir','1 mordad','1 shahrivar','1 mehr','1 aban','1 azar','1 dey','1 bahman','1 esfand')
axis([0,24,0,850])

%%
H_oh_15th=H_oh(:,26);
disp('H_oh in april 15th =');
disp(H_oh_15th);


