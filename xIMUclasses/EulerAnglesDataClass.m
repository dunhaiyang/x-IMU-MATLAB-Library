classdef EulerAnglesDataClass < DataBaseClass

    %% Public 'read-only' properties

    properties (SetAccess = private)
        Phi = [];
        Theta = [];
        Psi = [];
    end

    %% Public 'read-only' properties

    properties (SetAccess = private)
        FileNameAppendage = '_EulerAngles.csv';
    end

    %% Public methods

    methods (Access = public)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSV(strcat(fileNamePrefix, obj.FileNameAppendage), 2);
            obj.Phi = data(:,1);
            obj.Theta = data(:,2);
            obj.Psi = data(:,3);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function fig = Plot(obj)
            if(obj.NumSamples == 0)
                error('No data to plot.');
            else
                
                % Create time vector and units if SampleRate known
                if(isempty(obj.Time))
                    time = 1:obj.NumSamples;
                    xLabel = 'Sample';
                else
                    time = obj.Time;
                    xLabel = 'Time (s)';
                end

                % Plot data
                fig =  figure('Number', 'off', 'Name', 'EulerAngles');
                hold on;
                plot(time, obj.Phi, 'r');
                plot(time, obj.Theta, 'g');
                plot(time, obj.Psi, 'b');
                title('Euler angles');
                xlabel(xLabel);
                ylabel('Angle (^\circ)');
                legend('\phi', '\theta', '\psi');
                hold off;
            end
        end
    end

end

%% End of class