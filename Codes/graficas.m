close all;
tpi=expi.time();
xpi=expi.signals.values();
xpi=squeeze(xpi)
xpi=squeeze(xpi)
%tpiplot=tpi(tpi>=1.49);
%xpiplot=xpi(tpi>=1.49);
%plot(tpiplot-1.49,xpiplot,'LineWidth',0.7,'Color','r')

plot(tpi,xpi)
hold on
%plot(tout,theta_lin*(180/pi),'--b','LineWidth',1);
%plot(tout,theta_nl*(180/pi),'--r','LineWidth',1);

hold off
grid('on')
xlabel('time (s)')
ylabel('degrees')
xlim([0 25])
