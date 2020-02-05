clc
clear

% Charactères disponibles
CharSet = [32,46,65:90,97:122];
% Phrase cible
Target = 'Message Cible.';
% Longueur de Phrase
Length = length(Target);

% Fonction à maximiser
Function = @(Phrase) sum(Phrase==Target,2)/Length;

% Pourcentage de mutation
MutPercent = 01;

Counters = zeros(100,1);
for i=1:100
% Compteur de génération
Counter = 0;

% Taille de la population
Size = 200;
% Initialisation de la population
Population = char(CharSet(randi(54,Size,Length)));
% Initialisation de l'utilité
Fitness = Function( Population );
[MaxFitness,MaxFitnessI] = max(Fitness);

% fprintf('> Génération : %d \n',Counter);
% fprintf('> Meilleure Utilité : %f \n',MaxFitness);
% fprintf('  " %s " \n',Population(MaxFitnessI,:));

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
    I = (randi(10000,Size,Length)<=100*MutPercent);
    Mutant = char(CharSet(randi(54,sum(I(:)),1)));
    Children(I) = Mutant;
    
%   Nouvelle Génération
    Counter = Counter + 1;
    Population = Children;
    Fitness = Function( Population );
    [MaxFitness,MaxFitnessI] = max(Fitness);
%   fprintf('\n');
%   fprintf('> Génération : %d \n',Counter);
%   fprintf('> Meilleure Utilité : %f \n',MaxFitness);
%   fprintf('  " %s " \n',Population(MaxFitnessI,:));
    
end
Counters(i) = Counter;
end
