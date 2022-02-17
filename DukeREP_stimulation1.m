%% Hodkin Huxley model: neuron's response to external current stimulus
% Uses forward Euler method to solve differential equation
clc; clear;

%% Set constants
Cm=0.01; % Membrane Capcitance
ENa=55; % mv Na reversal potential
EK=-72; % mv K reversal potential
El=-49; % mv Leakage reversal potential
gbarNa=1.2; % Na conductance
gbarK=0.36; % K conductance
gbarl=0.003; % Leakage conductance

%% Initialize variables
V(1)=-60; % Initial Membrane voltage
m(1)=am(V(1))/(am(V(1))+bm(V(1))); % Initial m-value
n(1)=an(V(1))/(an(V(1))+bn(V(1))); % Initial n-value
h(1)=ah(V(1))/(ah(V(1))+bh(V(1))); % Initial h-value
gNa(1)=gbarNa*m(1)^3*h(1);
gK(1)=gbarK*n(1)^4;
gl(1)=gbarl;

%% Set simulation length
dt=0.01; % Time Step ms
t=0:dt:25; % Time Array ms

%% Set external current stimulus
I = zeros([1,length(t)]);

Iamp=0.5; % amplitude of external current applied
dur=1; % duration of external current applied (ms)
start=1; % when the external stimulus is applied
I((t>start)&(t<(start+dur))) = Iamp;

% add code for second pulse here

%% Euler method

for i=1:length(t)-1
    
    %Euler method to find the next m/n/h value
    m(i+1)=m(i)+dt*((am(V(i))*(1-m(i)))-(bm(V(i))*m(i)));
    n(i+1)=n(i)+dt*((an(V(i))*(1-n(i)))-(bn(V(i))*n(i)));
    h(i+1)=h(i)+dt*((ah(V(i))*(1-h(i)))-(bh(V(i))*h(i)));
    gNa(i+1)=gbarNa*m(i)^3*h(i);
    gK(i+1)=gbarK*n(i)^4;
    gl(i+1)=gbarl;
    
    INa=gNa(i+1)*(V(i)-ENa);
    IK=gK(i+1)*(V(i)-EK);
    Il=gl(i+1)*(V(i)-El);
    
    %Euler method to find the next voltage value
    V(i+1)=V(i)+(dt)*((1/Cm)*(I(i)-(INa+IK+Il)));
    
end

%% Plot simulation

% plot current stimulus
figure(1);subplot(3,1,1);plot(t,I)
ylim([-0.1 Iamp+0.1])
xlabel('Time');ylabel('Current');title('External current stimulus')
% plot ion conductances
figure(1);subplot(3,1,2);plot(t,gNa,t,gK)
xlabel('Time');ylabel('Conductance');title('Ion conductances')
legend('Sodium (Na+)','Potassium (K+)')
% plot membrane voltage
figure(1);subplot(3,1,3);plot(t,V)
xlabel('Time');ylabel('Voltage');title('Transmembrane potential')

%% functions

function a=am(v) % Alpha for Variable m
a=0.1*(v+35)/(1-exp(-(v+35)/10));
end
function b=bm(v) % Beta for variable m
b=4.0*exp(-0.0556*(v+60));
end
function a=an(v)% Alpha for variable n
a=0.01*(v+50)/(1-exp(-(v+50)/10));
end
function b=bn(v) % Beta for variable n
b=0.125*exp(-(v+60)/80);
end
function a=ah(v) % Alpha value for variable h
a=0.07*exp(-0.05*(v+60));
end
function b=bh(v) % Beta value for variable h
b=1/(1+exp(-(0.1)*(v+30)));
end