function plotField(particleMat, domainL, scale)

clf;
quiver(particleMat(1, :), particleMat(2, :), particleMat(3, :)*scale, particleMat(4, :)*scale, 0);
hold on;
box on;
axis equal;
plot(particleMat(1,:), particleMat(2,:), 'r.');
xlim([0, domainL]);
ylim([0, domainL]);

end

