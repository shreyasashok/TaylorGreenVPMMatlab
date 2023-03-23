function K = kernelFunc(rho)

    %K = ((1/(4*pi*rho))*erf(rho/sqrt(2)) - (1/((2*pi)^(3/2)))*exp(-rho^2/2))/(rho^2);
    K = (1/(2*pi))*(1-exp(-rho^2/2));
end

