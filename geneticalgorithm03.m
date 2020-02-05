clc
clear

% Charact�res disponibles
CharSet = [32,46,65:90,97:122];
% Phrase cible
Target = 'Message Cible.';
% Longueur de Phrase
Length = length(Target);

% Fonction � maximiser
Function = @(Phrase) sum(Phrase==Target,2)/Length;

% Pourcentage de mutation
MutPercent = 01;

Counters = zeros(100,1);
for i=1:100
% Compteur de g�n�ration
Counter = 0;

% Taille de la population
Size = 200;
% Initialisation de la population
Population = char(CharSet(randi(54,Size,Length)));
% Initialisation de l'utilit�
Fitness = Function( Population );
[MaxFitness,MaxFitnessI] = max(Fitness);

% fprintf('> G�n�ration : %d \n',Counter);
% fprintf('> Meilleure Utilit� : %f \n',MaxFitness);
% fprintf('  " %s " \n',Population(MaxFitnessI,:));

while MaxFitness<1
%   S�lection
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
    I = (randi(10000,Size,Length)<=100*MutPercent);
    Mutant = char(CharSet(randi(54,sum(I(:)),1)));
    Children(I) = Mutant;
    
%   Nouvelle G�n�ration
    Counter = Counter + 1;
    Population = Children;
    Fitness = Function( Population );
    [MaxFitness,MaxFitnessI] = max(Fitness);
%   fprintf('\n');
%   fprintf('> G�n�ration : %d \n',Counter);
%   fprintf('> Meilleure Utilit� : %f \n',MaxFitness);
%   fprintf('  " %s " \n',Population(MaxFitnessI,:));
    
end
Counters(i) = Counter;
end
