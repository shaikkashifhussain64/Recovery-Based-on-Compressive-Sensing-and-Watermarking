function [] = PlotResults()
close all;
clear all;
clc;

load Fitness
%% Convergence Curve
for n = 1 : 1
    for j = 1 : 5 % For all algorithms
        Value = Fit{1, n};
        val(j,:) = statistical_Analysis(Value(j, :));
    end
    disp('Statistical Analysis :')
    ln = {'BEST','WORST','MEAN','MEDIAN','STANDARD DEVIATION'};
    T = table(val(1, :)', val(2, :)', val(3, :)',val(4, :)', val(5, :)','Rownames',ln);
    T.Properties.VariableNames = {'TSA','GEO','RFO','SCO','PROPOSED'};
    disp(T)
    Value = Fit{1, n};
    figure,
    plot(Value(1, :),'Color','r', 'LineWidth', 2)
    hold on;
    plot(Value(2, :),'Color','g', 'LineWidth', 2)
    plot(Value(3, :),'Color','[0.1 0.9 0.8]', 'LineWidth', 2)
    plot(Value(4, :),'Color','[0.7 0 1]', 'LineWidth', 2)
    plot(Value(5, :),'Color','k', 'LineWidth', 2)
    set(gca,'fontsize',20);
    xlabel('No. of Iterations','fontsize',16);
    ylabel('Cost Function','fontsize',16);
    h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
    set(h,'fontsize',12,'Location','Best')
    print('-dtiff','-r300',['.\Results\', 'Convergence-',num2str(n)])
end

%% CPA Attack 
load CPA_attack
figure
plot(CPA_attack(1, 1:5),'Color','[0.7 0 1]', 'LineWidth', 2)
hold on;
plot(CPA_attack(2, 1:5),'Color','m', 'LineWidth', 2)
plot(CPA_attack(3, 1:5),'Color','b', 'LineWidth', 2)
plot(CPA_attack(4, 1:5),'Color','c', 'LineWidth', 2)
plot(CPA_attack(5, 1:5),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xlabel('Case','fontsize',16);
ylabel('Correlation Coefficient','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'CPA-Alg'])


figure
plot(CPA_attack(1, 6:end),'Color','g', 'LineWidth', 2)
hold on;
plot(CPA_attack(2, 6:end),'Color','[0.7 0 1]', 'LineWidth', 2)
plot(CPA_attack(3, 6:end),'Color','b', 'LineWidth', 2)
plot(CPA_attack(4, 6:end),'Color','c', 'LineWidth', 2)
plot(CPA_attack(5, 6:end),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xlabel('Case','fontsize',16);
ylabel('Correlation Coefficient','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'CPA-Method'])

%% KPA Attack
load KPA_attack
figure
plot(KPA_attack(1, 1:5),'Color','[0.7 0 1]', 'LineWidth', 2)
hold on;
plot(KPA_attack(2, 1:5),'Color','m', 'LineWidth', 2)
plot(KPA_attack(3, 1:5),'Color','b', 'LineWidth', 2)
plot(KPA_attack(4, 1:5),'Color','c', 'LineWidth', 2)
plot(KPA_attack(5, 1:5),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xlabel('Case','fontsize',16);
ylabel('Correlation Coefficient','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'KPA-Alg'])


figure
plot(KPA_attack(1, 6:end),'Color','g', 'LineWidth', 2)
hold on;
plot(KPA_attack(2, 6:end),'Color','[0.7 0 1]', 'LineWidth', 2)
plot(KPA_attack(3, 6:end),'Color','b', 'LineWidth', 2)
plot(KPA_attack(4, 6:end),'Color','c', 'LineWidth', 2)
plot(KPA_attack(5, 6:end),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xlabel('Case','fontsize',16);
ylabel('Correlation Coefficient','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'KPA-Method'])


%% NPCR
load NPCR
figure
plot(NPCR(1, 1:5),'Color','[0.7 0 1]', 'LineWidth', 2)
hold on;
plot(NPCR(2, 1:5),'Color','m', 'LineWidth', 2)
plot(NPCR(3, 1:5),'Color','b', 'LineWidth', 2)
plot(NPCR(4, 1:5),'Color','c', 'LineWidth', 2)
plot(NPCR(5, 1:5),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('NPCR','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'NPCR-Alg'])


figure
plot(NPCR(1, 6:end),'Color','g', 'LineWidth', 2)
hold on;
plot(NPCR(2, 6:end),'Color','[0.7 0 1]', 'LineWidth', 2)
plot(NPCR(3, 6:end),'Color','b', 'LineWidth', 2)
plot(NPCR(4, 6:end),'Color','c', 'LineWidth', 2)
plot(NPCR(5, 6:end),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('Correlation Coefficient','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'NPCR-Method'])


%% MSE
load MSE
figure
plot(MSE(1, 1:5),'Color','[0.7 0 1]', 'LineWidth', 2)
hold on;
plot(MSE(2, 1:5),'Color','m', 'LineWidth', 2)
plot(MSE(3, 1:5),'Color','b', 'LineWidth', 2)
plot(MSE(4, 1:5),'Color','c', 'LineWidth', 2)
plot(MSE(5, 1:5),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('MSE','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'MSE-Alg'])


figure
plot(MSE(1, 6:end),'Color','g', 'LineWidth', 2)
hold on;
plot(MSE(2, 6:end),'Color','[0.7 0 1]', 'LineWidth', 2)
plot(MSE(3, 6:end),'Color','b', 'LineWidth', 2)
plot(MSE(4, 6:end),'Color','c', 'LineWidth', 2)
plot(MSE(5, 6:end),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('MSE','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'MSE-Method'])


%% PSNR
load PSNR
figure
plot(PSNR(1, 1:5),'Color','[0.7 0 1]', 'LineWidth', 2)
hold on;
plot(PSNR(2, 1:5),'Color','m', 'LineWidth', 2)
plot(PSNR(3, 1:5),'Color','b', 'LineWidth', 2)
plot(PSNR(4, 1:5),'Color','c', 'LineWidth', 2)
plot(PSNR(5, 1:5),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('PSNR','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'PSNR-Alg'])


figure
plot(PSNR(1, 6:end),'Color','g', 'LineWidth', 2)
hold on;
plot(PSNR(2, 6:end),'Color','[0.7 0 1]', 'LineWidth', 2)
plot(PSNR(3, 6:end),'Color','b', 'LineWidth', 2)
plot(PSNR(4, 6:end),'Color','c', 'LineWidth', 2)
plot(PSNR(5, 6:end),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('PSNR','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'PSNR-Method'])



%% SSIM
load SSIM
figure
plot(SSIM(1, 1:5),'Color','[0.7 0 1]', 'LineWidth', 2)
hold on;
plot(SSIM(2, 1:5),'Color','m', 'LineWidth', 2)
plot(SSIM(3, 1:5),'Color','b', 'LineWidth', 2)
plot(SSIM(4, 1:5),'Color','c', 'LineWidth', 2)
plot(SSIM(5, 1:5),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('SSIM','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'SSIM-Alg'])


figure
plot(SSIM(1, 6:end),'Color','g', 'LineWidth', 2)
hold on;
plot(SSIM(2, 6:end),'Color','[0.7 0 1]', 'LineWidth', 2)
plot(SSIM(3, 6:end),'Color','b', 'LineWidth', 2)
plot(SSIM(4, 6:end),'Color','c', 'LineWidth', 2)
plot(SSIM(5, 6:end),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('SSIM','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'SSIM-Method'])


%% UACI
load UACI
figure
plot(UACI(1, 1:5),'Color','[0.7 0 1]', 'LineWidth', 2)
hold on;
plot(UACI(2, 1:5),'Color','m', 'LineWidth', 2)
plot(UACI(3, 1:5),'Color','b', 'LineWidth', 2)
plot(UACI(4, 1:5),'Color','c', 'LineWidth', 2)
plot(UACI(5, 1:5),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('UACI','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'UACI-Alg'])


figure
plot(UACI(1, 6:end),'Color','g', 'LineWidth', 2)
hold on;
plot(UACI(2, 6:end),'Color','[0.7 0 1]', 'LineWidth', 2)
plot(UACI(3, 6:end),'Color','b', 'LineWidth', 2)
plot(UACI(4, 6:end),'Color','c', 'LineWidth', 2)
plot(UACI(5, 6:end),'Color','k', 'LineWidth', 2)
set(gca,'fontsize',16)
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'64 x 64','128 x 128','256 x 256', '512 x 512', '1024 x 1024'})
xtickangle(30)
xlabel('Image Size','fontsize',16);
ylabel('UACI','fontsize',16);
print('-dtiff','-r300',['.\Results\', 'UACI-Method'])

%% Computational Time
load Time
fh = figure();
bar(Time(:, 1:5)', 'Linewidth', 1.5)
set(gca, 'fontsize', 12);
grid on;
xlabel('Block Size', 'fontsize', 12);
ylabel('Computational Time(Sec)', 'fontsize', 12);
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'5','10','15', '20', '25'})
xtickangle(30)
print('-dtiff', '-r300', ['./Results/', 'CompTime-Alg'])
       
fh = figure();
bar(Time(:, 6:10)', 'Linewidth', 1.5)
set(gca, 'fontsize', 12);
grid on;
xlabel('Block Size', 'fontsize', 12);
ylabel('Computational Time(Sec)', 'fontsize', 12);
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'5','10','15', '20', '25'})
xtickangle(30)
print('-dtiff', '-r300', ['./Results/', 'CompTime-Method'])        



%% Memory Size
load Memory
fh = figure();
bar(Memory(:, 1:5)', 'Linewidth', 1.5)
set(gca, 'fontsize', 12);
grid on;
xlabel('Block Size', 'fontsize', 12);
ylabel('Memory Size(KB)', 'fontsize', 12);
h = legend('TSA-A-2DLCE','GEO-A-2DLCE','RFO-A-2DLCE','SCO-A-2DLCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'5','10','15', '20', '25'})
xtickangle(30)
print('-dtiff', '-r300', ['./Results/', 'Memory-Alg'])
        
fh = figure();
bar(Memory(:, 6:10)', 'Linewidth', 1.5)
set(gca, 'fontsize', 12);
grid on;
xlabel('Block Size', 'fontsize', 12);
ylabel('Memory Size(KB)', 'fontsize', 12);
h = legend('DWT-CS','Chaotic map','Arnold map','ALCE','ISCO-A-2DLCE');
set(h,'fontsize',10,'Location','northeastoutside')
xticks([1 2 3 4 5])
xticklabels({'5','10','15', '20', '25'})
xtickangle(30)
print('-dtiff', '-r300', ['./Results/', 'Memory-Method']) 
end

function[a] = statistical_Analysis(val)
a(1) = min(val);
a(2) = max(val);
a(3) = mean(val);
a(4) = median(val);
a(5) = std(val);
end