addpath('../.');

Cz_1 = data_1(1).Earphone40Hz{1}.trial{1}(8,:);
Cz_2 = data_2(1).Earphone40Hz{1}.trial{1}(7,:);

TP10_1 = data_1(1).Earphone40Hz{1}.trial{1}(22,:);
TP10_2 = data_2(1).Earphone40Hz{1}.trial{1}(21,:);

V1_1 = data_1(1).Earphone40Hz{1}.trial{1}(31,:);
V2_1 = data_1(1).Earphone40Hz{1}.trial{1}(32,:);

F9_1 = data_1(1).Earphone40Hz{1}.trial{1}(4,:);
F10_1 = data_1(1).Earphone40Hz{1}.trial{1}(30,:);

EOGV = data_2(1).Earphone40Hz{1}.trial{1}(30,:);
EOGH = data_2(1).Earphone40Hz{1}.trial{1}(31,:);

REF = data_2(1).Earphone40Hz{1}.trial{1}(29,:);

figure(1);
plot(TP10_1);
hold on; 
plot(TP10_2);
plot(TP10_1 - 2 .* TP10_2);

figure(2);
plot(Cz_1);
hold on;
plot(Cz_2);
plot(Cz_1-TP10_2);

figure(3);
plot(V2_1);
hold on;
plot(V1_1);
plot(EOGV);
plot(V2_1 - V1_1);

figure(4);
plot(F10_1);
hold on;
plot(F9_1);
plot(EOGH);
plot(F10_1 - F9_1);