function options = gpops2_set(varargin)
%{
	gpops2_set('Name1', 'Value1', 'Name2', 'Value2',...) creates an
	options structure OPTIONS in which the named properties have the
	specified values. The syntax is similar to that of odeset.

    integral --- The parameter determines whether the program uses a 
        "integral" or not. The possible values are "off" or "on".

    path --- The parameter determines whether the path constraints
        are involved. The possible values are "off" or "on".

    event --- The parameter determines whether the event constraints
        are involved. The possible values are "off" or "on".

    probname --- The parameter gives the name of the problem. It
    corresponds to the parameter "setup.name".

    solver --- The parameter gives the NLP solver of the problem. The possible
    solver can be "ipopt" or "snopt". It corresponds to the parameter
    "setup.nlp.solver".

    supplier --- The parameter gives the derivatives supplier. The possible
    supplier can be "sparseCD", "sparseFD" or "sparseBD". It corresponds
    to the parameter "setup.derivatives.supplier".

    derivativelevel --- The parameter gives the derivative level. The
    possible level can be "first" or "second". It corresponds to the parameter
    "setup.derivatives.derivativelevel".

    dependencies --- The parameter how the dependencies are found. The
    possible dependencies can be "full", "sparse" or "sparseNaN". It
    corresponds to the parameter "setup.derivatives.dependencies".

    scales --- a structure that specifies the type of scaling to be used
    when solving the problem. The possible values are "none" or 
    "automatic-bounds". It corresponds to the parameter "setup.scales".

    meshmethod --- It specifies the particular mesh refinement method
    to be used. The possible values are "hp" or "hp1". It corresponds to
    the parameter "setup.mesh.method".

    tolerance --- The parameter contains the desired accuracy tolerance
    of the mesh. It should between 0 and 1. It corresponds to the parameter
    "setup.mesh.tolerance".

    maxiteration --- The parameter contains the maximum number of allowed
    mesiterations. It should be a positive integer. It corresponds to the
    parameter "setup.mesh.options.maxiteration".
    
%}

Names = [
    'integral       '
    'path           '
    'event          '
    'probname       '
    'solver         '
    'supplier       '
    'derivativelevel'
    'dependencies   '
    'scales         '
    'meshmethod     '
    'tolerance      '
    'maxiteration   '
];

default = {
    'off' ;
    'off' ;
    'off' ;
    'Untitled' ;
    'ipopt';
    'sparseFD';
    'first';
    'sparseNaN';
    'none';
    'hp1';
    1e-3;
    10;
};

m = size(Names,1);
names = lower(Names);

options = [];
for j = 1:m
  options.(deblank(Names(j,:))) = default{j};
end

i = 1;
while i <= nargin
  arg = varargin{i};
  if ischar(arg) || (isstring(arg) && isscalar(arg)) % arg is an option name
    break;
  end
  if ~isempty(arg)                      % [] is a valid options argument
    if ~isa(arg,'struct')
        error(message('MATLAB:odeset:NoPropNameOrStruct', i));
    end
    for j = 1:m
      if any(strcmp(fieldnames(arg),deblank(Names(j,:))))
        val = arg.(deblank(Names(j,:)));
      else
        val = [];
      end
      if ~isempty(val)
        options.(deblank(Names(j,:))) = val;
      end
    end
  end
  i = i + 1;
end

% Convert string arguments and options.
for ii = 1:nargin
    if isstring(varargin{ii}) && isscalar(varargin{ii})
        varargin{ii} = char(varargin{ii});
    end
end

% A finite state machine to parse name-value pairs.
if rem(nargin-i+1,2) ~= 0
  error(message('MATLAB:odeset:ArgNameValueMismatch'));
end
expectval = 0;                          % start expecting a name, not a value
while i <= nargin
  arg = varargin{i};
    
  if ~expectval
    if ~ischar(arg)
      error(message('MATLAB:odeset:NoPropName', i));
    end
    
    lowArg = lower(arg);
    j = strmatch(lowArg,names);
    if isempty(j)                       % if no matches
      error(message('MATLAB:odeset:InvalidPropName', arg));
    elseif length(j) > 1                % if more than one match
      % Check for any exact matches (in case any names are subsets of others)
      k = strmatch(lowArg,names,'exact');
      if length(k) == 1
        j = k;
      else
            matches = deblank(Names(j(1),:));
        for k = j(2:length(j))'
                matches = [matches ', ' deblank(Names(k,:))]; %#ok<AGROW>
        end
            error(message('MATLAB:odeset:AmbiguousPropName',arg,matches));
      end
    end
    expectval = 1;                      % we expect a value next
    
  else
    options.(deblank(Names(j,:))) = arg;
    expectval = 0;
      
  end
  i = i + 1;
end

end