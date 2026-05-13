% lf and HOI analysis (local O-info)
clear; clc; close;

%% data

dgr = 2; % 1:4
dgr_names = {'Control', 'Schz', 'Bipolar', 'ADHD'};

nreg = 268;

load Shen268_yeo_RS7.mat

rsn_names = {'VIS' 'SM' 'DA' 'VA' 'L' 'FP' 'DMN' 'SUBC' 'CER'};
rsn = rsn_names(yeoROIs)'; % groups (rs names)
rsn = categorical(rsn);

%% params 

n_hf = 20; % number of LF considered

%% computing synergies 

OO = cell(length(dgr),1);
for idg = 1:length(dgr)
    
    disp(['Grupo... ' num2str(dgr(idg))]);

    load(['data' num2str(nreg) '_gr' num2str(dgr(idg)) '.mat']);

    % compute lf
    X = meanRois; clear meanRois;
    [lambda,psi,T,stats,F] = factoran(X,n_hf);

    Fn = zscore(F); % 

    % compute OI  
    F = Fn(:,4:n_hf); % removing first components
    oo = syn_factors_oinfo(F,X);

    OO{idg} = oo;   
end

%% plot

% violin plot
for idg = 1:length(dgr)

    x = -OO{idg}'; % HOI measure

    tbl = table(rsn,x);

    figure;
    for i = 1:length(rsn_names)
        if i==1
            al_goodplot(tbl.x(tbl.rsn==rsn_names(i)),[],[],[],[],[],[],[],[]);
        else
            al_goodplot(tbl.x(tbl.rsn==rsn_names(i)),i);
        end
    end
    xticks(1:length(rsn_names));
    xticklabels(rsn_names);
    a = gca;
    ylabel('-O_{inf}')
    a.FontSize = 18;
    ylim([0,1]);
    title(dgr_names{dgr(idg)});
end