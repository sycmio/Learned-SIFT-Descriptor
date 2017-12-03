function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid
[R,C,L] = size(DoGPyramid);
PrincipalCurvature = zeros(R,C,L);
for k=1:L
    [Dx,Dy] = gradient(DoGPyramid(:,:,k));
    [Dxx,Dxy] = gradient(Dx);
    [Dyx,Dyy] = gradient(Dy); 
    for i=1:R
       for j=1:C
          H = [Dxx(i,j) Dxy(i,j);Dyx(i,j) Dyy(i,j)];
          PrincipalCurvature(i,j,k) = trace(H)^2/det(H);
       end
    end
end

end