function oo = syn_factors_oinfo(F,X)
    p = size(X,2);
    oo = zeros(1,p);
    for i = 1:p
        oo(i) = mean(OI_Local([F X(:,i)],'gaussian'));
    end
end
    