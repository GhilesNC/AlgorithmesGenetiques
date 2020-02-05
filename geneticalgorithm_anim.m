clc
clear

% Compteur de génération
Counter = 0;

% Entiers disponibles
Length = 10;
Integers = 1:Length;

% Somme/Produit cible
TargetSum = 36;
TargetProduct = 360;

% Fonction à maximiser
Function = @(S,P) 1 - ( abs(36-S)/36 + abs(log(P/360))/log(10080) )/2;

% Taille de la population
Size = 24;
% Initialisation de la population
Decimal = randperm(2^Length,Size)-1;
Population = logical(decimalToBinaryVector(Decimal,Length));
% Initialisation de l'utilité
Sum = CalcSum(not(Population));
Product = CalcProduct(Population);
Fitness = Function( Sum , Product );
[MaxFitness,MaxFitnessI] = max(Fitness);

Display(Counter,MaxFitness,Sum(MaxFitnessI),Product(MaxFitnessI),Population(MaxFitnessI,:));
[vid,PopulAnim,Tio] = Film_ga_init(Population);
pause

while MaxFitness<1
%   Sélection
    Reproduction = cumsum(Fitness)/sum(Fitness);
    Random = rand(1,Size);
    I = 1+sum(Random>Reproduction);
    Parent1 = Population(I,:);
    Random = rand(1,Size);
    I = 1+sum(Random>Reproduction);
    Parent2 = Population(I,:);
    
%   Croisement
    Random = logical(randi([0 1],Size,Length));
    Children = Parent1;
    Children(Random) = Parent2(Random);
    
%   Mutation
    I = (randi(10,Size,Length)==1);
    Mutant = not(Children(I));
    Children(I) = Mutant;
    
%   Nouvelle Génération
    Counter = Counter + 1;
    AllGenes = [Children;Population];
    Sum = CalcSum(not(AllGenes));
    Product = CalcProduct(AllGenes);
    Fitness = Function( Sum , Product );
    [~,I] = sort(Fitness,'descend');
    AllGenes = AllGenes(I,:);
    AllGenes = unique(AllGenes,'rows','stable');
    Population = AllGenes(1:Size,:);
    Sum = CalcSum(not(Population));
    Product = CalcProduct(Population);
    Fitness = Function( Sum , Product );
    [MaxFitness,MaxFitnessI] = max(Fitness);
    Display(Counter,MaxFitness,Sum(MaxFitnessI),Product(MaxFitnessI),Population(MaxFitnessI,:));
    Film_ga(Population,vid,PopulAnim,Tio);
end
close(vid)

function Y = CalcSum(X)
Integers = 1:size(X,2);
Y = X*Integers';
end

function Y = CalcProduct(X)
Integers = 1:size(X,2);
Y = X.*Integers;
Y(not(Y)) = 1;
Y = prod(Y,2);
end

function Display(C,MFF,MFS,MFP,MF)
fprintf('> Génération : %d \n',C);
fprintf('> Meilleure Utilité : %f ',MFF);
fprintf('\n  Somme : %d ',MFS); S = find(not(MF));
fprintf('= %d',S(1)); fprintf(' + %d',S(2:end));
fprintf('\n  Produit : %d ',MFP); P = find(MF);
fprintf('= %d',P(1)); fprintf(' × %d',P(2:end));
fprintf('\n\n');
end

function Film_ga(Logic,vid,PopulAnim,Tio)
for x = 1:size(Logic,1)
    for y = 1:size(Logic,2)
        CIndE = 4-Logic(x,y);
        PopulAnim(x,y).FaceVertexCData = CIndE;
        if Logic(x,y)
            Tio(x,y).String = 'I';
        else
            Tio(x,y).String = 'O';
        end
    end
end
img = getframe(gca);
writeVideo(vid,repmat(img,1,1,1,4));
end
