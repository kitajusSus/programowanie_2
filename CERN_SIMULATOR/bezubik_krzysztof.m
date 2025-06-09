function bezubik_krzysztof
    % Programowanie  - poprzednia nazwa to cern_simulator
    % Autor: 89219
    % Data: 2025-04-07
    %disp('program start');
    %graphics_toolbox = 'qt';
    % Tworzenie i konfiguracja głównego okna
    fig = figure('Name', 'Symulacja na programowanie', 'NumberTitle', 'off', ...
                'Position', [100, 100, 1300, 800], 'MenuBar', 'none', ...
                'Resize', 'on', 'CloseRequestFcn', @exitProgram);
    %disp('Figure created');
    % Definicja kolorów interfejsu
    colors.background = [0.95, 0.95, 0.95];
    colors.panel = [0.9, 0.9, 0.9];
    colors.button = [0.85, 0.85, 0.85];
    colors.particle1 = [0.8, 0.2, 0.2]; % czerwony
    colors.particle2 = [0.2, 0.2, 0.8]; % niebieski

    % Ustawienie tła głównego okna
    set(fig, 'Color', colors.background);

    % układ głównych paneli

    % Panel kontrolny (po lewej)
    controlPanel = uipanel('Parent', fig, ...
                         'Units', 'normalized', ...
                         'Position', [0.01, 0.01, 0.28, 0.98], ...
                         'Title', 'Panel kontrolny', ...
                         'BackgroundColor', colors.panel);
    %disp('controlPanel created');
    % Panel symulacji (po prawej)
    simulationPanel = uipanel('Parent', fig, ...
                            'Units', 'normalized', ...
                            'Position', [0.30, 0.01, 0.69, 0.98], ...
                            'Title', 'panel simulations ', ...
                            'BackgroundColor', colors.panel);
    %disp('simulationPanel created');
    % wykres symulacji
    simulationAxes = axes('Parent', simulationPanel, ...
                         'Units', 'normalized', ...
                         'Position', [0.05, 0.05, 0.9, 0.9], ...
                         'DataAspectRatio', [1 1 1], ...
                         'XLim', [-20, 20], 'YLim', [-20, 20], ...

                         'Box', 'on', 'XGrid', 'on', 'YGrid', 'on');
    title(simulationAxes, 'Symulacja ruchu cząstek na zajecia programowanie title');
    xlabel(simulationAxes, 'X');
    ylabel(simulationAxes, 'Y');
    disp('simulationAxes created');
    % Konfiguracja elementów panelu kontrolnego (dzielenie  na sekcje/podpanele)
    %disp('simulationAxes created');
    % Konfiguracja elementów panelu kontrolnego (dzielimy na sekcje)
    disp('simulationAxes created');
    % Konfiguracja elementów panelu kontrolnego (dzielenie  na sekcje/podpanele)
    % Panel cząstki 1
    p1Panel = uipanel('Parent', controlPanel, ...
                     'Units', 'normalized', ...
                     'Position', [0.05, 0.79, 0.9, 0.2], ...
                     'Title', 'Cząstka 1 (czerwona)', ...
                     'BackgroundColor', colors.panel);
    %disp('p1Panel created');
    % Panel cząstki 2
    p2Panel = uipanel('Parent', controlPanel, ...
                     'Units', 'normalized', ...
                     'Position', [0.05, 0.60, 0.9, 0.2], ...
                     'Title', 'Cząstka 2 (niebieska)', ...
                     'BackgroundColor', colors.panel);
    %disp('p2Panel created');
    % Panel przycisków sterujących
    controlButtonsPanel = uipanel('Parent', controlPanel, ...
                                'Units', 'normalized', ...
                                'Position', [0.05, 0.42, 0.9, 0.14], ...
                                'Title', 'Sterowanie', ...
                                'BackgroundColor', colors.panel);

    % Panel informacyjny
    infoPanel = uipanel('Parent', controlPanel, ...
                       'Units', 'normalized', ...
                       'Position', [0.05, 0.01, 0.95, 0.36], ...
                       'Title', 'Dane symulacji', ...
                       'BackgroundColor', colors.panel);

    %  MODYFIKOWNIE PARTICLE1
    %  p1Panel

    % Etykiety i pola cząstki 1
    % Masa
    uicontrol('Parent', p1Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.8, 0.3, 0.15], ...
             'String', 'Masa:');
    p1MassEdit = uicontrol('Parent', p1Panel, 'Style', 'edit', ...
                          'Units', 'normalized', ...
                          'Position', [0.4, 0.8, 0.5, 0.15], ...
                          'String', '1.0', ...
                          'BackgroundColor', 'white', ...
                          'Callback', @updateParticles);
    % Ładunek
    uicontrol('Parent', p1Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.65, 0.3, 0.15], ...
             'String', 'Ładunek:');
    p1ChargeEdit = uicontrol('Parent', p1Panel, 'Style', 'edit', ...
                            'Units', 'normalized', ...
                            'Position', [0.4, 0.65, 0.5, 0.15], ...
                            'String', '0.0001', ...
                            'BackgroundColor', 'white', ...
                            'Callback', @updateParticles);
  % Prędkość X
    uicontrol('Parent', p1Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.5, 0.3, 0.15], ...
             'String', 'Prędkość X:');
    p1VelocityXEdit = uicontrol('Parent', p1Panel, 'Style', 'edit', ...
                               'Units', 'normalized', ...
                               'Position', [0.4, 0.5, 0.5, 0.15], ...
                               'String', '0.0', ...
                               'BackgroundColor', 'white', ...
                               'Callback', @updateParticles);

  % Prędkość Y
    uicontrol('Parent', p1Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.35, 0.3, 0.15], ...
             'String', 'Prędkość Y:');
    p1VelocityYEdit = uicontrol('Parent', p1Panel,
                               'Style', 'edit', ...
                               'Units', 'normalized', ...
                               'Position', [0.4, 0.35, 0.5, 0.15], ...
                               'String', '1.0', ...
                               'BackgroundColor', 'white', ...
                               'Callback', @updateParticles);

    % Pozycja X
    uicontrol('Parent', p1Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.2, 0.3, 0.15], ...
             'String', 'Pozycja X:');
    p1PositionXEdit = uicontrol('Parent', p1Panel,
                               'Style', 'edit', ...
                               'Units', 'normalized', ...
                               'Position', [0.4, 0.2, 0.5, 0.15], ...
                               'String', '-15.0', ...
                               'BackgroundColor', 'white', ...
                               'Callback', @updateParticles);

    % Pozycja Y
    uicontrol('Parent', p1Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.05, 0.3, 0.15], ...
             'String', 'Pozycja Y:');
    p1PositionYEdit = uicontrol('Parent', p1Panel,
                               'Style', 'edit', ...
                               'Units', 'normalized', ...
                               'Position', [0.4, 0.05, 0.5, 0.15], ...
                               'String', '0.0', ...
                               'BackgroundColor', 'white', ...
                               'Callback', @updateParticles);

    % MODYFI KOWANIE PARTICLE2
    % Etykiety i pola cząstki 2

    % Masa
    uicontrol('Parent', p2Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.8, 0.3, 0.15], ...
             'String', 'Masa:');
    p2MassEdit = uicontrol('Parent', p2Panel, 'Style', 'edit', ...
                          'Units', 'normalized', ...
                          'Position', [0.4, 0.8, 0.5, 0.15], ...
                          'String', '1.2', ...
                          'BackgroundColor', 'white', ...
                          'Callback', @updateParticles);

    % Ładunek
    uicontrol('Parent', p2Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.65, 0.3, 0.15], ...
             'String', 'Ładunek:');
    p2ChargeEdit = uicontrol('Parent', p2Panel, 'Style', 'edit', ...
                            'Units', 'normalized', ...
                            'Position', [0.4, 0.65, 0.5, 0.15], ...
                            'String', '0.0001', ...
                            'BackgroundColor', 'white', ...
                            'Callback', @updateParticles);

    % Prędkość X
    uicontrol('Parent', p2Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.5, 0.3, 0.15], ...
             'String', 'Prędkość X:');
    p2VelocityXEdit = uicontrol('Parent', p2Panel, 'Style', 'edit', ...
                               'Units', 'normalized', ...
                               'Position', [0.4, 0.5, 0.5, 0.15], ...
                               'String', '0.0', ...
                               'BackgroundColor', 'white', ...
                               'Callback', @updateParticles);

    % Prędkość Y
    uicontrol('Parent', p2Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.35, 0.3, 0.15], ...
             'String', 'Prędkość Y:');
    p2VelocityYEdit = uicontrol('Parent', p2Panel, 'Style', 'edit', ...
                               'Units', 'normalized', ...
                               'Position', [0.4, 0.35, 0.5, 0.15], ...
                               'String', '0.0', ...
                               'BackgroundColor', 'white', ...
                               'Callback', @updateParticles);

    % Pozycja X
    uicontrol('Parent', p2Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.2, 0.3, 0.15], ...
             'String', 'Pozycja X:');
    p2PositionXEdit = uicontrol('Parent', p2Panel, 'Style', 'edit', ...
                               'Units', 'normalized', ...
                               'Position', [0.4, 0.2, 0.5, 0.15], ...
                               'String', '5.0', ...
                               'BackgroundColor', 'white', ...
                               'Callback', @updateParticles);

    % Pozycja Y
    uicontrol('Parent', p2Panel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.05, 0.3, 0.15], ...
             'String', 'Pozycja Y:');
    p2PositionYEdit = uicontrol('Parent', p2Panel, 'Style', 'edit', ...
                               'Units', 'normalized', ...
                               'Position', [0.4, 0.05, 0.5, 0.15], ...
                               'String', '0.0', ...
                               'BackgroundColor', 'white', ...
                               'Callback', @updateParticles);

    % --- PANEL PRZYCISKÓW KONTROLNYCH ---

    % Przycisk Start
    startButton = uicontrol('Parent', controlButtonsPanel, ...
                           'Style', 'pushbutton', ...
                           'Units', 'normalized', ...
                           'Position', [0.05, 0.60, 0.25, 0.30], ...
                           'String', 'Start', ...
                           'Callback', @startSimulation, ...
                           'BackgroundColor', colors.button);

    % Przycisk Stop
    stopButton = uicontrol('Parent', controlButtonsPanel, ...
                          'Style', 'pushbutton', ...
                          'Units', 'normalized', ...
                          'Position', [0.375, 0.60, 0.25, 0.30], ...
                          'String', 'Stop', ...
                          'Callback', @stopSimulation, ...
                          'BackgroundColor', colors.button);

    % Przycisk Reset
    resetButton = uicontrol('Parent', controlButtonsPanel, ...
                           'Style', 'pushbutton', ...
                           'Units', 'normalized', ...
                           'Position', [0.7, 0.60, 0.25, 0.30], ...
                           'String', 'Reset', ...
                           'Callback', @resetSimulation, ...
                           'BackgroundColor', colors.button);
    %PRZYCISK RYSOWANIE WYKRESU:
    wykresy = uicontrol('Parent', controlButtonsPanel, ...
                           'Style', 'pushbutton', ...
                           'Units', 'normalized', ...
                           'Position', [0.7, 0.10, 0.25, 0.30], ...
                           'String', 'Wykresy', ...
                           'Callback', @dodaj_wykresy, ...
                           'BackgroundColor', colors.button);
    % --- PANEL INFORMACYJNY ---

    % Siła Coulomba
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.87, 0.35, 0.08], ...
             'HorizontalAlignment', 'left', ...
             'String', 'Siła Coulomba:');
    forceText = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                         'Units', 'normalized', ...
                         'Position', [0.45, 0.87, 0.5, 0.08], ...
                         'String', '0 N', ...
                         'HorizontalAlignment', 'left', ...
                         'BackgroundColor', 'white');

    % Energia kinetyczna cząstki 1
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.78, 0.35, 0.08], ...
             'HorizontalAlignment', 'left', ...
             'String', 'E_kinetyczna 1:');
    energy1Text = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                          'Units', 'normalized', ...
                          'Position', [0.45, 0.78, 0.5, 0.08], ...
                          'String', '0 J', ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', 'white');

    % Energia kinetyczna cząstki 2
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.67, 0.35, 0.08], ...
             'HorizontalAlignment', 'left', ...
             'String', 'E_kinetyczna 2:');
    energy2Text = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                          'Units', 'normalized', ...
                          'Position', [0.45, 0.67, 0.5, 0.08], ...
                          'String', '0 J', ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', 'white');

    % Pęd cząstki 1
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.55, 0.35, 0.08], ...
             'HorizontalAlignment', 'left', ...
             'String', 'Pęd 1 [x,y]:');
    momentum1Text = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                            'Units', 'normalized', ...
                            'Position', [0.45, 0.55, 0.5, 0.08], ...
                            'String', '[0, 0]', ...
                            'HorizontalAlignment', 'left', ...
                            'BackgroundColor', 'white');

    % Pęd cząstki 2
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.43, 0.35, 0.08], ...
             'HorizontalAlignment', 'left', ...
             'String', 'Pęd 2 [x,y]:');
    momentum2Text = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                            'Units', 'normalized', ...
                            'Position', [0.45, 0.43, 0.5, 0.08], ...
                            'String', '[0, 0]', ...
                            'HorizontalAlignment', 'left', ...
                            'BackgroundColor', 'white');

    % NOWE: Energia potencjalna układu
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.30, 0.35, 0.08], ...
             'HorizontalAlignment', 'left', ...
             'String', 'E_potencjalna:');
    energy_potencjalna = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                          'Units', 'normalized', ...
                          'Position', [0.45, 0.30, 0.5, 0.08], ...
                          'String', '0 J', ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', 'white');

    % Czas symulacji (przesunięty w dół)
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.20, 0.35, 0.08], ...
             'HorizontalAlignment', 'left', ...
             'String', 'Czas symulacji:');
    timeText = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                        'Units', 'normalized', ...
                        'Position', [0.45, 0.20, 0.5, 0.08], ...
                        'String', '0 s', ...
                        'HorizontalAlignment', 'left', ...
                        'BackgroundColor', 'white');
    % SUMA OBU ENERGII (teraz energia całkowita układu, przesunięta w dół)
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.1, 0.35, 0.08], ...
             'HorizontalAlignment', 'left', ...
             'String', 'E_całk. ukladu:'); % Zmieniono etykietę
    energySuma = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                          'Units', 'normalized', ...
                          'Position', [0.44, 0.1, 0.5, 0.08], ...
                          'String', '0 J', ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', 'white');
    % --- ZMIENNE GLOBALNE dla funkcji TWORZENIE STRUKTÓR DANYCH DLA OBU PARTICLES---
    simData = struct();
    % Inicjalizacja pól struktury simData, które będą używane w wielu funkcjach
    simData.particle1 = createParticle(1.0, [0,0,0], [0,0,0], 'p1', 0); % Wartości zostaną zaktualizowane z GUI
    simData.particle2 = createParticle(1.0, [0,0,0], [0,0,0], 'p2', 0); % Wartości zostaną zaktualizowane z GUI
    simData.isRunning = false;
    simData.time = 0;
    simData.dt = 0.05;
    simData.historyLength = 25;% pokazuje 20 ostatnich dt jako ślad za kulką
    simData.p1History = zeros(simData.historyLength, 2);
    simData.p2History = zeros(simData.historyLength, 2);

    simData.maxPlotHistory = 500; % Maksymalna długość historii wykresu

    % Inicjalizacja pustych tablic historii dla wykresów
    simData.czasHistory = [];
    simData.historyTotalEnergy = [];
    simData.historyE1 = [];
    simData.historyE2 = [];
    simData.historyF_mag = [];
    simData.historyPredkosc1 = [];
    simData.historyPredkosc2 = [];
    simData.historyDistance = [];
    simData.historyPot = []; % NOWE: Historia energii potencjalnej

    % Inicjalizacja grafiki cząstek
    hold(simulationAxes, 'on');

    % Dodanie cząstek
    simData.p1Handle = plot(simulationAxes, simData.particle1.position(1), simData.particle1.position(2), ...
                         'o', 'MarkerSize', 10*simData.particle1.mass, ...
                         'MarkerFaceColor', colors.particle1, 'MarkerEdgeColor', 'none');
    simData.p2Handle = plot(simulationAxes, simData.particle2.position(1), simData.particle2.position(2), ...
                         'o', 'MarkerSize', 10*simData.particle2.mass, ...
                         'MarkerFaceColor', colors.particle2, 'MarkerEdgeColor', 'none');

    % Inicjalizacja trajektorii
    simData.p1TrajectoryHandle = plot(simulationAxes, NaN, NaN, 'r', 'LineWidth', 1);
    simData.p2TrajectoryHandle = plot(simulationAxes, NaN, NaN, 'b', 'LineWidth', 1);

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

    hold(simulationAxes, 'off');

    % Wywołanie funkcji inicjalizującej pozycje cząstek na podstawie wartości z GUI
    % Upewni się, że początkowe wartości w strukturze simData są zgodne z GUI
    updateParticles();

    % ===== FUNKCJE POMOCNICZE =====

    % Wartości domyślne dla resetowania (zgodne z początkowymi wartościami w GUI)
    defaultP1Mass = '1.0';
    defaultP1Charge = '0.0001';
    defaultP1VelX = '0.0';
    defaultP1VelY = '1.0';
    defaultP1PosX = '-15.0';
    defaultP1PosY = '0.0';

    defaultP2Mass = '2';
    defaultP2Charge = '0.0001';
    defaultP2VelX = '0.0';
    defaultP2VelY = '0.0';
    defaultP2PosX = '5.0';
    defaultP2PosY = '0.0';

    % Funkcja do resetowania symulacji
    function resetSimulation(~, ~)
        stopSimulation();

        % Ustawianie pól GUI na wartości domyślne
        set(p1MassEdit, 'String', defaultP1Mass);
        set(p1ChargeEdit, 'String', defaultP1Charge);
        set(p1VelocityXEdit, 'String', defaultP1VelX);
        set(p1VelocityYEdit, 'String', defaultP1VelY);
        set(p1PositionXEdit, 'String', defaultP1PosX);
        set(p1PositionYEdit, 'String', defaultP1PosY);

        set(p2MassEdit, 'String', defaultP2Mass);
        set(p2ChargeEdit, 'String', defaultP2Charge);
        set(p2VelocityXEdit, 'String', defaultP2VelX);
        set(p2VelocityYEdit, 'String', defaultP2VelY);
        set(p2PositionXEdit, 'String', defaultP2PosX);
        set(p2PositionYEdit, 'String', defaultP2PosY);

        % Reset czasu symulacji
        simData.time = 0;
        set(timeText, 'String', sprintf('%.2f s', simData.time));

        % Czyszczenie historii wykresów
        simData.czasHistory = [];
        simData.historyTotalEnergy = [];
        simData.historyE1 = [];
        simData.historyE2 = [];
        simData.historyF_mag = [];
        simData.historyPredkosc1 = [];
        simData.historyPredkosc2 = [];
        simData.historyDistance = [];
        simData.historyPot = [];

        % Wywołanie updateParticles, które odczyta dane z GUI i odświeży wszystko
        updateParticles();
    end

    % Funkcja tworząca cząstkę
    function particle = createParticle(mass, position, velocity, rodzaj, charge)
        particle = struct();
        particle.mass = mass;
        particle.position = position;
        particle.velocity = velocity;
        particle.type = rodzaj;
        particle.charge = charge;
    end

    % Funkcja obliczająca siłę elektrostatyczną między cząstkami
    function [F_vec, F_mag] = calcCoulomb(p1, p2)
        % Stała Coulomba
        k = 8.99e9; % N*m^2/C^2
        simData.k = k; % Zapisuje stałą Coulomba w simData dla użycia w energii potencjalnej

        % Wektor od p1 do p2
        r_vec = p2.position(1:2) - p1.position(1:2);
        simData.r_vec = r_vec; % Przechowuje wektor pozycji dla obliczeń energii potencjalnej

        % Dodaje trzecią składową jeśli jej nie ma
        if length(r_vec) < 3
            r_vec(3) = 0;
        end
        r_mag = norm(r_vec);

        % Unika dzielenia przez zero
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
        F_vec = -F_mag * r_unit;

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

            % Aktualizacja historii trajektorii (wypełniamy aktualną pozycją)
            simData.p1History = ones(simData.historyLength, 1) * simData.particle1.position(1:2);
            simData.p2History = ones(simData.historyLength, 1) * simData.particle2.position(1:2);

            % Aktualizacja trajektorii
            set(simData.p1TrajectoryHandle, 'XData', NaN, 'YData', NaN);
            set(simData.p2TrajectoryHandle, 'XData', NaN, 'YData', NaN);

            % Aktualizacja wektorów
            updateVelocityVectors();
            updateForceVectors(); % Wektor siły również wymaga aktualizacji

            % Aktualizacja danych symulacji (co również aktualizuje wykresy)
            updateSimulationData();
        catch
            errordlg('Podane wartości są nieprawidłowe!', 'Błąd');
        end
    end

    % Funkcja do aktualizacji wektorów prędkości
    function updateVelocityVectors()
        scale = 1; % Skala wizualizacji prędkości jak duzy jest wektor.
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
        [F_2_on_1, F_mag] = calcCoulomb(simData.particle1, simData.particle2);
        F_1_on_2 = -F_2_on_1; % Trzecia zasada dynamiki Newtona

        % Ustawienie skali wizualizacji sił
        scale = 0.1; % Skala do wizualizacji - dostosowana, aby wektory nie zasłaniały widoku

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
            typ_oddzialowania = 'ODPYCHANIE';
            set(simData.interactionTextHandle, 'String', typ_oddzialowania, 'Color', 'red');
        elseif simData.particle1.charge * simData.particle2.charge < 0
            typ_oddzialowania = 'PRZYCIĄGANIE';
            set(simData.interactionTextHandle, 'String', typ_oddzialowania, 'Color', 'green');
        else
            typ_oddzialowania = 'BRAK INTERAKCJI';
            set(simData.interactionTextHandle, 'String', typ_oddzialowania, 'Color', 'black');
        end
    end

    % Funkcja do aktualizacji wyświetlanych danych symulacji
    function updateSimulationData()
        % Obliczanie sił
        [~, F_mag] = calcCoulomb(simData.particle1, simData.particle2);

        % Obliczanie energii kinetycznych
        E1 = 0.5 * simData.particle1.mass * norm(simData.particle1.velocity)^2;
        E2 = 0.5 * simData.particle2.mass * norm(simData.particle2.velocity)^2;

        % Obliczanie energii potencjalnej (tylko raz, jest to energia układu)
        r_mag = norm(simData.r_vec);
        % Instrukcja diagnostyczna sprawdzająca typ simData przed użyciem simData.k
        %disp(['Debug: Typ simData przed Pot_elect: ', class(simData)]);
        if ~isstruct(simData)
          % Wykryto, że simData nie jest strukturą. Wyrzuca błąd i informację diagnostyczną.
          error('SKIBIDI! simData jest skalarem, a powiNIEN byc struktura! około linijki 360 jest zdefiniowana simData = struct().. trzeba od tego momentu przesledzic');
        end

        if r_mag > 1e-10 % Unika dzielenia przez zero w mianowniku energii potencjalnej
            Pot_elect = simData.k * (simData.particle1.charge * simData.particle2.charge) / r_mag;
        else
            Pot_elect = 0; % Ustawia na 0, gdy cząstki są w tej samej pozycji, aby uniknąć nieskończoności
        end

        % Energia całkowita (kinetyczna + potencjalna)
        totalEnergy = E1 + E2 + Pot_elect;

        % Obliczanie pędów
        p1 = simData.particle1.mass * simData.particle1.velocity(1:2);
        p2 = simData.particle2.mass * simData.particle2.velocity(1:2);

        % Aktualizacja pól tekstowych
        set(forceText, 'String', sprintf('%.3e N', F_mag));
        simData.F_mag = F_mag; % Przechowuje dla wykresów

        set(energy1Text, 'String', sprintf('%.3e J', E1));
        simData.E1 = E1; % Przechowuje dla wykresów

        set(energy2Text, 'String', sprintf('%.3e J', E2));
        simData.E2 = E2; % Przechowuje dla wykresów

        set(energy_potencjalna, 'String', sprintf('%.3e J', Pot_elect)); % NOWE: Ustawia tekst energii potencjalnej
        simData.Potencjalna = Pot_elect; % Przechowuje dla wykresów

        set(energySuma, 'String', sprintf('%.3e J', totalEnergy));
        simData.totalEnergy = totalEnergy; % Przechowuje dla wykresów

        set(momentum1Text, 'String', sprintf('[%.3f, %.3f]', p1(1), p1(2)));
        set(momentum2Text, 'String', sprintf('[%.3f, %.3f]', p2(1), p2(2)));

        % Aktualizuje wykresy, jeśli są zainicjalizowane
        if isfield(simData, 'wykres_osieL_handle') && ishandle(simData.wykres_osieL_handle)
          edycjaWykres();
        end
    end

    function dodaj_wykresy(~,~)
        % Ustawienie pozycji panelu symulacji, aby zrobić miejsce na wykresy
        positionsInfo = get(simulationPanel, 'Position');
        set(simulationPanel, 'Position', [positionsInfo(1), 0.32, positionsInfo(3), 0.70]);
        % Dostosowanie DataAspectRatio osi symulacji, jeśli to konieczne
        % set(simulationAxes, 'DataAspectRatio', [2 3 1]); % zakomentowane, aby nie zmieniać proporcji

        % Panel na wykresy
        wykresPanel = uipanel('Parent', fig, ...
                          'Units', 'normalized',...
                          'Position', [0.30, 0.01, 0.69, 0.30], ...
                          'Title', 'Panel wykresów', ...
                          'BackgroundColor', colors.panel);

        % Panel opcji wykresów (popup menu)
        wykresOpcjePanel = uipanel('Parent', wykresPanel, ...
                               'Units', 'normalized', ...
                               'Position', [0.01, 0.01, 0.15, 0.95]);

        % Osie dla lewego wykresu
        wykres_osie_lewy = axes('Parent', wykresPanel, ...
                          'Units', 'normalized', ...
                          'Position', [0.20, 0.11, 0.35, 0.80],...
                          'Box', 'on', 'XGrid', 'on', 'YGrid', 'on');

        % Osie dla prawego wykresu
        wykres_osie_prawy = axes('Parent', wykresPanel, ...
                           'Units', 'normalized', ...
                           'Position', [0.60, 0.11, 0.35, 0.80],...
                           'Box', 'on', 'XGrid', 'on', 'YGrid', 'on');

        simData.wykres_osieL_handle = wykres_osie_lewy;
        simData.wykres_osieP_handle = wykres_osie_prawy;

        % --- Inicjalizacja uchwytów/handle linii dla wykresów ---
        % Te uchwyty będą aktualizowane, a nie tworzone od nowa
        % Lewy wykres
        hold(simData.wykres_osieL_handle, 'on');
        simData.plotLineL_single = plot(simData.wykres_osieL_handle, NaN, NaN, 'b-', 'LineWidth', 2, 'DisplayName', 'Wybrana zmienna');
        simData.plotLineL_E1 = plot(simData.wykres_osieL_handle, NaN, NaN, 'r', 'LineWidth', 1, 'DisplayName', 'E_kin 1');
        simData.plotLineL_E2 = plot(simData.wykres_osieL_handle, NaN, NaN, 'g', 'LineWidth', 1, 'DisplayName', 'E_kin 2');
        simData.plotLineL_pot = plot(simData.wykres_osieL_handle, NaN, NaN, 'm', 'LineWidth', 1, 'DisplayName', 'E_pot.'); % linia dla energii potencjalnej
        simData.plotLineL_ETotal = plot(simData.wykres_osieL_handle, NaN, NaN, 'k', 'LineWidth', 2, 'DisplayName', 'E_całk.');
        hold(simData.wykres_osieL_handle, 'off');

        %legend(simData.wykres_osieL_handle, 'Location', 'northeast');

        % Prawy wykres
        hold(simData.wykres_osieP_handle, 'on');
        simData.plotLineP_single = plot(simData.wykres_osieP_handle, NaN, NaN, 'b-', 'LineWidth', 2, 'DisplayName', 'Wybrana zmienna');
        simData.plotLineP_E1 = plot(simData.wykres_osieP_handle, NaN, NaN, 'r', 'LineWidth', 1, 'DisplayName', 'E_kin 1');
        simData.plotLineP_E2 = plot(simData.wykres_osieP_handle, NaN, NaN, 'g', 'LineWidth', 1, 'DisplayName', 'E_kin 2');
        simData.plotLineP_pot = plot(simData.wykres_osieP_handle, NaN, NaN, 'm', 'LineWidth', 1, 'DisplayName', 'E_pot.'); %linia dla energii potencjalnej
        simData.plotLineP_ETotal = plot(simData.wykres_osieP_handle, NaN, NaN, 'k-', 'LineWidth', 2, 'DisplayName', 'E_całk.');
        hold(simData.wykres_osieP_handle, 'off');
        legend(simData.wykres_osieP_handle, 'Location', 'northeast');

        % Opcje do wyboru na wykresach
        opcje_do_wyboru = {
          'Czas',             'time';
          'Energia Całk. ',   'totalEnergy';
          'Energia kin cz. 1',    'E1';
          'Energia kin cz. 2',    'E2';
          'Siła Coulomba',    'F_mag';
          'Pręd. 1',          'predkosc1';
          'Pręd. 2',          'predkosc2';
          'Odległość',        'distance';
          'Pełny wykres energii', 'allEnergies';
          'Energia potencjalna ukladu', 'Potencjalna';
        };

        plotNazwy = opcje_do_wyboru(:, 1);
        plotZmienne = opcje_do_wyboru(:, 2);
        simData.plotNazwy = plotNazwy;
        simData.plotZmienne = plotZmienne;

        % LEWY WYKRES - menu rozwijane
        uicontrol('Parent', wykresOpcjePanel, 'Style', 'text', ...
             'Units', 'normalized', 'Position', [0.05, 0.85, 0.95, 0.15], ...
             'String', 'Lewy wykres', 'HorizontalAlignment', 'left');

        jedenWykresPopup = uicontrol('Parent', wykresOpcjePanel, 'Style', 'popupmenu', ...
                              'Units', 'normalized', 'Position', [0.05, 0.60, 0.95, 0.15], ...
                              'String', plotNazwy,
                              'Value', find(strcmp(plotZmienne, 'E1')), ... % Domyślnie 'Energia cz. 1'
                              'Callback', @edycjaWykres, ...
                              'BackgroundColor', 'white');

        % PRAWY WYKRES - menu rozwijane
        uicontrol('Parent', wykresOpcjePanel, 'Style', 'text', ...
             'Units', 'normalized', 'Position', [0.05, 0.27, 0.95, 0.15], ...
             'String', 'Prawy wykres: ', 'HorizontalAlignment', 'left');

        dwaWykresPopup = uicontrol('Parent', wykresOpcjePanel, 'Style', 'popupmenu', ...
                            'Units', 'normalized', 'Position', [0.05, 0.07, 0.95, 0.20], ...
                            'String', plotNazwy,
                            'Value', find(strcmp(plotZmienne, 'E2')), ... % Domyślnie 'Energia cz. 2'
                            'Callback', @edycjaWykres, ...
                            'BackgroundColor', 'white');

        simData.wykres_jeden = jedenWykresPopup;
        simData.wykres_dwa = dwaWykresPopup;

        % Wywołaj edycjaWykres, aby zainicjować wykresy początkowymi danymi
        edycjaWykres();
    end

    % Funkcja do edytowania wykresu i sprawdzania co nowego, dodawanie i zmienianie wykresu + edycja osi ()
    function edycjaWykres(~,~)
        % Sprawdza, czy uchwyty osi wykresów istnieją (czyli czy panel wykresów został otwarty)
        if ~isfield(simData, 'wykres_osieL_handle') || ~ishandle(simData.wykres_osieL_handle)
            return; % Wykresy nie są zainicjalizowane, kończy działanie funkcji
        end

        % Pobiera indeksy wybranych zmiennych z list rozwijanych
        lewyWykresID = get(simData.wykres_jeden, 'Value');
        prawyWykresID = get(simData.wykres_dwa, 'Value');

        % Pobiera odpowiadające nazwy zmiennych
        lewyZmienna = simData.plotZmienne{lewyWykresID};
        prawyZmienna = simData.plotZmienne{prawyWykresID};

        % --- Aktualizacja lewego wykresu ---
        axes(simData.wykres_osieL_handle); % Ustawia aktywną oś dla lewego wykresu
        xlabel('Czas [s]');
        grid on;

        % Ukrywa wszystkie linie początkowo na lewym wykresie
        set([simData.plotLineL_single, simData.plotLineL_E1, simData.plotLineL_E2, simData.plotLineL_pot, simData.plotLineL_ETotal], 'Visible', 'off');

        if strcmp(lewyZmienna, 'allEnergies')
            title('Wykres: Wszystkie Energie');
            ylabel('Energia [J]');
            % Ustawia dane i pokazuje linie dla wszystkich energii
            set(simData.plotLineL_E1, 'XData', simData.czasHistory, 'YData', simData.historyE1, 'Visible', 'on');
            set(simData.plotLineL_E2, 'XData', simData.czasHistory, 'YData', simData.historyE2, 'Visible', 'on');
            set(simData.plotLineL_pot, 'XData', simData.czasHistory, 'YData', simData.historyPot, 'Visible', 'on'); % NOWE: ustawia energię potencjalną
            set(simData.plotLineL_ETotal, 'XData', simData.czasHistory, 'YData', simData.historyTotalEnergy, 'Visible', 'on');

            % Dane do automatycznego skalowania osi Y
            allYDataL = [simData.historyE1(:); simData.historyE2(:); simData.historyPot(:); simData.historyTotalEnergy(:)];
        else
            title(['Wykres: ', simData.plotNazwy{lewyWykresID}]);
            ylabel(simData.plotNazwy{lewyWykresID});
            % Określa, którą historię danych użyć dla pojedynczego wykresu
            switch lewyZmienna
                case 'time'
                    plotDataL = simData.czasHistory;
                case 'totalEnergy'
                    plotDataL = simData.historyTotalEnergy;
                case 'E1'
                    plotDataL = simData.historyE1;
                case 'E2'
                    plotDataL = simData.historyE2;
                case 'F_mag'
                    plotDataL = simData.historyF_mag;
                case 'predkosc1'
                    plotDataL = simData.historyPredkosc1;
                case 'predkosc2'
                    plotDataL = simData.historyPredkosc2;
                case 'distance'
                    plotDataL = simData.historyDistance;
                case 'Potencjalna'
                    plotDataL = simData.historyPot;
                otherwise
                    plotDataL = [];
            end
            % Ustawia dane i pokazuje linię dla wybranej zmiennej
            set(simData.plotLineL_single, 'XData', simData.czasHistory, 'YData', plotDataL, 'Visible', 'on');

            % Dane do automatycznego skalowania osi Y
            allYDataL = plotDataL(:);
        end

        % Automatyczne skalowanie osi Y dla lewego wykresu
        if ~isempty(allYDataL) && ~all(isnan(allYDataL)) % Upewnia się, że dane nie są puste ani same NaN
            minY = min(allYDataL);
            maxY = max(allYDataL);
            yMargin = (maxY - minY) * 0.1; % 10% margines
            if yMargin == 0
                yMargin = 0.1 * abs(minY);
                if yMargin == 0
                    yMargin = 0.1;
                end
            end
            set(simData.wykres_osieL_handle, 'YLim', [minY - yMargin, maxY + yMargin]);
        else % Jeśli danych brak, resetuje oś Y do domyślnego stanu
            set(simData.wykres_osieL_handle, 'YLimMode', 'auto');
        end


        % --- Aktualizacja prawego wykresu ---
        axes(simData.wykres_osieP_handle); % Ustawia aktywną oś dla prawego wykresu
        xlabel('Czas [s]');
        grid on;

        % Ukrywa wszystkie linie początkowo na prawym wykresie
        set([simData.plotLineP_single, simData.plotLineP_E1, simData.plotLineP_E2, simData.plotLineP_pot, simData.plotLineP_ETotal], 'Visible', 'off'); % NOWE: dodano plotLineP_pot

        if strcmp(prawyZmienna, 'allEnergies')
            title('Wykres: Wszystkie Energie');
            ylabel('Energia [J]');
            % Ustawia dane i pokazuje linie dla wszystkich energii
            set(simData.plotLineP_E1, 'XData', simData.czasHistory, 'YData', simData.historyE1, 'Visible', 'on');
            set(simData.plotLineP_E2, 'XData', simData.czasHistory, 'YData', simData.historyE2, 'Visible', 'on');
            set(simData.plotLineP_pot, 'XData', simData.czasHistory, 'YData', simData.historyPot, 'Visible', 'on'); % NOWE: ustawia energię potencjalną
            set(simData.plotLineP_ETotal, 'XData', simData.czasHistory, 'YData', simData.historyTotalEnergy, 'Visible', 'on');

            % Dane do automatycznego skalowania osi Y
            allYDataP = [simData.historyE1(:); simData.historyE2(:); simData.historyPot(:); simData.historyTotalEnergy(:)];
        else
            title(['Wykres: ', simData.plotNazwy{prawyWykresID}]);
            ylabel(simData.plotNazwy{prawyWykresID});
            % Określa, którą historię danych użyć dla pojedynczego wykresu
            switch prawyZmienna
                case 'time'
                    plotDataP = simData.czasHistory;
                case 'totalEnergy'
                    plotDataP = simData.historyTotalEnergy;
                case 'E1'
                    plotDataP = simData.historyE1;
                case 'E2'
                    plotDataP = simData.historyE2;
                case 'F_mag'
                    plotDataP = simData.historyF_mag;
                case 'predkosc1'
                    plotDataP = simData.historyPredkosc1;
                case 'predkosc2'
                    plotDataP = simData.historyPredkosc2;
                case 'distance'
                    plotDataP = simData.historyDistance;
                case 'Potencjalna'
                    plotDataP = simData.historyPot;
                otherwise
                    plotDataP = [];
            end
            % Ustawia dane i pokazuje linię dla wybranej zmiennej
            set(simData.plotLineP_single, 'XData', simData.czasHistory, 'YData', plotDataP, 'Visible', 'on');

            % Dane do automatycznego skalowania osi Y
            allYDataP = plotDataP(:);
        end

        % Automatyczne skalowanie osi Y dla prawego wykresu
        if ~isempty(allYDataP) && ~all(isnan(allYDataP))
            minY = min(allYDataP);
            maxY = max(allYDataP);
            yMargin = (maxY - minY) * 0.1; % 10% margines
            if yMargin == 0
                yMargin = 0.1 * abs(minY);
                if yMargin == 0
                    yMargin = 0.1; % Domyślny margines
                end
            end
            set(simData.wykres_osieP_handle, 'YLim', [minY - yMargin, maxY + yMargin]);
        else % Jeśli danych brak, resetuje oś Y do domyślnego stanu
            set(simData.wykres_osieP_handle, 'YLimMode', 'auto');
        end


        axes(simulationAxes);
    end

    % Funkcja do uruchamiania symulacji
    function startSimulation(~, ~)
        if ~simData.isRunning
            simData.isRunning = true;
            % Uruchamia pętlę symulacji
            timerLoop();
        end
    end

    % Funkcja do zatrzymywania symulacji
    function stopSimulation(~, ~)
        simData.isRunning = false;
    end

    % Pętla symulująca timer
    function timerLoop()
        while simData.isRunning
            updateSimulation();
            % Odświeża GUI
            drawnow();
            pause(0.02); % Czas pauzy,ok 50fps
        end
    end

    % Funkcja aktualizująca symulację
    function updateSimulation()
        % Aktualizacja czasu
        simData.time = simData.time + simData.dt;
        set(timeText, 'String', sprintf('%.2f s', simData.time));

        % Obliczanie sił i przyspieszeń
        [F_2_on_1, ~] = calcCoulomb(simData.particle1, simData.particle2);
        F_1_on_2 = -F_2_on_1; % Trzecia zasada dynamiki Newtona

        % Obliczanie przyspieszeń
        a1 = F_2_on_1(1:2) / simData.particle1.mass;
        if length(a1) < 3
            a1(3) = 0;
        end

        a2 = F_1_on_2(1:2) / simData.particle2.mass;
        if length(a2) < 3
            a2(3) = 0;
        end

        % Aktualizacja prędkości
        simData.particle1.velocity(1:2) = simData.particle1.velocity(1:2) + a1(1:2) * simData.dt;
        simData.particle2.velocity(1:2) = simData.particle2.velocity(1:2) + a2(1:2) * simData.dt;

        % Aktualizacja pozycji
        simData.particle1.position(1:2) = simData.particle1.position(1:2) + simData.particle1.velocity(1:2) * simData.dt;
        simData.particle2.position(1:2) = simData.particle2.position(1:2) + simData.particle2.velocity(1:2) * simData.dt;

        % Sprawdzanie odbicia od ścian (idealne sprężyste odbicie)
        xlim = get(simulationAxes, 'XLim'); % Pobiera granice osi X
        ylim = get(simulationAxes, 'YLim'); % Pobiera granice osi Y

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
        % Używa rzeczywistego rozmiaru cząstki do określenia warunku kolizji. Zakłada, że MarkerSize = 10 * mass,
        % więc promień cząstki jest w przybliżeniu równy jej masie podzielonej przez 2 (0.5 * MarkerSize / 10 = 0.5 * mass).
        kolizja_gdy = (simData.particle1.mass + simData.particle2.mass) * 0.5;

         % Realizuje zderzenia
        if distance <= kolizja_gdy

            % Wektor łączący środki cząstek
            r_vec_collision = simData.particle2.position(1:2) - simData.particle1.position(1:2);
            r_unit_collision = r_vec_collision / norm(r_vec_collision);

            % Składowe prędkości wzdłuż kierunku zderzenia
            v1_proj = dot(simData.particle1.velocity(1:2), r_unit_collision);
            v2_proj = dot(simData.particle2.velocity(1:2), r_unit_collision);

            % Oblicza nowe prędkości (wymiana pędów dla idealnie sprężystego zderzenia 2D)
            m1 = simData.particle1.mass;
            m2 = simData.particle2.mass;

            v1_new = ((m1 - m2) * v1_proj + 2 * m2 * v2_proj) / (m1 + m2);
            v2_new = ((m2 - m1) * v2_proj + 2 * m1 * v1_proj) / (m1 + m2);

            % Aktualizuje składowe prędkości prostopadłe do kierunku zderzenia
            v1_perp = simData.particle1.velocity(1:2) - v1_proj * r_unit_collision;
            v2_perp = simData.particle2.velocity(1:2) - v2_proj * r_unit_collision;

            % Oblicza nowe całkowite prędkości
            simData.particle1.velocity(1:2) = v1_new * r_unit_collision + v1_perp;
            simData.particle2.velocity(1:2) = v2_new * r_unit_collision + v2_perp;

            % Odsuwa cząstki, aby uniknąć "przyklejania" po kolizji
            overlap = kolizja_gdy - distance;
            simData.particle1.position(1:2) = simData.particle1.position(1:2) - 0.5 * overlap * r_unit_collision;
            simData.particle2.position(1:2) = simData.particle2.position(1:2) + 0.5 * overlap * r_unit_collision;
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

        % Dodaje aktualne dane do historii wykresów
        simData.czasHistory(end+1) = simData.time;
        simData.historyTotalEnergy(end+1) = simData.totalEnergy;
        simData.historyE1(end+1) = simData.E1;
        simData.historyE2(end+1) = simData.E2;
        simData.historyF_mag(end+1) = simData.F_mag;
        simData.historyPredkosc1(end+1) = norm(simData.particle1.velocity(1:2));
        simData.historyPredkosc2(end+1) = norm(simData.particle2.velocity(1:2));
        simData.historyDistance(end+1) = distance; % Aktualna odległość
        simData.historyPot(end+1) = simData.Potencjalna; % NOWE: Dodaje energię potencjalną do historii

        % Ogranicza rozmiar tablic historii (dla wydajności)
        if length(simData.czasHistory) > simData.maxPlotHistory
            startIndex = length(simData.czasHistory) - simData.maxPlotHistory + 1;
            simData.czasHistory = simData.czasHistory(startIndex:end);
            simData.historyTotalEnergy = simData.historyTotalEnergy(startIndex:end);
            simData.historyE1 = simData.historyE1(startIndex:end);
            simData.historyE2 = simData.historyE2(startIndex:end);
            simData.historyF_mag = simData.historyF_mag(startIndex:end);
            simData.historyPredkosc1 = simData.historyPredkosc1(startIndex:end);
            simData.historyPredkosc2 = simData.historyPredkosc2(startIndex:end);
            simData.historyDistance = simData.historyDistance(startIndex:end);
            simData.historyPot = simData.historyPot(startIndex:end); % NOWE: ogranicza historię energii potencjalnej
        end

        % Aktualizacja danych symulacji (co również aktualizuje wykresy)
        updateSimulationData();

        % Aktualizacja pól edycji (dla wartości zmieniających się dynamicznie)
        set(p1VelocityXEdit, 'String', sprintf('%.2f', simData.particle1.velocity(1)));
        set(p1VelocityYEdit, 'String', sprintf('%.2f', simData.particle1.velocity(2)));
        set(p1PositionXEdit, 'String', sprintf('%.2f', simData.particle1.position(1)));
        set(p1PositionYEdit, 'String', sprintf('%.2f', simData.particle1.position(2)));

        set(p2VelocityXEdit, 'String', sprintf('%.2f', simData.particle2.velocity(1)));
        set(p2VelocityYEdit, 'String', sprintf('%.2f', simData.particle2.velocity(2)));
        set(p2PositionXEdit, 'String', sprintf('%.2f', simData.particle2.position(1)));
        set(p2PositionYEdit, 'String', sprintf('%.2f', simData.particle2.position(2)));
    end

    % Funkcja do zamknięcia programu
    function exitProgram(~, ~)
        % Zatrzymanie symulacji, jeśli działa
        if simData.isRunning
            simData.isRunning = false;
        end
        delete(gcf);
    end
end
