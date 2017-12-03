function g_histogram = computeGradient(patch)
[m,n] = size(patch);
[FX,FY] = gradient(patch);
g_histogram = zeros(1,8);
for i=1:m
    for j=1:n
        if FX(i,j)>0 && -tan(pi/8)<(FY(i,j)/FX(i,j)) && (FY(i,j)/FX(i,j))<=tan(pi/8)
            g_histogram(1) = g_histogram(1)+norm([FY(i,j) FX(i,j)]);
        elseif FX(i,j)>0 && FY(i,j)>0 && tan(pi/8)<(FY(i,j)/FX(i,j)) && (FY(i,j)/FX(i,j))<=tan(3*pi/8)
            g_histogram(2) = g_histogram(2)+norm([FY(i,j) FX(i,j)]);
        elseif FY(i,j)>0 && tan(3*pi/8)<=abs((FY(i,j)/FX(i,j)))
            g_histogram(3) = g_histogram(3)+norm([FY(i,j) FX(i,j)]);
        elseif FX(i,j)<0 && FY(i,j)>0 && tan(5*pi/8)<=(FY(i,j)/FX(i,j)) && (FY(i,j)/FX(i,j))<=tan(7*pi/8)
            g_histogram(4) = g_histogram(4)+norm([FY(i,j) FX(i,j)]);
        elseif FX(i,j)<0 && abs((FY(i,j)/FX(i,j)))<=tan(pi/8)
            g_histogram(5) = g_histogram(5)+norm([FY(i,j) FX(i,j)]);
        elseif FX(i,j)<0 && FY(i,j)<0 && tan(9*pi/8)<=(FY(i,j)/FX(i,j)) && (FY(i,j)/FX(i,j))<=tan(11*pi/8)
            g_histogram(6) = g_histogram(6)+norm([FY(i,j) FX(i,j)]);
        elseif FY(i,j)<0 && (FY(i,j)/FX(i,j))<=tan(11*pi/8)
            g_histogram(7) = g_histogram(7)+norm([FY(i,j) FX(i,j)]);
        else
            g_histogram(8) = g_histogram(8)+norm([FY(i,j) FX(i,j)]);
        end
    end 
end

g_histogram=g_histogram./sum(g_histogram);
end