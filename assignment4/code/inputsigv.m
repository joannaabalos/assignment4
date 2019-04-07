function [U,time] = inputsigv(type)
time = linspace(0,1,100);
%     for n=1:numel(time)
%         t = time(n);
%         if t<2e-9 %Seg#1  
%             U(n)= 0;
%         end
%         if 2e-9<=t && t<3e-9   %Seg#2 
%             U(n)= 5e9*t - 10;
%         end
%         if  3e-9<=t && t<13e-9   %Seg#3
%             U(n)=  5; 
%         end
%         if 13e-9<=t && t<=14e-9   %Seg#4
%             U(n)= -5e9*t +70;
%         end
%         if  t>14e-9  %Seg#5
%             U(n)= 0;
%         end
%     end
    
    for n=1:numel(time)
        t = time(n);
        
        if (type==1) %Type 1: Step
            if t<0.03
                U(n) = 0;
            else
                U(n) = 1;
            end

        elseif (type==2) %Type 2: sin(2pift)
            f = 1/0.03;
            U(n) = sin(2*pi*f*t);

        else 

            U(n) = 1;
        end
        
    end
    

    

end