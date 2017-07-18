% Test 2

% Delay deviation and fine delay alignement of code. The doppler frequency
% and the code are assumed known (and are provided as extern files).

clear
clc

%% Constants

fs = 20.460*1e6;               % sampling frequency of the data stream [Hz]
T_P = 1e-3;                    % Primary Code duration [sec]
sample_in_P = round(fs*T_P);   % Primary Code samples
index_S_p_start = 87;          % starting phase of secondary code

%% Key Parameters

r_threshold = 1.17;   % threshold for re-alignment
nr_block = 3;  % block dimension (nr of Primary Codes in the block)


%% External Inputs

load('Test2_Data.mat') % load the data for the test
load('Code_P.mat')     % load the Primary Code
load('Code_S.mat')     % load the Secondary Code
load('Doppler.mat')    % the doppler frequency corresponding to each Primary Code [Hz]
load('DRR.mat')        % the doppler removal ramps for each Primary Code
load('Fine_Delay_LUT_MultiSat.mat') % load of the LUT

%% Time and Frequency Axis

t_fast = (0:1/fs:T_P-1/fs)-T_P/2;                 % Primary Code sampled time axis [sec]
f_P = (-fs/2:fs/sample_in_P:fs/2-fs/sample_in_P); % frequency axis [Hz]

%% Nr of Blocks

tot_blocks = floor((size(Data_plus_Noise,2)/sample_in_P)/nr_block); % nr of blocks to be processed in the test

%% Structure Init

% Early/Late Gates
S_P_Early_1 = circshift(Code_P,-1,2);
S_P_Late_1 = circshift(Code_P,1,2);
% Output
Data_preConditioned = zeros(1,nr_block*sample_in_P);
r = zeros(1,nr_block);
r_avg = zeros(1,tot_blocks);
delays=zeros(1,tot_blocks);

%% Cycle on Blocks
for bb = 1:tot_blocks
    %% Data Selection
    index_start_block = 1 + (bb-1)*nr_block*sample_in_P;               % index of the first sample in the block
    index_end_block = index_start_block + nr_block*sample_in_P - 1;    % index of the last sample in the block
    Data_plus_Noise_Block = Data_plus_Noise(index_start_block:index_end_block); % estract data block from buffer array
    % Secondary Code Removal
    index_S_p = mod(index_S_p_start+(0:nr_block-1)+(bb-1)*nr_block,100) +...
        100*(mod(index_S_p_start+(0:nr_block-1)+(bb-1)*nr_block,100)==0); % Select Secondary code section
    SS_a_p = exp(1i*pi*Code_S(index_S_p));
    % Doppler Removal Ramp
    DRR_in_P = DRR(index_start_block:index_start_block+sample_in_P-1);
    DRR_in_B = exp(-1i*2*pi*Doppler(1+(bb-1)*nr_block)*(0:nr_block-1)*T_P);
    %% Delay Deviation Estimation
    for bbb = 1:nr_block
        index_P = (1+(bbb-1)*sample_in_P:bbb*sample_in_P);                                                  % indeces of the samples in the primary code
        Data_preConditioned(index_P) = Data_plus_Noise_Block(index_P).*DRR_in_P.*DRR_in_B(bbb)*SS_a_p(bbb); % secondary code stripping and doppler removal
        r(bbb) = abs(sum(Data_preConditioned(index_P).*S_P_Early_1))/ ...
        abs(sum(Data_preConditioned(index_P).*S_P_Late_1));  % gating
    end
    r_avg(bb) = mean(r);
    %% Alignement of Structures
    if (r_avg(bb)>r_threshold)||(r_avg(bb)<(1/r_threshold)) % the delay deviation is evaluated only if it is above a fixed threshold
        %% Search in LUT
        index_delta = abs(r_LUT-r_avg(bb))==min(abs(r_LUT-r_avg(bb)));
        delta_delay = delta_t_LUT(index_delta);  % time alignement required [sec]
        delays(bb)=delta_delay;
        %% Alignment
        Code_P = ifft(fftshift(fftshift(fft(Code_P)) .* exp(-1i*2*pi*f_P*delta_delay)));
        % Early/Late Gates
        S_P_Early_1 = circshift(Code_P,-1,2);
        S_P_Late_1 = circshift(Code_P,1,2);
    end
    
end

%% Result

figure(1)
hold off
h(1)=plot(r_avg,'r','LineWidth',4);
hold on
plot(1:tot_blocks,r_threshold*ones(1,tot_blocks),'g','LineWidth',2)
hold on
h(3)=plot(1:tot_blocks,1/r_threshold*ones(1,tot_blocks),'g','LineWidth',2)
hold on
%title('r Index Value')
axis([0 tot_blocks 0 2]);
ax1 = gca;
xlabel('Block Index')
ylabel('Average R');
ax2 = axes('Position',get(ax1,'Position'),...
       'XAxisLocation','top',...
       'YAxisLocation','right',...
       'Color','none',...
       'XColor','k','YColor','k');
hold on
linkaxes([ax1 ax2],'x');
ylabel('Delay (ps)');
axis([0 tot_blocks -20 20]);
h(2)=stairs(1:tot_blocks,delays*1000000000,'Parent',ax2,'b','LineWidth',2);
legend(h([1 2 3]), 'Average R', 'Delay (ps)', 'Alignment treshold')
grid on
