x = [1005 990 965 945 927 904 885 863 844 820 800 780 763 742 722 705 688 665 650 631 616 592 578 560 539]; % output in bits
y = [-60:5:60];                 % angular position in degrees
n = 1;                           % order of the polynomial to be fit
p = polyfit(x,y,n)               % coefficients of the fitted polynomial
