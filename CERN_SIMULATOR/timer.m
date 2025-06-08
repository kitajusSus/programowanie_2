
% który emuluje działanie timera za pomocą pause i drawnow

function timer(callback_func, period)
    % callback_func - funkcja wywoływana co period sekund
    % period - czas w sekundach między wywołaniami

    % Tworzymy niewidoczną figurę do przechowywania stanu
    fig = figure('Visible', 'off');

    % Dodajemy kontrolki do zarządzania stanem
    timer_running = uicontrol('Style', 'text', 'String', 'true', ...
                            'Visible', 'off', 'Parent', fig, ...
                            'Tag', 'timer_running');

    % Funkcja start
    function startTimer()
        set(timer_running, 'String', 'true');
        timerLoop();
    end

    % Funkcja stop
    function stopTimer()
        set(timer_running, 'String', 'false');
    end

    % Funkcja zwracająca czy timer działa
    function status = isRunning()
        status = strcmp(get(timer_running, 'String'), 'true');
    end

    % Główna pętla timera
    function timerLoop()
        while isRunning()
            try
                % Wywołanie funkcji callback
                callback_func();

                % Odświeżenie GUI
                drawnow;

                % Pauza na zadany czas
                pause(period);
            catch e
                % Obsługa błędów
                disp(['Błąd w timerLoop: ' e.message]);
                stopTimer();
                break;
            end
        end
    end

    % Zwrócenie struktury z interfejsem przypominającym timer
    timer_obj = struct('start', @startTimer, ...
                      'stop', @stopTimer, ...
                      'isRunning', @isRunning, ...
                      'Period', period, ...
                      'fig', fig);
end
