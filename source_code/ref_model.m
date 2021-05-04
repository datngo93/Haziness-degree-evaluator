function [df] = ref_model(I)
    % input checking
    if diff(getrangefromclass(I))==255 % uint8
        I = double(I)/255;
    elseif ~isa(I,'double')
        warning('Check input image!');
        return;
    else
        if (max(I,[],'all')>1)
            I = I/255;
        end
    end
    
    % feature calc.
    sv = 5;
    [f1,f3,f4] = featuresCalc_v2(I,sv);
    
    % feature normalization
    f1 = (f1-min(f1,[],'all'))/(max(f1,[],'all')-min(f1,[],'all')+eps);
    f3 = (f3-min(f3,[],'all'))/(max(f3,[],'all')-min(f3,[],'all')+eps);
    f4 = (f4-min(f4,[],'all'))/(max(f4,[],'all')-min(f4,[],'all')+eps);
    
    % fog density
    Df = -0.221+1.152*f1+1.176*f3-0.008*f4+0.455*f1.^2-...
         2.174*f1.*f3-1.703*f1.*f4-1.165*f3.^2-0.573*f3.*f4+0.920*f4.^2;
    t = exp(-Df);
    t(t<0.05) = 0.05;
    t(t>1) = 1;
    tref = guidedfilter(rgb2gray(I),t,16,1e-2);
    df = mean(1-tref,'all');
end
