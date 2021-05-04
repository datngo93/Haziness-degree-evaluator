function [df] = new_indicator_v5_opt(I,winsize,dcpex)
    % default parameters
    switch nargin
        case 1
            winsize = 5;
            dcpex = 1;
        case 2
            dcpex = 1;
        otherwise
            % do nothing
    end

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
    
    Idcpex = I.^(1/dcpex);
    
    % Atmospheric light
    [~,~,~,~,a] = qtSubAl(Idcpex);
    a = a+0.7*(max(Idcpex,[],'all')-max(a));
    amean = mean(a);
    
    % Transmission map
    Imd = max(I,[],3)-min(I,[],3);
    Imo = minFilt2_opt(min(Idcpex,[],3),winsize);
    sigmaI = stdfilt(rgb2gray(I),true(winsize));
    temp = (Imd.*sigmaI).*((Imd.*sigmaI)-amean+Imo);
    x = (Imd.*sigmaI)+sqrt(abs(temp));
    t = (amean-Imo+x)/amean;
    tr = hmfm_v33(t,winsize);
    tr = min(max(tr,0),1);
    df = mean(1-tr,'all');
end
