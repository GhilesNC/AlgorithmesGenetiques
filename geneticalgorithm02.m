clc
clear

% Compteur de g�n�ration
Compteur = 0;

% Fonction � maximiser
Fonction = @(x) 4*(x.*(1-x));

% Taille de la population
Taille = 5;
% Initialisation de la population
Population = logical(decimalToBinaryVector(randperm(256,Taille)-1,8)');
DecGray = binaryVectorToDecimal(Population')';
Dec = gray2bin(DecGray,'fsk',256);
% Initialisation de l'utilit�
Utilite = Fonction( Dec/256 );
UtiliteMax = max(Utilite);

fprintf('> G�n�ration : %d \n',Compteur);
fprintf('> Meilleure Utilit� : %f \n',UtiliteMax);
pause

while UtiliteMax<1
    % S�lection
    Reproduction = cumsum(Utilite)/sum(Utilite);
    Random = rand(Taille,1);
    I = 1+sum(Random>Reproduction,2);
    S1 = Population(:,I);
    Reproduction = cumsum(Utilite)/sum(Utilite);
    Random = rand(Taille,1);
    I = 1+sum(Random>Reproduction,2);
    S2 = Population(:,I);
    
    % Croisement
    I = logical(randi([0 1],8,Taille));
    C = S1;
    C(I) = S2(I);
    
    % Mutation
    I = (randi(10,8,Taille)==1);
    M = C;
    M(I) = not(M(I));
    
    % Nouvelle G�n�ration
    Compteur = Compteur + 1;
    Population = M;
    DecGray = binaryVectorToDecimal(Population')';
    Dec = gray2bin(DecGray,'fsk',256);
    Utilite = Fonction( Dec/256 );
    UtiliteMax = max(Utilite);
    
    fprintf('\n');
    fprintf('> G�n�ration : %d \n',Compteur);
    fprintf('> Meilleure Utilit� : %f\n',UtiliteMax);
    
end
