clear all ; clc ; close all

%% Estimacion de funcion de transferencia
GananciaPlanta=5.407;
Polos=roots([1 6.822 9.527 40.41 0.2491 0.03648]);  %Remplace aqui con sus valores
Zeros=roots([1 0.07784/GananciaPlanta 0.004996/GananciaPlanta]);

Tf_zpk=zpk(Zeros,Polos,GananciaPlanta);

%% Estimacion de punto de interes

syms z 

overshoot=75;  % Overshoot deseado
settingTime=9; % Setting time deseado

Eq1= 100*exp(-pi*z/sqrt(1-z^2)) ;

dampingRatio=double(solve(Eq1==overshoot,z));

if (dampingRatio(1)>=0)
    damping=dampingRatio(1);
    
end

if (dampingRatio(2)>=0 && dampingRatio(1)<0)
    damping=dampingRatio(2);
    
end
wn=4/(damping*settingTime);

Punto= -damping*wn + wn*sqrt(1-damping^2)*1i;

%% Estimacion PD

AngPol=zeros(1,length(Polos));
AngZeros=zeros(1,length(Zeros));
for i= 1:length(Polos)
    AngPol(i)=angle(Punto-Polos(i))*180/pi;
end
for i= 1:length(Zeros)
    AngZeros(i)=angle(Punto-Zeros(i))*180/pi;
end
SumPolos=sum(AngPol);
SumZeros=sum(AngZeros);


ZcontroladorPD=-180+SumPolos-SumZeros;
DistZcon=imag(Punto)/tan(ZcontroladorPD*pi/180);
PosZconPD=real(Punto)-DistZcon;

%Condicion de magnitud

syms Kd

num=GananciaPlanta;
den=1;

for i= 1:length(Zeros)
    num=num*(Punto-Zeros(i));
end
for i= 1:length(Polos)
    den=den*(Punto-Polos(i));
end


num=num*(Punto-PosZconPD)*Kd; % Modifiquese segun su planta


Eq2=num/den;

KPD=double(solve(abs(Eq2)==1,Kd));

%% Estimacion PID



P0=angle(Punto-0)*180/pi;
ZcontroladorPID=(-180+P0+SumPolos-SumZeros)/2;
DistZcon=imag(Punto)/tan(ZcontroladorPID*pi/180);
PosZconPID=real(Punto)-DistZcon;

%Condicion de magnitud

syms K

num=GananciaPlanta;
den=1;

for i= 1:length(Zeros)
    num=num*(Punto-Zeros(i));
end
for i= 1:length(Polos)
    den=den*(Punto-Polos(i));
end

num=num*((Punto-PosZconPID)^2)*K;%Modifiquese segun su planta
den=den*(Punto);%---------------------Modifiquese segun su planta

Eq3=num/den;

KPID=double(solve(abs(Eq3)==1,K));

%% Estimacion PI

P0=angle(Punto-0)*180/pi;
ZcontroladorPI=-180+P0+SumPolos-SumZeros;
DistZcon=imag(Punto)/tan(ZcontroladorPI*pi/180);
PosZconPI=real(Punto)-DistZcon;

%Condicion de magnitud

syms KI

num=GananciaPlanta;
den=1;

for i= 1:length(Zeros)
    num=num*(Punto-Zeros(i));
end
for i= 1:length(Polos)
    den=den*(Punto-Polos(i));
end

num=num*((Punto-PosZconPI)^1)*KI;%Modifiquese segun su planta
den=den*(Punto);%----------------------Modifiquese segun su planta

Eq4=num/den;

KPI=double(solve(abs(Eq4)==1,KI));
