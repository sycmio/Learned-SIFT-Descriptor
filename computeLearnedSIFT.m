function [locs,desc] = computeLearnedSIFT(im, GaussianPyramid, locsDoG, k, levels)
[R,C,L] = size(GaussianPyramid);
locs = zeros(0,3);
patches=zeros(1,64,64);
for i=1:size(locsDoG,1)

%     bound = floor(sqrt(2)*patch_half_size
    bound = 32;
    if locsDoG(i,1)>=bound && locsDoG(i,2)>=bound && locsDoG(i,1)<=C-bound && locsDoG(i,2)<=R-bound
        locs = [locs;locsDoG(i,:)];
        % compute 128-D discriptor
        
        patch = im(locsDoG(i,2)+1-bound:locsDoG(i,2)+bound,locsDoG(i,1)+1-bound:locsDoG(i,1)+bound);       
        %patch = GaussianPyramid(locsDoG(i,2)+1-bound:locsDoG(i,2)+bound,locsDoG(i,1)+1-bound:locsDoG(i,1)+bound,level);       
       
        % compute major gradient
        %tmp_patch = GaussianPyramid(locsDoG(i,2)+1-patch_half_size:locsDoG(i,2)+patch_half_size,locsDoG(i,1)+1-patch_half_size:locsDoG(i,1)+patch_half_size,level);
        %tmp_patch = imresize(tmp_patch, [norm_patch_size norm_patch_size]);
        %g_histogram = computeGradient(tmp_patch);
        %[~,major_g_index] = max(g_histogram);
        % rotate patch
        %patch = imrotate(patch,-45*(major_g_index-1));
        %[h,w] = size(patch);
        %h = floor(h/2);
        %w = floor(w/2);
        %patch = patch(h+1-patch_half_size:h+patch_half_size,w+1-patch_half_size:w+patch_half_size);
        %patch = imresize(patch, [norm_patch_size norm_patch_size]);
        patches(end,:,:)=imresize(patch,[64,64]);
        patches=[patches;zeros(1,64,64)];
    end
end
save('patch.mat','patches');
system('python compute_desc.py');
load('learned_desc.mat');