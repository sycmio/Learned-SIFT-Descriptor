function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.
[R,C,L] = size(DoGPyramid);
locsDoG = zeros(0,3);
for i=1:R
    for j=1:C
        for k=1:L
            isExtrema = 1;            
            if PrincipalCurvature(i,j,k)<th_r && PrincipalCurvature(i,j,k)>0 && abs(DoGPyramid(i,j,k))>th_contrast            
                localmax = max(max(DoGPyramid(max(i-1,1):min(i+1,R),max(j-1,1):min(j+1,C),k)));
                localmin = min(min(DoGPyramid(max(i-1,1):min(i+1,R),max(j-1,1):min(j+1,C),k)));
                if DoGPyramid(i,j,k)~=localmax && DoGPyramid(i,j,k)~=localmin
                    continue
                end
                if k>1
                    if DoGPyramid(i,j,k)==localmin
                        if DoGPyramid(i,j,k)>DoGPyramid(i,j,k-1)
                            isExtrema = 0;
                        end

                    else
                        if DoGPyramid(i,j,k)<DoGPyramid(i,j,k-1)
                            isExtrema = 0;
                        end
                    end
                end
                if k<L
                    if DoGPyramid(i,j,k)==localmin
                        if DoGPyramid(i,j,k)>DoGPyramid(i,j,k+1)
                            isExtrema = 0;
                        end
                    else
                        if DoGPyramid(i,j,k)<DoGPyramid(i,j,k+1)
                            isExtrema = 0;
                        end
                    end
                end
            
                if isExtrema
                    locsDoG = [locsDoG;j i DoGLevels(k)];
                end
            end            
        end
    end    
end

end