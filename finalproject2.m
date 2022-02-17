%% strength duration curve

durations = linspace(0.2,5,100);
amplitudes = [];

for i = 1:length(durations)
    % reset all the flags, counters
    flag = 0;
    bottom = 0;
    top = 1;
    dur = durations(1, i);
    Iamp = (bottom+top)/2;

    while flag ~=1
        newVoltage = max(voltage(dur, Iamp)) 
   
        if newVoltage > 0 % AP fired
            amplitudes = [amplitudes, Iamp];
              
        else % AP not fired 
            % TODO: add percent error here
            
            %resetting counters because amp needs to be larger
            bottom = bottom + (top-bottom)/2;
            Iamp = (bottom+top)/2  
        end 
    end 
end 

% plots the durations and amplititudes 
figure;plot(durations,amplitudes,'ko')

%% functions
function V=voltage(duration, amplitude)
    % Set constants
    Cm=0.01; % Membrane Capcitance
    ENa=100; % mv Na reversal potential
    EK=-70; % mv K reversal potential
    El=-55; % mv Leakage reversal potential
    gbarNa=1; % Na conductance
    gbarK=0.5; % K conductance
    gbarl=0.003; % Leakage conductance

    % Initialize variables
    V(1)=-60; % Initial Membrane voltage
    m(1)=am(V(1))/(am(V(1))+bm(V(1))); % Initial m-value
    n(1)=an(V(1))/(an(V(1))+bn(V(1))); % Initial n-value
    h(1)=ah(V(1))/(ah(V(1))+bh(V(1))); % Initial h-value
    gNa(1)=gbarNa*m(1)^3*h(1);
    gK(1)=gbarK*n(1)^4;
    gl(1)=gbarl;

    % Set simulation length
    dt=0.01; % Time Step ms
    t=0:dt:25; % Time Array ms

    % Set external current stimulus
    I = zeros([1,length(t)]);

    Iamp=amplitude; % amplitude of external current applied
    dur=duration; % duration of external current applied (ms)
    start=1; % when the external stimulus is applied
    I((t>start)&(t<(start+dur))) = Iamp;

    % Euler method

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
end
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
