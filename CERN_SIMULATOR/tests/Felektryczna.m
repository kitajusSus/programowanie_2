function [F_vec, F_mag] = Felektryczna(particle1, particle2)
    % Funkcja obliczająca siłę elektrostatyczną między dwoma cząstkami
    % Stała Coulomba
    k = 8.99e9; % N*m^2/C^2

    % Wektor od particle1 do particle2
    r_vec = particle2.position - particle1.position;
    r_mag = norm(r_vec);

    % Unikamy dzielenia przez zero
    if r_mag < 1e-10
        F_vec = [0, 0, 0];
        F_mag = 0;
        return;
    end

    % Jednostkowy wektor kierunku
    r_unit = r_vec / r_mag;

    % Siła elektrostatyczna (wartość): F = k * (q1 * q2) / r^2
    F_mag = k * (particle1.charge * particle2.charge) / (r_mag^2);

    % Wektor siły: dodatni - przyciąganie, ujemny - odpychanie
    F_vec = F_mag * r_unit;
end
