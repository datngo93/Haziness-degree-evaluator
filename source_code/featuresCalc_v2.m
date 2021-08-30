function [f1,f3,f4] = featuresCalc_v2(I,sv)
    % input checking
    switch nargin
        case 1
            sv = 5;
        otherwise
            % all parameters are provided
    end
    
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
    
    % f1: DCP
    f1 = minFilt2_opt(min(I,[],3),sv);
    
    % f3: Saturation*Value
    f3 = max(I,[],3)-min(I,[],3); % (max(I)-min(I))/255
    
    % f4: Chroma
    Ilab = rgb2lab(I);
    f4 = sqrt(Ilab(:,:,2).^2+Ilab(:,:,3).^2);
end
