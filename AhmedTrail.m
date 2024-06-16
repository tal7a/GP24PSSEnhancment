clear
clc
%variables
r = 0.0045;
Xe = 0.4;
R =0.0084;
Xd = 1.65;
Xq = 1.65;
XL = 0.14;
Xad = 1.51;
Xaq = 1.45;
Xfd = 1.6286;
X1d = 1.642;
X1q = 1.861;
r1d = 0.016;
r1q = 0.00898;
J =1.7566;
rfd = 0.5;


%exciTation sysTem
Ka=200*rfd/Xad;
Kf=0.05*Xad/rfd;
Ke=1;
Ta=0.34;
Te=0.001;
Tf=1;

%initial conditions
PL=0.9;
PF=0.85;
VI=1.0;

%PSS
T2=0.001;
Kpss=-10*0;
T1=0.00;
%SPS
T4=0.001;
Ksps=-3*0;
T3=0.00;

%load flow
I=(PL/(VI*PF)*cos(-acos(PF)))+(PL/(VI*PF)*sin(-acos(PF)))*1i;
I0=abs(I);
fay=-angle(I);
V=VI+I*R+I*(Xe*1i);
e0=abs(V);
Deltat=angle(V);
Eq=V+I*r+I*(Xd*1i);
Eq0=abs(Eq);
Delta=angle(Eq);
Id0=I0*sin(Delta+fay);
Iq0=I0*cos(Delta+fay);
ed0=e0*sin(Delta-Deltat);
eq0=e0*cos(Delta-Deltat);



%unknown Variables
Ifd0=Eq0/Xad;
I1d0=0;
I1q0=0;
W0=377.0;
H=J;
K1=ed0/e0;
K2=eq0/e0;
Ks = 1;

A_zero=zeros(12,12);
%Electrical Equations
% Id
A_zero(1,1) = ((Xe+Xd)/W0); 
A_zero(1,3)=(-Xad/W0); 
A_zero(1,4)=(-Xad/W0);

% Iq
A_zero(2,2) = ((Xe+Xq)/W0); 
A_zero(2,5)=(-Xaq/W0);

% Ifd
A_zero(3,1) = (Xad/W0); 
A_zero(3,3)=(-Xfd/W0); 
A_zero(3,4)=(-Xad/W0);  

% I1d
A_zero(4,1) = (Xad/W0); 
A_zero(4,3)=(-Xad/W0); 
A_zero(4,4)= (-X1d/W0);

% I1q
A_zero(5,2) = (-Xaq/W0);
A_zero(5,5)= (-X1q/W0);

% W
A_zero(6,7) = 1/W0;

% delta 
A_zero(7,10) = 1/W0;

% X1
A_zero(8,1) = ((Ka*ed0*Xe)/(Ta*e0*W0));
A_zero(8,2) = ((Ka*eq0*Xe)/(Ta*e0*W0));
A_zero(8,9) = 1/W0;

% X2
A_zero(9,8) = 1/W0;

% Vfd
A_zero(10,6) = H;

% K_PSS
A_zero(11,11) = 1/W0;
A_zero(11,6) = (-T3*Ksps)/(T4*W0);

%Mechanical Equations


% K_SPS
A_zero(12,12) = 1/W0;
A_zero(12,6) = (-Kpss*T1)/(W0*T2);


A_one=zeros(12,12);
%Electrical Equations
% Id
A_one(1,1) = (-R-r); 
A_one(1,2) = (Xe+Xq); 
A_one(1,5) = (-Xaq); 

A_one(1,6) = ((Xe+Xq)*Iq0); 
A_one(1,7) = -VI*cos(Delta); 
A_one(1,11)= eq0;
% Iq
A_one(2,1) = (-Xe-Xd); 
A_one(2,2) = (-R-r); 
A_one(2,3) = (Xad); 
A_one(2,4) = (Xad);

A_one(2,6) = (((-Xe-Xd)*Id0)+(Xad*Ifd0)); 
A_one(2,7) = VI*sin(Delta) ;
A_one(2,12)= -ed0;

% Ifd
A_one(3,3) = (rfd); 
A_one(3,10) = -1/W0; 

% I1d
A_one(4,4) = (r1d);

% I1q
A_one(5,5) = (r1q);

% W 
A_one(6,6) = (1);

% Delta
A_one(7,6) = -(Ke/Te);
A_one(7,10) = (-1/Te);

% X1

A_one(8,3) = ((-Ka*eq0*Xad)/(Ta*e0));
A_one(8,4) = ((Ka*eq0*Xad)/(Ta*e0));
A_one(8,5) = ((Ka*ed0*Xaq)/(Ta*e0));
A_one(8,7) = -Ka/(Ta);
A_one(8,9) = -1/(Ta);
A_one(8,12) = -Ka/(Ta);
%X2 

A_one(9,8) = (-1/Tf);
A_one(9,9) =-((Kf*Ke)/(Tf*Te));
A_one(9,10) = (-Kf/(Tf*Te));

% Vfd
A_one(10, 1) =  ((Xd*Iq0)-(Xq*Iq0)); 
A_one(10, 2) =  ((Xd*Id0)-(Xad*Ifd0)-(Xq*Id0)); 
A_one(10, 3) = - (Xd*Iq0); 
A_one(10, 4) = - (Xd*Iq0);  
A_one(10, 5) =  (Xad*Id0);


% K_PSS
A_one(11,6) = (Ksps/T4);
A_one(11,11) =  (-1/T4);

% k_SPS
A_one(12,6)= Kpss/T2;
A_one(12,12) = -1/T2;

B1 = zeros(12,2);
B1(6,1)=(W0/J);
B1(9,2)=(Ka/Ta);
A =A_zero\A_one;
B = A_zero\B1;
Eigen_A = eig(A);
Eigen_A
cf=zeros(1,12);
cf(1,7)=1.0;
df=zeros(1,2);
t1cf=zeros(1,12);
t1=0:0.000005:5;
u1tp=zeros(length(t1),1);
u2tp=zeros(length(t1),1);
for ih=200000:300000
    u1tp(ih)=0.0001;
    u2tp(ih)=0.0;
end

u1=[u1tp u2tp];
[y1,x1]=lsim(A,B,cf,df,u1,t1);
xic=x1(length(t1),:);

y=[y1];
x=[x1];
t=[t1];
subplot(6,2,1),plot(t,x(:,1));grid;
xlabel('Time in Seconds');
ylabel('\DeltaId, p.u');
ylim([-.5 0.5]);
subplot(6,2,2),plot(t,x(:,2));grid;
xlabel('Time in Seconds');
ylabel('\DeltaIq, p.u');
ylim([-.2 0.2]);
subplot(6,2,3),plot(t,x(:,10));grid;
xlabel('Time in Seconds');
ylabel('\DeltaVfd, p.u');
ylim([-.05 0.05]);
subplot(6,2,4),plot(t,x(:,3));grid;
xlabel('Time in Seconds');
ylabel('\DeltaIfd, p.u');
ylim([-.05 0.05]);
subplot(6,2,5),plot(t,x(:,4));grid;
xlabel('Time in Seconds');
ylabel('\DeltaI1d, p.u');
ylim([-.5 0.5]);
subplot(6,2,6),plot(t,x(:,5));grid;
xlabel('Time in Seconds');
ylabel('\DeltaI1q, p.u');
ylim([-.2 0.2]);
subplot(6,2,7),plot(t,x(:,6));grid;
xlabel('Time in Seconds');
ylabel('\DeltaW, p.u');
ylim([-.05 0.05]);
subplot(6,2,8),plot(t,x(:,7));grid;
xlabel('Time in Seconds');
ylabel('\Deltadelta, p.u');
ylim([-1 1]);
subplot(6,2,9),plot(t,x(:,8));grid;
xlabel('Time in Seconds');
ylabel('\DeltaX1, p.u');
subplot(6,2,10),plot(t,x(:,9));grid;
xlabel('Time in Seconds');
ylabel('\DeltaX2, p.u');
