% read la5c data
close all; clc; clear;

% data
pathdata = '..\..\LA5C_data_preprocessed-20221004T081748Z-001\LA5C_data_preprocessed';

nreg = 268;

% 
ngr = 4;
pathdataNreg = [pathdata filesep 'ts' num2str(nreg)];

tab = readtable([pathdata filesep 'demo.csv']);

%% read data
for i = 1:ngr
    idx_subj = find(tab.group==i);
    name_subj = tab.sub_id(idx_subj);
    meanRois = [];
    nsubj = 0;
    disp(i);
    for j = 1:length(name_subj)
        pp = [pathdataNreg filesep 'processed' filesep name_subj{j} ...
                    filesep 'fmri_rest' filesep 'data_ROI_' num2str(nreg) '.mat'];
        try
            dd = load(pp);
            dd = zscore(dd.data_ROI(:,1:nreg));
            meanRois = [meanRois;dd];
            
            nsubj = nsubj+1;
        catch
            disp('bad subject..')
        end
    end
    save(['data' num2str(nreg) '_gr' num2str(i) '.mat'], 'meanRois', 'nsubj');
end
