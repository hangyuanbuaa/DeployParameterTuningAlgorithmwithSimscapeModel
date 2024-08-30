function batchEstimation(dataFilePath)
% Assume there are three equipments in the fleet
% Data files are stored in the same folder defined as dataFilePath
% This function calls a parameter estimation function for each equipment
% And distribute the compution to serveral workers using parfor using 
% Parallel Computing Toolbox

    % list all datafiles in the data folder
    dataFiles = dir(fullfile(dataFilePath,'*.csv'));
    % set up parallel pool (limited to max. 4 cores)
    poolSize = min(4,numel(dataFiles));
    delete(gcp('nocreate'));
    parpool("Processes",poolSize);
    % set up log and parameter folder 
    if ~exist(fullfile(pwd,"outputFiles","log"),"dir")
        mkdir(fullfile(pwd,"outputFiles","log"));
    end
    if ~exist(fullfile(pwd,"outputFiles","params"),"dir")
        mkdir(fullfile(pwd,"outputFiles","params"));
    end
    dt = datetime("now");
    startMsg = ['Task timestamp is: ', char(dt)];    
    dt = datetime(dt,Format="uuuuMMdd_HHmmss");
    logFilename = ['log_',char(dt),'.txt'];
    logFilePath = fullfile(pwd,"outputFiles","log",logFilename);
    writecell({startMsg},logFilePath,"WriteMode","append");
    sep = '-----------------------------------------------------------';
    % initiate a table for estimated parameters
    paramsTable = table();
    % start parameter estimation
    tic    
    parfor i = 1:length(dataFiles)
        % travese through all data files
        filename = dataFiles(i).name;
        filepath = fullfile(dataFilePath,filename);
        % call the generated deployable function from Parameter Estimator
        % in Simulink
        [pOpt,Info] = parameterEstimation_spe_servomotor_run(filepath);
        % organize optimization information for log file
        msg = [num2str(i),' - Estimate model parameters based on data file ',filename,':'];
        writecell({sep;msg},logFilePath,"WriteMode","append"); 
        msg1 = ['Number of iterations = ',num2str(Info.SolverOutput.output.iterations)];
        msg2 = ['First-order-optimality = ',num2str(Info.SolverOutput.output.firstorderopt)];
        msg3 = Info.SolverOutput.output.message;
        optimMessage = {msg1;msg2;msg3};
        writecell(optimMessage,logFilePath,"WriteMode","append");
        % organize the updated parameters into a predefined table
        appendData = table();
        for ct = 1:numel(pOpt)
            variableName = pOpt(ct).Name;
            value = pOpt(ct).Value;
            appendData{1,variableName} = value;
        end
        paramsTable = [paramsTable;appendData];
    end
    t = toc;
    % output messages to the log file 
    msg = ['Total elapsed time is ', num2str(t),' seconds.'];
    writecell({sep;msg},logFilePath,"WriteMode","append");
    outputFilename = ['updatedParameters_',char(dt),'.csv'];
    outputFilePath = fullfile(pwd,"outputFiles","params",outputFilename);
    % save the updated parameters as csv file 
    writetable(paramsTable,outputFilePath);
end