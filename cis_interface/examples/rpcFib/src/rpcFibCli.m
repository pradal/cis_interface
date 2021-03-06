
function rpcFibCli(iterations)
  
  iterations = str2num(iterations);
  fprintf('Hello from Matlab rpcFibCli: iterations = %d\n', iterations);

  % Set up connections matching yaml
  % RPC client-side connection will be $(server_name)_$(client_name)
  ymlfile = CisInterface('CisInput', 'yaml_in');
  rpc = CisInterface('CisRpcClient', 'rpcFibSrv_rpcFibCli', '%d', '%d %d');
  log = CisInterface('CisOutput', 'output_log');

  % Read entire contents of yaml
  [ret, ycontent] = ymlfile.recv();
  if (~ret);
    disp('rpcFibCli(M): RECV ERROR');
    exit(-1);
  end
  fprintf('rpcFibCli: yaml has %d lines\n', ...
	  length(strsplit(ycontent, '\n', 'CollapseDelimiters', false)));

  for i = 1:iterations
    
    % Call the server and receive response
    fprintf('rpcFibCli(M):  fib(->%-2d) ::: ', i);
    [ret, fib] = rpc.call(i);
    if (~ret);
      disp('rpcFibCli(M): RPC CALL ERROR');
      exit(-1);
    end

    % Log result by sending it to the log connection
    s = sprintf('fib(%2d<-) = %-2d<-\n', fib{1}, fib{2});
    fprintf(s);
    ret = log.send(s);
    if (~ret);
      disp('rpcFibCli(M): SEND ERROR');
      exit(-1);
    end
  end

  disp('Goodbye from Matlab rpcFibCli');
  exit(0);
  
end




