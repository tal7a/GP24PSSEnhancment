A_one=sym(zeros(12,12));
syms Xd w0 Xq Xad Xaq X1d Xfd Xe X1q K1sh K2sh ka T1 T2 T3 T4 Ta R r Iq0 I1q0 I1d0 V VI Delta eq0 Id0 Ifd0 ed0 rfd r1d r1q Ka Tf e0 Kf Te Ke W0 J K H Ks K1 K2;


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
A_one(12,12) = -1/T2