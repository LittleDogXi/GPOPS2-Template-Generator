function check_options(option)
%{
    Check if the properties of the option are valid
%}

% Names = [
%     'integral       '
%     'path           '
%     'event          '
%     'probname       '
%     'solver         '
%     'supplier       '
%     'derivativelevel'
%     'dependencies   '
%     'scales         '
%     'meshmethod     '
%     'tolerance      '
%     'maxiteration   '
% ];

% default = {
%     'off' ;
%     'off' ;
%     'off' ;
%     'Untitled' ;
%     'ipopt';
%     'sparseFD';
%     'first';
%     'sparseNaN';
%     'none';
%     'hp1';
%     1e-3;
%     10;
% };

if ~( isstring(option.integral) ||  ischar(option.integral) )
    error('The property "integral" must be a string or a char array.');
else
    if ~(strcmp(option.integral, 'on') || strcmp(option.integral, 'off'))
        error('The property "integral" can either be "on" or "off".');
    end
end

if ~( isstring(option.path) ||  ischar(option.path) )
    error('The property "path" must be a string or a char array.');
else
    if ~(strcmp(option.path, 'on') || strcmp(option.path, 'off'))
        error('The property "path" can either be "on" or "off".');
    end
end

if ~( isstring(option.event) ||  ischar(option.event) )
    error('The property "event" must be a string or a char array.');
else
    if ~(strcmp(option.event, 'on') || strcmp(option.event, 'off'))
        error('The property "event" can either be "on" or "off".');
    end
end

if ~( isstring(option.probname) ||  ischar(option.probname) )
    error('The property "probname" must be a string or a char array.');
end

if ~( isstring(option.solver) ||  ischar(option.solver) )
    error('The property "solver" must be a string or a char array.');
else
    if ~(strcmp(option.solver, 'ipopt') || strcmp(option.solver, 'snopt'))
        error('The property "solver" can either be "ipopt" or "snopt".');
    end
end

if ~( isstring(option.supplier) ||  ischar(option.supplier) )
    error('The property "supplier" must be a string or a char array.');
else
    if ~(strcmp(option.supplier, 'sparseFD') ...
            || strcmp(option.supplier, 'sparseBD')...
            || strcmp(option.supplier, 'sparseCD'))
        error('The property "supplier" can either be "sparseFD", "sparseBD" or "sparseCD".');
    end
end

if ~( isstring(option.derivativelevel) ||  ischar(option.derivativelevel) )
    error('The property "derivativelevel" must be a string or a char array.');
else
    if ~(strcmp(option.derivativelevel, 'first') || strcmp(option.derivativelevel, 'second'))
        error('The property "derivativelevel" can either be "first" or "second".');
    end
end

if ~( isstring(option.dependencies) ||  ischar(option.dependencies) )
    error('The property "dependencies" must be a string or a char array.');
else
    if ~(strcmp(option.dependencies, 'full') ...
            || strcmp(option.dependencies, 'sparse')...
            || strcmp(option.dependencies, 'sparseNaN'))
        error('The property "dependencies" can either be "full", "sparse" or "sparseNaN".');
    end
end

if ~( isstring(option.scales) ||  ischar(option.scales) )
    error('The property "scales" must be a string or a char array.');
else
    if ~(strcmp(option.scales, 'none') || strcmp(option.scales, 'automatic-bounds'))
        error('The property "scales" can either be "none" or "automatic-bounds".');
    end
end

if ~( isstring(option.meshmethod) ||  ischar(option.meshmethod) )
    error('The property "meshmethod" must be a string or a char array.');
else
    if ~(strcmp(option.meshmethod, 'hp') || strcmp(option.meshmethod, 'hp1'))
        error('The property "meshmethod" can either be "hp" or "hp1.');
    end
end

if ~isscalar(option.tolerance) ||  ~isreal(option.tolerance) ...
        || ~( 0 < option.tolerance && option.tolerance <=1 )
    error('The property "tolerance" must be a postive number between 0 and 1')
end

if ~isscalar(option.maxiteration) || ceil(option.maxiteration) ~= floor(option.maxiteration) ...
        || ~( 0 < option.maxiteration )
    error('The property "maxiteration" must be a postive integer')
end

end