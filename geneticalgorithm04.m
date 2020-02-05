clc
clear

% Compteur de génération
Counter = 0;

% Entiers disponibles
Length = 10;
% Somme/Produit cible
TargetSum = 36;
TargetProduct = 360;

% Fonction à maximiser
Function = @(S,P) 1-abs(36-S)/36/2-abs(360-P)/(3628800-360)/2;

% Taille de la population
Size = 40;
% Initialisation de la population
Population = logical(decimalToBinaryVector(randperm(2^Length,Size)-1,Length));
% Initialisation de l'utilité
Sum = CalcSum(not(Population));
Product = CalcProduct(Population);
Fitness = Function( Sum , Product );
[MaxFitness,MaxFitnessI] = max(Fitness);

Display(Counter,MaxFitness,Sum(MaxFitnessI),Product(MaxFitnessI));
pause

while MaxFitness<1
%   Sélection
    Random = randperm(Size,2);
    if Fitness(Random(1)) >= Fitness(Random(2))
        I = Random;
    else
        I = flip(Random);
    end
    
%   Croisement
    Random = ( randi(2,1,Length) == 1 );
    Population(I(2),Random) = Population(I(1),Random);
    
%   Mutation
    Random = ( randi(10,1,Length) == 1 );
    Population(I(2),Random) = not(Population(I(2),Random));
    
%   Nouvelle Génération
    Counter = Counter + 1;
    
    Sum = CalcSum(not(Population));
    Product = CalcProduct(Population);
    Fitness = Function( Sum , Product );
    [MaxFitness,MaxFitnessI] = max(Fitness);
    
    fprintf('\n');
    Display(Counter,MaxFitness,Sum(MaxFitnessI),Product(MaxFitnessI));
    if mod(Counter,1000)==0
        pause
    end
end

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

function Display(C,MF,SMF,PMF)
fprintf('> Génération : %d \n',C);
fprintf('> Meilleure Utilité : %f \n',MF);
fprintf('  Somme : %d \n',SMF);
fprintf('  Produit : %d \n',PMF);
end
