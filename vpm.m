clear all; close all; clc;
%% sim params
L = 2*pi; % meters
resolution = 16; % initialize particles as 64*64 square grid
viscosity = 1E-2; % kinematic viscosity m^2/s
timeStep = 1E-1;
nt = 100;

%% init vars
N = resolution^2;
domainX = [0 L];
domainY = [0 L];
particleRad = L/resolution * 2;
particleVol = pi*particleRad^2;

particleMat = zeros(5, N); % [x; y; u; v; omega]

%% initial condition

for i = 0:N-1
    x = mod(i, resolution) * (L/resolution) + (L/resolution)*0.5;
    y = (i-mod(i,resolution))/resolution * (L/resolution) + (L/resolution)*0.5;
    u = cos(x)*sin(y);
    v = -sin(x)*cos(y);
    omega = -2*cos(x)*cos(y);
    mysteryFrac = 0.1;
    particleMat(:, i+1) = [x; y; u; v; mysteryFrac*omega*particleVol];
end

%% plot
figure();
plotField(particleMat, L, 0.5);

%% calc vels;
der = calcDeriv(particleMat, L, particleRad, viscosity);

%% plot again
figure();
for i = 1:nt
    der = calcDeriv(particleMat, L, particleRad, viscosity);
    particleMat(1:2, :) = particleMat(1:2, :) + der(1:2, :)*timeStep;
    particleMat(3:4, :) = der(1:2, :);
    particleMat(5, :) = particleMat(5, :) + der(3, :)*timeStep;
    particleMat(1, particleMat(1, :) < 0) = particleMat(1, particleMat(1, :) < 0) + L;
    particleMat(2, particleMat(2, :) < 0) = particleMat(2, particleMat(2, :) < 0) + L;
    particleMat(1, particleMat(1, :) > L) = particleMat(1, particleMat(1, :) > L) - L;
    particleMat(2, particleMat(2, :) > L) = particleMat(2, particleMat(2, :) > L) - L;
    plotField(particleMat, L, 0.5);
    drawnow;
    disp(i);
end

    