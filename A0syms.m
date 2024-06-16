A_zero=sym(zeros(12,12));
syms Xd w0 Xq Xad Xaq X1d Xfd Xe X1q k1sh k2sh ka K1 K2  Kpss Ksps T1 T2 T3 T4 Ta R r Iq0 V VI Delta eq0 Id0 Ifd0 ed0 rfd r1d r1q Ka Tf e0 Kf Te Ke W0 J K H;

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
A_zero(8,1) = ((Ka*K1*Xe)/(Ta*W0));
A_zero(8,2) = ((Ka*K2*Xe)/(Ta*W0));
A_zero(8,9) = 1/W0;

% X2
A_zero(9,8) = 1/W0;

% Vfd
A_zero(10,6) = H;

% K_PSS
A_zero(11,11) = 1/W0;
A_zero(11,6) = (-T3*Kpss)/(T4*W0);

%Mechanical Equations


% K_SPS
A_zero(12,12) = 1/W0;
A_zero(12,6) = (-Ksps*T1)/(W0*T2)
