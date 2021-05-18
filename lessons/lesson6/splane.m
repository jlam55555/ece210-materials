function [] = splane(z,p)
    %creates a pole-zero plot using pole and zero inputs with the real and imaginary axes superimposed
    x1=real(z);
    x2=real(p);
    y1=imag(z);
    y2=imag(p);
   
    plot(x1,y1,'o',x2,y2,'x');
    xlabel('Real Part');
    ylabel('Imaginary Part');
    axis('equal');
    line([0 0], ylim(),'LineStyle', ':');
    line(xlim(), [0 0],'LineStyle', ':');  
end

