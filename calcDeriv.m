function derivOut = calcDeriv(particleMat, domainL, particleRad, viscosity)

    N = size(particleMat, 2);
    derivOut = zeros(3, N);
    particleVol = particleRad^2*pi;
    
    for i = 1:N
        thisPos = particleMat(1:2, i);
        for j = 1:N
            if i == j
                % skip this particle with itself
                continue;
            end
            
            destPos = particleMat(1:2, j);
            periodicDistVector = mod(thisPos-destPos + domainL/2, domainL) ...
                                                                - domainL/2;                                     
            periodicDist = norm(periodicDistVector);
            rho = periodicDist/particleRad;
            
            vec1 = kernelFunc(rho)*periodicDistVector/(periodicDist^2);
            vec1 = [vec1; 0];
            vec2 = [0; 0; particleMat(5,j)];
            res = cross(vec1,vec2);
            res = res(1:2);
            
            derivOut(1:2, i) = derivOut(1:2, i) - ...
                  res;
              
              
            derivOut(3, i) = derivOut(3, i) + ...
                (2*viscosity/(particleRad^2))*(1/(particleRad^2))*viscKernelFunc(rho)*particleVol* ...
                (particleMat(5,j)-particleMat(5,i));
        end
    end        
    
end

