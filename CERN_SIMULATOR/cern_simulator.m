function cern_simulator
    % Programowanie skibdi - poprzednia nazwa to cern simulator bo zderzenia cząstek ale działa jako skibdi simulatok
    % Autor: kb89219
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
    %disp('simulationAxes created');
    % Konfiguracja elementów panelu kontrolnego (dzielimy na sekcje)
    % Panel cząstki 1
    p1Panel = uipanel('Parent', controlPanel, ...
                     'Units', 'normalized', ...
                     'Position', [0.05, 0.76, 0.9, 0.2], ...
                     'Title', 'Cząstka 1 (czerwona)', ...
                     'BackgroundColor', colors.panel);
    %disp('p1Panel created');
    % Panel cząstki 2
    p2Panel = uipanel('Parent', controlPanel, ...
                     'Units', 'normalized', ...
                     'Position', [0.05, 0.54, 0.9, 0.2], ...
                     'Title', 'Cząstka 2 (niebieska)', ...
                     'BackgroundColor', colors.panel);
    %disp('p2Panel created');
    % Panel przycisków sterujących
    controlButtonsPanel = uipanel('Parent', controlPanel, ...
                                'Units', 'normalized', ...
                                'Position', [0.05, 0.38, 0.9, 0.15], ...
                                'Title', 'Sterowanie', ...
                                'BackgroundColor', colors.panel);

    % Panel informacyjny
    infoPanel = uipanel('Parent', controlPanel, ...
                       'Units', 'normalized', ...
                       'Position', [0.05, 0.05, 0.9, 0.3], ...
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
             'Position', [0.05, 0.85, 0.35, 0.12], ...
             'HorizontalAlignment', 'left', ...
             'String', 'Siła Coulomba:');
    forceText = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                         'Units', 'normalized', ...
                         'Position', [0.45, 0.85, 0.5, 0.12], ...
                         'String', '0 N', ...
                         'HorizontalAlignment', 'left', ...
                         'BackgroundColor', 'white');

    % Energia kinetyczna cząstki 1
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.71, 0.35, 0.12], ...
             'HorizontalAlignment', 'left', ...
             'String', 'E_kinetyczna 1:');
    energy1Text = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                          'Units', 'normalized', ...
                          'Position', [0.45, 0.71, 0.5, 0.12], ...
                          'String', '0 J', ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', 'white');

    % Energia kinetyczna cząstki 2
% zwykły blok tekstu
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.57, 0.35, 0.12], ...
             'HorizontalAlignment', 'left', ...
             'String', 'E_kinetyczna 2:');
    energy2Text = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                          'Units', 'normalized', ...
                          'Position', [0.45, 0.57, 0.5, 0.12], ...
                          'String', '0 J', ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', 'white');

    % Pęd cząstki 1
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.43, 0.35, 0.12], ...
             'HorizontalAlignment', 'left', ...
             'String', 'Pęd 1 [x,y]:');
    momentum1Text = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                            'Units', 'normalized', ...
                            'Position', [0.45, 0.43, 0.5, 0.12], ...
                            'String', '[0, 0]', ...
                            'HorizontalAlignment', 'left', ...
                            'BackgroundColor', 'white');

    % Pęd cząstki 2
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.29, 0.35, 0.12], ...
             'HorizontalAlignment', 'left', ...
             'String', 'Pęd 2 [x,y]:');
    momentum2Text = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                            'Units', 'normalized', ...
                            'Position', [0.45, 0.29, 0.5, 0.12], ...
                            'String', '[0, 0]', ...
                            'HorizontalAlignment', 'left', ...
                            'BackgroundColor', 'white');

    % Czas symulacji
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.15, 0.35, 0.12], ...
             'HorizontalAlignment', 'left', ...
             'String', 'Czas symulacji:');
    timeText = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                        'Units', 'normalized', ...
                        'Position', [0.45, 0.15, 0.5, 0.12], ...
                        'String', '0 s', ...
                        'HorizontalAlignment', 'left', ...
                        'BackgroundColor', 'white');
    % SUMA OBU ENERGII (SPRAWDZANIE CZY ZACHODZI ZASADA ZACHOWANIA ENERGII)
    uicontrol('Parent', infoPanel, 'Style', 'text', ...
             'Units', 'normalized', ...
             'Position', [0.05, 0.02, 0.35, 0.12], ...
             'HorizontalAlignment', 'left', ...
             'String', 'E_kin SUMA:');
    energySuma = uicontrol('Parent', infoPanel, 'Style', 'text', ...
                          'Units', 'normalized', ...
                          'Position', [0.44, 0.02, 0.5, 0.12], ...
                          'String', '0 J', ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', 'white');
    % --- ZMIENNE GLOBALNE dla funkcji TWORZENIE STRUKTÓR DANYCH DLA OBU PARTICLES---
    simData = struct();
    simData.particle1 = createParticle(1.0, [-0.0001, 0, 0], [0, 0, 0], 'p1', 0.0000000001);
    simData.particle2 = createParticle(2.0, [0.0002, 0, 0], [0, 0, 0], 'p2', -0.000000002);
    simData.isRunning = false;
    simData.time = 0;
    simData.dt = 0.1; #czas
    simData.historyLength = 25;% pokazuje 20 ostatnich dt jako ślad za kulką
    simData.p1History = zeros(simData.historyLength, 2);
    simData.p2History = zeros(simData.historyLength, 2);
%  puste elementy struktury simData do robienia wykresów
    simData.wykres_osieLewy = [];       % Uchwyt do osi wykresu (jeśli istnieje)
    simData.wykres_osiePrawy = [];
    simData.plotXVarID = '';        % oś X
    simData.plotYVarID = '';        % zmiennej Y
    simData.plotLewyHistory = [];      % Historia Lewego wykresu
    simData.plotPrawyHistory = [];      % Prawy wykres
    simData.maxPlotHistory = 500;   % Maksymalna długość historii wykresu
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
    simData.p1TrajectoryHandle = plot(simulationAxes, NaN, NaN, 'r-', 'LineWidth', 1);
    simData.p2TrajectoryHandle = plot(simulationAxes, NaN, NaN, 'b-', 'LineWidth', 1);

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

    % Wywołanie funkcji inicjalizującej pozycje cząstek
    updateParticles();

    % ===== FUNKCJE POMOCNICZE =====


    % Funkcja do resetowania symulacji
    function resetSimulation(~, ~)
        stopSimulation();
        updateParticles();
        simData.time = 0;
        set(timeText, 'String', sprintf('%.2f s', simData.time));

        if isfield(simData, 'czasHistory')
        % czyszczenie historii wykresow
          simData.czasHistory = [];
          simData.plotLewyHistory = [];
          simData.plotPrawyHistory = [];
        end
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
        simData.k = k;

        % Wektor od p1 do p2
        r_vec = p2.position(1:2) - p1.position(1:2);
        simData.r_vec = r_vec;
        % Dodajemy trzecią składową jeśli jej nie ma
        if length(r_vec) < 3
            r_vec(3) = 0;
        end
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
        F_vec = -F_mag * r_unit;

    end
% dzięki Bogu istnieje copilot który zrobi za mnie mozolne pisanie, troche było do zmiany
%te str2double ale generalnie polecam
    % Funkcja do aktualizacji parametrów cząstek z pól edycji
    function updateParticles(~, ~)
        % Odczytanie wartości z pól edycji
        % octave odbiera te rzeczy jako string, a ja ich potrzebuje jako floaty, a przez to że używam w testach f32 co najmniej, to bedzie robic str2double
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

            % Aktualizacja historii (wypełniamy aktualną pozycją)
            simData.p1History = repmat(simData.particle1.position(1:2), simData.historyLength, 1);
            simData.p2History = repmat(simData.particle2.position(1:2), simData.historyLength, 1);

            % Aktualizacja trajektorii
            set(simData.p1TrajectoryHandle, 'XData', NaN, 'YData', NaN);
            set(simData.p2TrajectoryHandle, 'XData', NaN, 'YData', NaN);
            % Aktualizacja wektorów
            updateVelocityVectors();
            % Aktualizacja danych symulacji
            updateSimulationData();
            % Reset czasu symulacji
            simData.time = 0;
            set(timeText, 'String', sprintf('%.2f s', simData.time));
            % Odśwież wykresy
            if isfield(simData, 'wykres_osieL_handle') && ishandle(simData.wykres_osieL_handle)
                edycjaWykres();
            end
        catch
            errordlg('Podane wartości są nieprawidłowe!', 'Błąd');
        end
    end

    % Funkcja do aktualizacji wektorów prędkości
    function updateVelocityVectors()
        scale = 1; % Skala wizualizacji prędkości jak duzy jest wektor.
        % używany w testach jak potrzebuje wiedzieć czy kierunek jest dobry lub czy rośnie a w wypadku
        %gdy predkosc sie robi bliska światłu to potrzebuje znać kierunek i to czy rośnie lub  się różnią od siebie. temu mozna ustawić skale
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
        scale = 1; % Skala do wizualizacji

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
        % obliczanie energii potencjalnych
        Pot1 = -simData.k * simData.particle1.charge / norm(simData.r_vec);
        Pot2 = -simData.k * simData.particle2.charge / norm(simData.r_vec);
        % Obliczanie pędów
        p1 = simData.particle1.mass * simData.particle1.velocity(1:2);
        p2 = simData.particle2.mass * simData.particle2.velocity(1:2);

        totalEnergy = E1+E2+Pot1+Pot2; # suma energi kinetycznych obu
        #kq/r DODAC POTENCJALNA ENERGIE DO ENEHGI CALKOWITEJ
        % Aktualizacja pól tekstowych
        set(forceText, 'String', sprintf('%.3e N', F_mag));
        simData.F_mag = F_mag;
        set(energy1Text, 'String', sprintf('%.3e J', E1));
        simData.E1 = E1;
        set(energy2Text, 'String', sprintf('%.3e J', E2));
        simData.E2 = E2;
        set(energySuma, 'String', sprintf('%.3e J', totalEnergy));
        simData.totalEnergy = totalEnergy;
        set(momentum1Text, 'String', sprintf('[%.3f, %.3f]', p1(1), p1(2)));
        set(momentum2Text, 'String', sprintf('[%.3f, %.3f]', p2(1), p2(2)));

        if isfield(simData, 'wykres_osieL_handle') && ishandle(simData.wykres_osieL_handle)
          edycjaWykres();
        end
    end

  function dodaj_wykresy(~,~)
  %disp("dodawanie wykresów i robienie miejsca");
    positionsInfo = get(simulationPanel, 'Position');
    set(simulationPanel, 'Position', [positionsInfo(1), 0.32, positionsInfo(3), 0.70]);
    wielkoscSymulacji = get(simulationAxes, 'DataAspectRatio');
    set(simulationAxes, 'DataAspectRatio', [2 3 1]);

    wykresPanel = uipanel('Parent', fig, ...
                      'Units', 'normalized',...
                      'Position', [0.30, 0.01, 0.69, 0.30], ...
                      'Title', 'wykresy panel', ...
                      'BackgroundColor', colors.panel);

    wykresOpcjePanel = uipanel('Parent', wykresPanel, ...
                           'Units', 'normalized', ...
                           'Position', [0.01, 0.01, 0.15, 0.95]
                           );

    % WAŻNA ZMIANA: Poprawione pozycje wykresów, żeby się nie nakładały
    wykres_osie_lewy = axes('Parent', wykresPanel, ...
                      'Units', 'normalized', ...
                      'Position', [0.20, 0.11, 0.30, 0.80],...  % szerokość 0.30
                      'Box', 'on', 'XGrid', 'on', 'YGrid', 'on');

    wykres_osie_prawy = axes('Parent', wykresPanel, ...
                       'Units', 'normalized', ...
                       'Position', [0.55, 0.11, 0.30, 0.80],...  % zaczyna się na 0.55
                       'Box', 'on', 'XGrid', 'on', 'YGrid', 'on');

    simData.wykres_osieL_handle = wykres_osie_lewy;
    simData.wykres_osieP_handle = wykres_osie_prawy;

  % dodawanie przycisków do definiowania co jest na której osi.
      opcje_do_wyboru = {
        'Czas',             'time';
        'Energia Całk. ',    'totalEnergy';
        'Energia kin cz. 1',    'E1';
        'Energia kin cz. 2',    'E2';
        'SiłaCoulomba',     'F_mag';
        'Pręd. 1',          'predkosc1';
        'Pręd. 2',          'predkosc2';
        'Odległość',        'distance'
      };

      plotNazwy = opcje_do_wyboru(:, 1);
      plotZmienne = opcje_do_wyboru(:, 2);
      simData.plotNazwy = plotNazwy;
      simData.plotZmienne = plotZmienne;

    %LEWY WYKRES
      uicontrol('Parent', wykresOpcjePanel, 'Style', 'text', ...
           'Units', 'normalized', 'Position', [0.05, 0.85, 0.95, 0.15], ...
           'String', 'Lewy wykres', 'HorizontalAlignment', 'left');

      jedenWykresPopup = uicontrol('Parent', wykresOpcjePanel, 'Style', 'popupmenu', ...
                            'Units', 'normalized', 'Position', [0.05, 0.60, 0.95, 0.15], ...
                            'String', plotNazwy,
                            'Value', 3, ... % Domyślnie 'Energia cz. 1'
                            'Callback', @edycjaWykres, ...
                            'BackgroundColor', 'white');

    % PRAWY WYKRES
      uicontrol('Parent', wykresOpcjePanel, 'Style', 'text', ...
           'Units', 'normalized', 'Position', [0.05, 0.27, 0.95, 0.15], ...
           'String', 'Prawy wykres: ', 'HorizontalAlignment', 'left');

      dwaWykresPopup = uicontrol('Parent', wykresOpcjePanel, 'Style', 'popupmenu', ...
                          'Units', 'normalized', 'Position', [0.05, 0.07, 0.95, 0.20], ...
                          'String', plotNazwy,
                          'Value', 4, ... % Domyślnie 'Energia cz. 2'
                          'Callback', @edycjaWykres, ...
                          'BackgroundColor', 'white');

      simData.wykres_jeden = jedenWykresPopup;
      title(simData.wykres_osieL_handle, 'Lewy wykres');
      xlabel(simData.wykres_osieL_handle, 'Czas [s]');

        simData.wykres_dwa = dwaWykresPopup;
        title(simData.wykres_osieP_handle, 'Prawy wykres');
        xlabel(simData.wykres_osieP_handle, 'Czas [s]');

        % Inicjalizuj tablice historii przy pierwszym uruchomieniu
        simData.czasHistory = [];
        simData.plotLewyHistory = [];
        simData.plotPrawyHistory = [];

        % Wywołaj edycjaWykres, aby zainicjować wykresy
        edycjaWykres();
    end
            %% funkcja do edyutowania wykresu i sprawdzania co nowego, dodawanie i zmienianie wykresu + edycja osi ()
    function edycjaWykres(~,~)
        % Pobierz indeksy wybranych zmiennych z list rozwijanych
      lewyWykresID = get(simData.wykres_jeden, 'Value');
      prawyWykresID = get(simData.wykres_dwa, 'Value');

      % Pobierz odpowiadające nazwy zmiennych
      lewyZmienna = simData.plotZmienne{lewyWykresID};
      prawyZmienna = simData.plotZmienne{prawyWykresID};


      ylabel(simData.wykres_osieL_handle, simData.plotNazwy{lewyWykresID});
      ylabel(simData.wykres_osieP_handle, simData.plotNazwy{prawyWykresID});

      % Inicjalizacja tablic historii jeśli jeszcze nie istnieją
      if ~isfield(simData, 'czasHistory') || isempty(simData.czasHistory)
        simData.czasHistory = simData.time;
        simData.plotLewyHistory = 0;
        simData.plotPrawyHistory = 0;
      end

      % Pobierz aktualną wartość dla lewego wykresu
    switch lewyZmienna
        case 'time'
          lewyValue = simData.time;
        case 'totalEnergy'
          lewyValue = simData.totalEnergy;
        case 'E1'
          lewyValue = simData.E1;
        case 'E2'
          lewyValue = simData.E2;
        case 'F_mag'
          lewyValue = simData.F_mag;
        case 'predkosc1'
          lewyValue = norm(simData.particle1.velocity(1:2));
        case 'predkosc2'
          lewyValue = norm(simData.particle2.velocity(1:2));
        case 'distance'
          lewyValue = norm(simData.particle1.position(1:2) - simData.particle2.position(1:2));
        otherwise
          lewyValue = 0;
      end

  % Pobierz aktualną wartość dla prawego wykresu
      switch prawyZmienna
        case 'time'
          prawyValue = simData.time;
        case 'totalEnergy'
          prawyValue = simData.totalEnergy;
        case 'E1'
          prawyValue = simData.E1;
        case 'E2'
          prawyValue = simData.E2;
        case 'F_mag'
          prawyValue = simData.F_mag;
        case 'predkosc1'
          prawyValue = norm(simData.particle1.velocity(1:2));
        case 'predkosc2'
          prawyValue = norm(simData.particle2.velocity(1:2));
        case 'distance'
          prawyValue = norm(simData.particle1.position(1:2) - simData.particle2.position(1:2));
        otherwise
          prawyValue = 0;
      end

  % Aktualizuj historię wykresu tylko jeśli symulacja jest uruchomiona
    %  lub gdy tablica historii ma tylko jeden element (inicjalizacja)
      if simData.isRunning || length(simData.czasHistory) <= 1
        simData.czasHistory(end+1) = simData.time;
        simData.plotLewyHistory(end+1) = lewyValue;
        simData.plotPrawyHistory(end+1) = prawyValue;
      end

      % Ogranicz rozmiar tablic historii (dla wydajności)
      if length(simData.czasHistory) > simData.maxPlotHistory
        simData.czasHistory = simData.czasHistory(end-simData.maxPlotHistory+1:end);
        simData.plotLewyHistory = simData.plotLewyHistory(end-simData.maxPlotHistory+1:end);
        simData.plotPrawyHistory = simData.plotPrawyHistory(end-simData.maxPlotHistory+1:end);
      end

  % KLUCZOWA ZMIANA: Wyraźne ustawienie aktywnej osi przed rysowaniem
  % Narysuj lewy wykres
      axes(simData.wykres_osieL_handle); % Ustawienie aktywnej osi
      #cla; % Wyczyszczenie aktualnej osi
      plot(simData.czasHistory, simData.plotLewyHistory, 'b-', 'LineWidth', 2);
      grid on;
      title(['Wykres: ', simData.plotNazwy{lewyWykresID}]);
      xlabel('Czas [s]');
      ylabel(simData.plotNazwy{lewyWykresID});

      % Narysuj prawy wykres
      axes(simData.wykres_osieP_handle); % Ustawienie aktywnej osi
      #cla; % Wyczyszczenie aktualnej osi
      plot(simData.czasHistory, simData.plotPrawyHistory, 'r-', 'LineWidth', 2);
      grid on;
      title(['Wykres: ', simData.plotNazwy{prawyWykresID}]);
      xlabel('Czas [s]');
      ylabel(simData.plotNazwy{prawyWykresID});

      % Przywróć aktywną oś symulacji, aby nie zakłócać głównego rysunku
      axes(simulationAxes);
    end

    % Funkcja do uruchamiania symulacji
    function startSimulation(~, ~)
        if ~simData.isRunning
            simData.isRunning = true;
            % Uruchamiamy pętlę symulacji
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
            % Odświeżenie GUI
            drawnow();
            pause(0.001); # PAUZA PAUZA TUTAJ SZUKASZ
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
        xlim = get(simulationAxes, 'XLim'); %granica osi x
        ylim = get(simulationAxes, 'YLim'); %granica osi y

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
        kolizja_gdy = (simData.particle1.mass + simData.particle2.mass)/2;

         %zderzenia
        if distance <= kolizja_gdy

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
            overlap = kolizja_gdy - distance;
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

        % Aktualizacja pól edycji
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
