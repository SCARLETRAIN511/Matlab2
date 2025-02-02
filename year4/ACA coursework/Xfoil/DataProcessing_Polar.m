%% 设置导入选项并导入数据
clear
clc

opts = delimitedTextImportOptions("NumVariables", 12);

% 指定范围和分隔符
opts.DataLines = [13, 36];
opts.Delimiter = " ";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "Var8", "Var9", "Var10", "Var11", "Var12"];
opts.SelectedVariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string", "string"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% 指定变量属性
opts = setvaropts(opts, ["Var8", "Var9", "Var10", "Var11", "Var12"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var8", "Var9", "Var10", "Var11", "Var12"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "VarName1", "TrimNonNumeric", true);
opts = setvaropts(opts, "VarName1", "ThousandsSeparator", ",");

% 导入数据
polarNew = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\Xfoil\polarNew.dat", opts);

%% 转换为输出类型
dataFinal = table2array(polarNew);

%% 清除临时变量
clear opts

opts = delimitedTextImportOptions("NumVariables", 3);

% 指定范围和分隔符
opts.DataLines = [3, Inf];
opts.Delimiter = " ";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "Rn", "VarName3"];
opts.VariableTypes = ["double", "double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% 导入数据
NACA2415exppolar = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\Xfoil\NACA-2415_exp_polar.dat", opts);

%% 转换为输出类型
data_experimental = table2array(NACA2415exppolar);

alphaExp = data_experimental(:,1);
clExp = data_experimental(:,2);
cdExp = data_experimental(:,3);

alpha = dataFinal(:,1);
cl = dataFinal(:,2);
cd = dataFinal(:,3);


%iter = 200
figure(1)
plot(alpha, cl);
hold on
plot(alphaExp,clExp);
title("CL Comparison");
xlabel("AoA/degree");
ylabel("CL");
legend("Xfoil","Experimental");
grid on
hold off


figure(2)
plot(cd,cl);
hold on
plot(cdExp, clExp);
xlabel("CD");
ylabel("CL");
legend("Xfoil","Experimental");
title("CL over CD");
grid on
hold off

figure(3)
plot(alpha, cl./cd);
hold on
plot(alphaExp, clExp./cdExp);
xlabel("AoA/degree");
ylabel("L/D");
legend("Xfoil", "Experimental");
title("L/D vs AoA");
grid on