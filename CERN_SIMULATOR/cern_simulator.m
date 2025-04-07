%cern simulator,
%  Przedmiot: Programowanie 2 |semestr letni 2025 fizyka ogólna|
% Indeks: 89219,

#{
Opis projektu:
- stosując paradygmat programowania obiektowego w GNU/Octave:
- za dużo by opisywac dalej poprostu sprawdz README.md
#}

% = Particle(masa, [x,y,x], [vx,vy,vx], 'nazwa_particle');
function skibidi_simulator
    % CERN SIMULATOR GUI - Program z interfejsem graficznym do symulacji cząstek
    % Autor: Krzysztof Bezubik
    % Data: 2025-04-07

    % Tworzenie i konfiguracja głównego okna
    fig = figure('Name', 'bajoJajoNazwa - GUI', 'NumberTitle', 'off', ...
                'Position', [100, 100, 1000, 600], 'MenuBar', 'none', ...
                'Resize', 'on', 'CloseRequestFcn', @exitProgram);

    % Definicja kolorów interfejsu
    colors.background = [0.95, 0.95, 0.95];
    colors.panel = [0.9, 0.9, 0.9];
    colors.button = [0.85, 0.85, 0.85];
    colors.particle1 = [0.8, 0.2, 0.2]; % czerwony
    colors.particle2 = [0.2, 0.2, 0.8]; % niebieski

    % Ustawienie tła głównego okna
    set(fig, 'Color', colors.background);

    % Układ interfejsu - podział na panele
    mainLayout = uiextras.HBoxFlex('Parent', fig, 'Spacing', 5, 'Padding', 5);

    % Panel z parametrami symulacji i kontrolkami
    controlPanel = uiextras.VBox('Parent', mainLayout, 'Spacing', 5, 'Padding', 5);
    % Panel do rysowania symulacji
    simulationPanel = uiextras.Panel('Parent', mainLayout, 'Title', 'Symulacja');
    set(mainLayout, 'Sizes', [-1 -3]); % Proporcje podziału (1:3)

    % Tworzenie osi do rysowania w panelu symulacji
    simulationAxes = axes('Parent', simulationPanel, ...
                         'Position', [0.05, 0.05, 0.9, 0.9], ...
                         'XLim', [-10, 10], 'YLim', [-10, 10], ...
                         'DataAspectRatio', [1 1 1], ...
                         'Box', 'on', 'XGrid', 'on', 'YGrid', 'on');
    title(simulationAxes, 'Symulacja ruchu cząstek');
    xlabel(simulationAxes, 'X');
    ylabel(simulationAxes, 'Y');

    % Podział panelu kontrolnego na sekcje
    % Panel parametrów cząstki 1
    particle1Panel = uiextras.Panel('Parent', controlPanel, 'Title', 'Cząstka 1 (czerwona)');
    % Panel parametrów cząstki 2
    particle2Panel = uiextras.Panel('Parent', controlPanel, 'Title', 'Cząstka 2 (niebieska)');
    % Panel z przyciskami kontrolnymi
    controlButtonsPanel = uiextras.Panel('Parent', controlPanel, 'Title', 'Sterowanie');
    % Panel z informacjami o symulacji
    infoPanel = uiextras.Panel('Parent', controlPanel, 'Title', 'Dane symulacji');

    % Proporcje podziału panelu kontrolnego
    set(controlPanel, 'Sizes', [-1 -1 -0.5 -1.5]);

    % --- PANEL CZĄSTKI 1 ---
    p1Layout = uiextras.Grid('Parent', particle1Panel, 'Spacing', 5, 'Padding', 5);

    % Etykiety
    uicontrol('Parent', p1Layout, 'Style', 'text', 'String', 'Masa:');
    uicontrol('Parent', p1Layout, 'Style', 'text', 'String', 'Ładunek:');
    uicontrol('Parent', p1Layout, 'Style', 'text', 'String', 'Prędkość X:');
    uicontrol('Parent', p1Layout, 'Style', 'text', 'String', 'Prędkość Y:');
    uicontrol('Parent', p1Layout, 'Style', 'text', 'String', 'Pozycja X:');
    uicontrol('Parent', p1Layout, 'Style', 'text', 'String', 'Pozycja Y:');

    % Pola edycji dla cząstki 1
    p1MassEdit = uicontrol('Parent', p1Layout, 'Style', 'edit', 'String', '1.0', ...
                          'BackgroundColor', 'white', 'Callback', @updateParticles);
    p1ChargeEdit = uicontrol('Parent', p1Layout, 'Style', 'edit', 'String', '-1.0', ...
                            'BackgroundColor', 'white', 'Callback', @updateParticles);
    p1VelocityXEdit = uicontrol('Parent', p1Layout, 'Style', 'edit', 'String', '0.0', ...
                               'BackgroundColor', 'white', 'Callback', @updateParticles);
    p1VelocityYEdit = uicontrol('Parent', p1Layout, 'Style', 'edit', 'String', '0.0', ...
                               'BackgroundColor', 'white', 'Callback', @updateParticles);
    p1PositionXEdit = uicontrol('Parent', p1Layout, 'Style', 'edit', 'String', '-5.0', ...
                               'BackgroundColor', 'white', 'Callback', @updateParticles);
    p1PositionYEdit = uicontrol('Parent', p1Layout, 'Style', 'edit', 'String', '0.0', ...
                               'BackgroundColor', 'white', 'Callback', @updateParticles);

    % Ustawienia layoutu siatki
    set(p1Layout, 'ColumnSizes', [-1 -2], 'RowSizes', [-1 -1 -1 -1 -1 -1]);

    % --- PANEL CZĄSTKI 2 ---
    p2Layout = uiextras.Grid('Parent', particle2Panel, 'Spacing', 5, 'Padding', 5);

    % Etykiety
    uicontrol('Parent', p2Layout, 'Style', 'text', 'String', 'Masa:');
    uicontrol('Parent', p2Layout, 'Style', 'text', 'String', 'Ładunek:');
    uicontrol('Parent', p2Layout, 'Style', 'text', 'String', 'Prędkość X:');
    uicontrol('Parent', p2Layout, 'Style', 'text', 'String', 'Prędkość Y:');
    uicontrol('Parent', p2Layout, 'Style', 'text', 'String', 'Pozycja X:');
    uicontrol('Parent', p2Layout, 'Style', 'text', 'String', 'Pozycja Y:');

    % Pola edycji dla cząstki 2
    p2MassEdit = uicontrol('Parent', p2Layout, 'Style', 'edit', 'String', '2.0', ...
                          'BackgroundColor', 'white', 'Callback', @updateParticles);
    p2ChargeEdit = uicontrol('Parent', p2Layout, 'Style', 'edit', 'String', '-1.0', ...
                            'BackgroundColor', 'white', 'Callback', @updateParticles);
    p2VelocityXEdit = uicontrol('Parent', p2Layout, 'Style', 'edit', 'String', '0.0', ...
                               'BackgroundColor', 'white', 'Callback', @updateParticles);
    p2VelocityYEdit = uicontrol('Parent', p2Layout, 'Style', 'edit', 'String', '0.0', ...
                               'BackgroundColor', 'white', 'Callback', @updateParticles);
    p2PositionXEdit = uicontrol('Parent', p2Layout, 'Style', 'edit', 'String', '5.0', ...
                               'BackgroundColor', 'white', 'Callback', @updateParticles);
    p2PositionYEdit = uicontrol('Parent', p2Layout, 'Style', 'edit', 'String', '0.0', ...
                               'BackgroundColor', 'white', 'Callback', @updateParticles);

    % Ustawienia layoutu siatki
    set(p2Layout, 'ColumnSizes', [-1 -2], 'RowSizes', [-1 -1 -1 -1 -1 -1]);

    % --- PANEL PRZYCISKÓW KONTROLNYCH ---
    controlButtonsLayout = uiextras.HBox('Parent', controlButtonsPanel, 'Spacing', 10, 'Padding', 10);

    % Przyciski sterujące
    startButton = uicontrol('Parent', controlButtonsLayout, 'Style', 'pushbutton', ...
                           'String', 'Start', 'Callback', @startSimulation, ...
                           'BackgroundColor', colors.button);

    stopButton = uicontrol('Parent', controlButtonsLayout, 'Style', 'pushbutton', ...
                          'String', 'Stop', 'Callback', @stopSimulation, ...
                          'BackgroundColor', colors.button);

    resetButton = uicontrol('Parent', controlButtonsLayout, 'Style', 'pushbutton', ...
                           'String', 'Reset', 'Callback', @resetSimulation, ...
                           'BackgroundColor', colors.button);

    % Równe szerokości przycisków
    set(controlButtonsLayout, 'Sizes', [-1 -1 -1]);

    % --- PANEL INFORMACYJNY ---
    infoLayout = uiextras.Grid('Parent', infoPanel, 'Spacing', 5, 'Padding', 5);

    % Etykiety
    uicontrol('Parent', infoLayout, 'Style', 'text', 'String', 'Siła Coulomba:');
    uicontrol('Parent', infoLayout, 'Style', 'text', 'String', 'Energia kinetyczna 1:');
    uicontrol('Parent', infoLayout, 'Style', 'text', 'String', 'Energia kinetyczna 2:');
    uicontrol('Parent', infoLayout, 'Style', 'text', 'String', 'Pęd 1 [x,y]:');
    uicontrol('Parent', infoLayout, 'Style', 'text', 'String', 'Pęd 2 [x,y]:');
    uicontrol('Parent', infoLayout, 'Style', 'text', 'String', 'Czas symulacji:');

    % Pola wyświetlające dane
    forceText = uicontrol('Parent', infoLayout, 'Style', 'text', 'String', '0 N', ...
                         'BackgroundColor', 'white', 'HorizontalAlignment', 'left');
    energy1Text = uicontrol('Parent', infoLayout, 'Style', 'text', 'String', '0 J', ...
                          'BackgroundColor', 'white', 'HorizontalAlignment', 'left');
    energy2Text = uicontrol('Parent', infoLayout, 'Style', 'text', 'String', '0 J', ...
                          'BackgroundColor', 'white', 'HorizontalAlignment', 'left');
    momentum1Text = uicontrol('Parent', infoLayout, 'Style', 'text', 'String', '[0, 0]', ...
                            'BackgroundColor', 'white', 'HorizontalAlignment', 'left');
    momentum2Text = uicontrol('Parent', infoLayout, 'Style', 'text', 'String', '[0, 0]', ...
                            'BackgroundColor', 'white', 'HorizontalAlignment', 'left');
    timeText = uicontrol('Parent', infoLayout, 'Style', 'text', 'String', '0 s', ...
                        'BackgroundColor', 'white', 'HorizontalAlignment', 'left');

    % Ustawienia layoutu siatki
    set(infoLayout, 'ColumnSizes', [-1 -2], 'RowSizes', [-1 -1 -1 -1 -1 -1]);

    % --- ZMIENNE GLOBALNE dla funkcji ---
    simData = struct();
    simData.particle1 = createParticle(1.0, [-5, 0, 0], [0, 0, 0], 'p1', -1.0);
    simData.particle2 = createParticle(2.0, [5, 0, 0], [0, 0, 0], 'p2', -1.0);
    simData.isRunning = false;
    simData.timer = timer('ExecutionMode', 'fixedRate', 'Period', 0.05, ...
                         'TimerFcn', @updateSimulation);
    simData.time = 0;
    simData.dt = 0.05;
    simData.historyLength = 20;
    simData.p1History = zeros(simData.historyLength, 2);
    simData.p2History = zeros(simData.historyLength, 2);

    % Inicjalizacja grafiki cząstek
    simData.p1Handle = plot(simulationAxes, simData.particle1.position(1), simData.particle1.position(2), ...
                         'o', 'MarkerSize', 10*simData.particle1.mass, ...
                         'MarkerFaceColor', colors.particle1, 'MarkerEdgeColor', 'none');
    simData.p2Handle = plot(simulationAxes, simData.particle2.position(1), simData.particle2.position(2), ...
                         'o', 'MarkerSize', 10*simData.particle2.mass, ...
                         'MarkerFaceColor', colors.particle2, 'MarkerEdgeColor', 'none');

    % Inicjalizacja trajektorii
    simData.p1TrajectoryHandle = plot(simulationAxes, NaN, NaN, '-', 'Color', [0.8, 0.2, 0.2, 0.5], 'LineWidth', 1);
    simData.p2TrajectoryHandle = plot(simulationAxes, NaN, NaN, '-', 'Color', [0.2, 0.2, 0.8, 0.5], 'LineWidth', 1);

    % Inicjalizacja wektorów sił i prędkości
    simData.p1VelocityHandle = quiver(simulationAxes, simData.particle1.position(1), simData.particle1.position(2), ...
                                  0, 0, 'r', 'LineWidth', 1);
    simData.p2VelocityHandle = quiver(simulationAxes, simData.particle2.position(1), simData.particle2.position(2), ...
                                  0, 0, 'b', 'LineWidth', 1);
    simData.p1ForceHandle = quiver(simulationAxes, simData.particle1.position(1), simData.particle1.position(2), ...
                                0, 0, 'm', 'LineWidth', 1);
    simData.p2ForceHandle = quiver(simulationAxes, simData.particle2.position(1), simData.particle2.position(2), ...
                                0, 0, 'c', 'LineWidth', 1);

    % Ustawienie typu interakcji (przyciąganie/odpychanie)
    simData.interactionTextHandle = text(0, 9, '', 'FontSize', 12, 'HorizontalAlignment', 'center', ...
                                       'Parent', simulationAxes);

    % Wywołanie funkcji inicjalizującej pozycje cząstek
    updateParticles();

    % ===== FUNKCJE POMOCNICZE =====

    % Funkcja tworząca cząstkę
    function particle = createParticle(mass, position, velocity, type, charge)
        particle = struct();
        particle.mass = mass;
        particle.position = position;
        particle.velocity = velocity;
        particle.type = type;
        particle.charge = charge;
    end

    % Funkcja obliczająca siłę elektrostatyczną między cząstkami
    function [F_vec, F_mag] = calculateElectricForce(p1, p2)
        % Stała Coulomba
        k = 8.99e9; % N*m^2/C^2

        % Wektor od p1 do p2
        r_vec = p2.position(1:2) - p1.position(1:2);
        r_vec(3) = 0; % Ignorujemy wymiar Z
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
        F_mag = k * (p1.charge * p2.charge) / (r_mag^2);

        % Wektor siły: dodatni - przyciąganie, ujemny - odpychanie
        F_vec = F_mag * r_unit;
    end

    % Funkcja do aktualizacji parametrów cząstek z pól edycji
    function updateParticles(~, ~)
        % Odczytanie wartości z pól edycji
        try
            simData.particle1.mass = max(0.1, str2double(get(p1MassEdit, 'String')));
            simData.particle1.charge = str2double(get(p1ChargeEdit, 'String'));
            simData.particle1.velocity(1) = str2double(get(p1VelocityXEdit, 'String'));
            simData.particle1.velocity(2) = str2double(get(p1VelocityYEdit, 'String'));
            simData.particle1.position(1) = str2double(get(p1PositionXEdit, 'String'));
            simData.particle1.position(2) = str2double(get(p1PositionYEdit, 'String'));

            simData.particle2.mass = max(0.1, str2double(get(p2MassEdit, 'String')));
            simData.particle2.charge = str2double(get(p2ChargeEdit, 'String'));
            simData.particle2.velocity(1) = str2double(get(p2VelocityXEdit, 'String'));
            simData.particle2.velocity(2) = str2double(get(p2VelocityYEdit, 'String'));
            simData.particle2.position(1) = str2double(get(p2PositionXEdit, 'String'));
            simData.particle2.position(2) = str2double(get(p2PositionYEdit, 'String'));

            % Aktualizacja rozmiaru cząstek
            set(simData.p1Handle, 'MarkerSize', 10*simData.particle1.mass);
            set(simData.p2Handle, 'MarkerSize', 10*simData.particle2.mass);

            % Aktualizacja pozycji cząstek
            set(simData.p1Handle, 'XData', simData.particle1.position(1), ...
                                'YData', simData.particle1.position(2));
            set(simData.p2Handle, 'XData', simData.particle2.position(1), ...
                                'YData', simData.particle2.position(2));

            % Aktualizacja historii
            simData.p1History = zeros(simData.historyLength, 2);
            simData.p2History = zeros(simData.historyLength, 2);

            % Aktualizacja wektorów
            updateVelocityVectors();
            updateForceVectors();

            % Aktualizacja danych symulacji
            updateSimulationData();

            % Reset czasu symulacji
            simData.time = 0;
            set(timeText, 'String', sprintf('%.2f s', simData.time));

        catch
            errordlg('Podane wartości są nieprawidłowe!', 'Błąd');
        end
    end

    % Funkcja do aktualizacji wektorów prędkości
    function updateVelocityVectors()
        scale = 0.5; % Skala wizualizacji prędkości
        set(simData.p1VelocityHandle, 'XData', simData.particle1.position(1), ...
                                     'YData', simData.particle1.position(2), ...
                                     'UData', scale * simData.particle1.velocity(1), ...
                                     'VData', scale * simData.particle1.velocity(2));
        set(simData.p2VelocityHandle, 'XData', simData.particle2.position(1), ...
                                     'YData', simData.particle2.position(2), ...
                                     'UData', scale * simData.particle2.velocity(1), ...
                                     'VData', scale * simData.particle2.velocity(2));
    end

    % Funkcja do aktualizacji wektorów sił
    function updateForceVectors()
        % Obliczanie sił
        [F_2_on_1, F_mag] = calculateElectricForce(simData.particle1, simData.particle2);
        F_1_on_2 = -F_2_on_1; % Trzecia zasada dynamiki Newtona

        % Ustawienie skali wizualizacji sił
        scale = 0.01; % Skala do wizualizacji

        % Aktualizacja wektorów sił
        set(simData.p1ForceHandle, 'XData', simData.particle1.position(1), ...
                                 'YData', simData.particle1.position(2), ...
                                 'UData', scale * F_2_on_1(1), ...
                                 'VData', scale * F_2_on_1(2));
        set(simData.p2ForceHandle, 'XData', simData.particle2.position(1), ...
                                 'YData', simData.particle2.position(2), ...
                                 'UData', scale * F_1_on_2(1), ...
                                 'VData', scale * F_1_on_2(2));

        % Ustawienie typu interakcji
        if simData.particle1.charge * simData.particle2.charge > 0
            interaction_type = 'ODPYCHANIE';
            set(simData.interactionTextHandle, 'String', interaction_type, 'Color', 'red');
        elseif simData.particle1.charge * simData.particle2.charge < 0
            interaction_type = 'PRZYCIĄGANIE';
            set(simData.interactionTextHandle, 'String', interaction_type, 'Color', 'green');
        else
            interaction_type = 'BRAK INTERAKCJI';
            set(simData.interactionTextHandle, 'String', interaction_type, 'Color', 'black');
        end
    end

    % Funkcja do aktualizacji wyświetlanych danych symulacji
    function updateSimulationData()
        % Obliczanie sił
        [~, F_mag] = calculateElectricForce(simData.particle1, simData.particle2);

        % Obliczanie energii kinetycznych
        E1 = 0.5 * simData.particle1.mass * norm(simData.particle1.velocity)^2;
        E2 = 0.5 * simData.particle2.mass * norm(simData.particle2.velocity)^2;

        % Obliczanie pędów
        p1 = simData.particle1.mass * simData.particle1.velocity(1:2);
        p2 = simData.particle2.mass * simData.particle2.velocity(1:2);

        % Aktualizacja pól tekstowych
        set(forceText, 'String', sprintf('%.3e N', F_mag));
        set(energy1Text, 'String', sprintf('%.3e J', E1));
        set(energy2Text, 'String', sprintf('%.3e J', E2));
        set(momentum1Text, 'String', sprintf('[%.3f, %.3f]', p1(1), p1(2)));
        set(momentum2Text, 'String', sprintf('[%.3f, %.3f]', p2(1), p2(2)));
    end

    % Funkcja do uruchamiania symulacji
    function startSimulation(~, ~)
        if ~simData.isRunning
            simData.isRunning = true;
            start(simData.timer);
        end
    end

    % Funkcja do zatrzymywania symulacji
    function stopSimulation(~, ~)
        if simData.isRunning
            simData.isRunning = false;
            stop(simData.timer);
        end
    end

    % Funkcja do resetowania symulacji
    function resetSimulation(~, ~)
        stopSimulation();
        updateParticles();
        simData.time = 0;
        set(timeText, 'String', sprintf('%.2f s', simData.time));
    end

    % Funkcja aktualizująca symulację (wywoływana przez timer)
    function updateSimulation(~, ~)
        % Aktualizacja czasu
        simData.time = simData.time + simData.dt;
        set(timeText, 'String', sprintf('%.2f s', simData.time));

        % Obliczanie sił i przyspieszeń
        [F_2_on_1, ~] = calculateElectricForce(simData.particle1, simData.particle2);
        F_1_on_2 = -F_2_on_1; % Trzecia zasada dynamiki Newtona

        % Obliczanie przyspieszeń
        a1 = F_2_on_1(1:2) / simData.particle1.mass;
        a1(3) = 0; % Zerujemy składową Z
        a2 = F_1_on_2(1:2) / simData.particle2.mass;
        a2(3) = 0; % Zerujemy składową Z

        % Aktualizacja prędkości
        simData.particle1.velocity(1:2) = simData.particle1.velocity(1:2) + a1(1:2) * simData.dt;
        simData.particle2.velocity(1:2) = simData.particle2.velocity(1:2) + a2(1:2) * simData.dt;

        % Aktualizacja pozycji
        simData.particle1.position(1:2) = simData.particle1.position(1:2) + simData.particle1.velocity(1:2) * simData.dt;
        simData.particle2.position(1:2) = simData.particle2.position(1:2) + simData.particle2.velocity(1:2) * simData.dt;

        % Sprawdzanie odbicia od ścian (idealne sprężyste odbicie)
        xlim = get(simulationAxes, 'XLim');
        ylim = get(simulationAxes, 'YLim');

        % Odbicie cząstki 1 od ścian
        if simData.particle1.position(1) - simData.particle1.mass < xlim(1)
            simData.particle1.position(1) = xlim(1) + simData.particle1.mass;
            simData.particle1.velocity(1) = -simData.particle1.velocity(1);
        elseif simData.particle1.position(1) + simData.particle1.mass > xlim(2)
            simData.particle1.position(1) = xlim(2) - simData.particle1.mass;
            simData.particle1.velocity(1) = -simData.particle1.velocity(1);
        end

        if simData.particle1.position(2) - simData.particle1.mass < ylim(1)
            simData.particle1.position(2) = ylim(1) + simData.particle1.mass;
            simData.particle1.velocity(2) = -simData.particle1.velocity(2);
        elseif simData.particle1.position(2) + simData.particle1.mass > ylim(2)
            simData.particle1.position(2) = ylim(2) - simData.particle1.mass;
            simData.particle1.velocity(2) = -simData.particle1.velocity(2);
        end

        % Odbicie cząstki 2 od ścian
        if simData.particle2.position(1) - simData.particle2.mass < xlim(1)
            simData.particle2.position(1) = xlim(1) + simData.particle2.mass;
            simData.particle2.velocity(1) = -simData.particle2.velocity(1);
        elseif simData.particle2.position(1) + simData.particle2.mass > xlim(2)
            simData.particle2.position(1) = xlim(2) - simData.particle2.mass;
            simData.particle2.velocity(1) = -simData.particle2.velocity(1);
        end

        if simData.particle2.position(2) - simData.particle2.mass < ylim(1)
            simData.particle2.position(2) = ylim(1) + simData.particle2.mass;
            simData.particle2.velocity(2) = -simData.particle2.velocity(2);
        elseif simData.particle2.position(2) + simData.particle2.mass > ylim(2)
            simData.particle2.position(2) = ylim(2) - simData.particle2.mass;
            simData.particle2.velocity(2) = -simData.particle2.velocity(2);
        end

        % Sprawdzanie kolizji między cząstkami
        distance = norm(simData.particle1.position(1:2) - simData.particle2.position(1:2));
        collision_threshold = simData.particle1.mass + simData.particle2.mass;

        if distance <= collision_threshold
            % Obsługa kolizji - prosty model odbicia sprężystego
            % (w pełnej implementacji należałoby użyć bardziej zaawansowanego modelu)

            % Wektor łączący środki cząstek
            r_vec = simData.particle2.position(1:2) - simData.particle1.position(1:2);
            r_unit = r_vec / norm(r_vec);

            % Składowe prędkości wzdłuż kierunku zderzenia
            v1_proj = dot(simData.particle1.velocity(1:2), r_unit);
            v2_proj = dot(simData.particle2.velocity(1:2), r_unit);

            % Obliczenie nowych prędkości (wymiana pędów)
            m1 = simData.particle1.mass;
            m2 = simData.particle2.mass;

            v1_new = ((m1 - m2) * v1_proj + 2 * m2 * v2_proj) / (m1 + m2);
            v2_new = ((m2 - m1) * v2_proj + 2 * m1 * v1_proj) / (m1 + m2);

            % Aktualizacja składowych prędkości wzdłuż kierunku zderzenia
            simData.particle1.velocity(1:2) = simData.particle1.velocity(1:2) + (v1_new - v1_proj) * r_unit;
            simData.particle2.velocity(1:2) = simData.particle2.velocity(1:2) + (v2_new - v2_proj) * r_unit;

            % Odsunięcie cząstek, aby uniknąć "przyklejania"
            overlap = collision_threshold - distance;
            simData.particle1.position(1:2) = simData.particle1.position(1:2) - 0.5 * overlap * r_unit;
            simData.particle2.position(1:2) = simData.particle2.position(1:2) + 0.5 * overlap * r_unit;
        end

        % Aktualizacja pozycji cząstek na rysunku
        set(simData.p1Handle, 'XData', simData.particle1.position(1), ...
                            'YData', simData.particle1.position(2));
        set(simData.p2Handle, 'XData', simData.particle2.position(1), ...
                            'YData', simData.particle2.position(2));

        % Aktualizacja historii pozycji dla trajektorii
        simData.p1History = [simData.particle1.position(1:2); simData.p1History(1:end-1,:)];
        simData.p2History = [simData.particle2.position(1:2); simData.p2History(1:end-1,:)];

        % Aktualizacja trajektorii
        set(simData.p1TrajectoryHandle, 'XData', simData.p1History(:,1), 'YData', simData.p1History(:,2));
        set(simData.p2TrajectoryHandle, 'XData', simData.p2History(:,1), 'YData', simData.p2History(:,2));

        % Aktualizacja wektorów
        updateVelocityVectors();
        updateForceVectors();

        % Aktualizacja danych symulacji
        updateSimulationData();

        % Aktualizacja pól edycji (opcjonalne)
        set(p1VelocityXEdit, 'String', sprintf('%.2f', simData.particle1.velocity(1)));
        set(p1VelocityYEdit, 'String', sprintf('%.2f', simData.particle1.velocity(2)));
        set(p1PositionXEdit, 'String', sprintf('%.2f', simData.particle1.position(1)));
        set(p1PositionYEdit, 'String', sprintf('%.2f', simData.particle1.position(2)));

        set(p2VelocityXEdit, 'String', sprintf('%.2f', simData.particle2.velocity(1)));
        set(p2VelocityYEdit, 'String', sprintf('%.2f', simData.particle2.velocity(2)));
        set(p2PositionXEdit, 'String', sprintf('%.2f', simData.particle2.position(1)));
        set(p2PositionYEdit, 'String', sprintf('%.2f', simData.particle2.position(2)));

        drawnow;
    end

    % Funkcja do zamknięcia programu
    function exitProgram(~, ~)
        % Zatrzymanie timera, jeśli działa
        if simData.isRunning
            stop(simData.timer);
        end

        % Usunięcie timera
        delete(simData.timer);

        % Zamknięcie okna
        delete(gcf);
    end
end
