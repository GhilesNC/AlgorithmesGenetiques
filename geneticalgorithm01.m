clc
clear

% Compteur de génération
Compteur = 0;

% Initialisation de la population
P = logical([[1;0;1;0;1;0],[0;0;0;1;1;1]]);
% Initialisation de l'utilité
U = sum(P);
fprintf('Génération : %d,\n Utilité : [ %d  %d ].\n',Compteur,U(1),U(2));

while max(U)<6
    % Sélection
    [~,I] = sort(U,'descend');
    s1 = P(:,I(1));
    s2 = P(:,I(2));
    
    % Croisement
    r = randi(5);
    p1 = [s1(1:r);s2(r+1:6)];
    p2 = [s2(1:r);s1(r+1:6)];
    
    % Mutation
    if randi(5)==1
        r = randi(6);
        p1(r) = not(p1(r));
    end
    if randi(5)==1
        r = randi(6);
        p2(r) = not(p2(r));
    end
    
    Compteur = Compteur + 1;
    P = [p1,p2];
    U = sum(P);
    fprintf('\nGénération : %d,\n Utilité : [ %d  %d ].\n'...
                                                      ,Compteur,U(1),U(2));
end

